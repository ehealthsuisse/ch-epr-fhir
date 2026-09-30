This section corresponds to transaction [CH:MHD-1]. Transaction [CH:MHD-1] is used by the Document Source and Document Responder Actors. 

### Scope

The Update Document Metadata [CH:MHD-1] transaction is used to update document metadata from the Document Source to the Document Responder.

### Actor Roles

**Actor:** Document Source   
**Role:** Prepares and issues an update to a DocumentReference resource   
**Actor:** Document Responder    
**Role:** Accepts requests for updates to a DocumentReference resource    

### Referenced Standards

1. [Mobile access to Health Documents (MHD), Rev. 4.2.3 – Trial-Implementation, 2025-10-31](https://profiles.ihe.net/ITI/MHD/index.html) 
2. This MHD Profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include MHD_ActorDiagram_CH-1.svg %}</div>

#### Update Document Metadata Request Message

The Update Document Metadata Request Message provides the ability to submit updated attributes for DocumentReference resources.

##### Trigger Events

The Update Document Metadata Request Message is triggered when a Document Source needs to transmit updated DocumentReference metadata.

##### Message Semantics

A Document Source initiates a FHIR request using Update as defined at [http://hl7.org/fhir/http.html#update](http://hl7.org/fhir/http.html#update) on DocumentReference Resources, with a standalone HTTP request or a [transaction](https://hl7.org/fhir/R4/http.html#transaction).



A Document Source shall send a request for either the JSON or the XML format as defined in FHIR. A Document Responder shall support the JSON and the XML format.

The Document Source shall be capable of accepting elements specified in profile [CH MHD DocumentReference](StructureDefinition-ch-mhd-documentreference.html).

The [Mappings tab](StructureDefinition-ch-mhd-documentreference-mappings.html) indicates the mapping between DocumentReference elements and the XDS elements.

##### Metadata which may be updated

Only the metadata listed below may be updated with this transaction, and only by the roles listed for it. Every other
change of the metadata requires a new version of the document to be published with
[ITI-65](iti-65.html#correction-of-a-published-document).

{:class="table table-bordered"}
| Metadata            | Element                                                              | Roles                             |
|---------------------|----------------------------------------------------------------------|-----------------------------------|
| Confidentiality code | `DocumentReference.securityLabel`                                    | `PAT`, `REP`, `LEGREP`, `ADM`     |
| Personal note        | extension [PersonalNote](StructureDefinition-ch-ext-personalnote.html)   | `PAT`, `REP`, `LEGREP`, `ADM` |

<figcaption ID="1">Table 1: Metadata which may be updated, and the roles which may update it.</figcaption>

The roles are the ones of the [CH Health Dossier Role](CodeSystem-HealthDossierRole.html) code system, conveyed in the
access token of the requester (see [Get Access Token [ITI-71]](iti-71.html)). The Document Responder SHALL reject a
request which updates other metadata, or metadata which the role of the requester is not allowed to update, with an
OperationOutcome with the error code
[UnmodifiableMetadataError](OperationOutcome-MhdOperationOutcomeErrorUnmodifiableMetadataError.html).

##### Recording a personal note

A patient can record a personal note on a document (see use case [Patient adds a personal note to a document](iti-mhd.html#use-cases)). The Document Source records the note by updating
the metadata of the document and adding a [PersonalNote](StructureDefinition-ch-ext-personalnote.html) extension, which
carries the text of the note, the patient it belongs to and the time it was recorded. The document itself and its data
stay unchanged and no new version of the document is published. 

A document carries at most one personal note. Recording a note on a document which already has one replaces the
existing note.

Example ([DocumentReference with a personal note](DocumentReference-DocRefPdfPersonalNote.html)):

```http
PUT [base]/DocumentReference/DocRefPdf HTTP/1.1
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00

```
{% fragment DocumentReference/DocRefPdfPersonalNote JSON %}

##### Example: update of the confidentiality code

```http
PUT [base]/DocumentReference/DocRefPdf HTTP/1.1
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00

```
{% fragment DocumentReference/DocRefPdf JSON %}



##### Expected Actions

The Document Responder shall provide a [CapabilityStatement](CapabilityStatement-CH.MHD.DocumentResponder.html) with the capabilities interaction and indicate that update is available on the DocumentReference.

The Document Responder shall process the Update Document Metadata Request message and return the updated DocumentReference.

Any error that occurs during the processing of the Update Document Metadata Request message shall cause the entire transaction to fail and 
no change made to the existing DocumentReference. The Document Responder shall return the status and any error codes incurred during the processing of
the request in its response message. 

1. Verify the submitted and existing DocumentReference have the same values for the identifiers. If these values are not identical, an OperationOutcome with the error code [XDSMetadataIdentifierError](OperationOutcome-MhdOperationOutcomeErrorXdsMetadataIdentifier.html) should be returned.
2. Verify the submitted and existing DocumentReference reference the same Patient. If these values are not identical, an OperationOutcome with the error code [XDSPatientIDReconciliationError](OperationOutcome-MhdOperationOutcomeErrorXDSPatientIDReconciliationError.html) should be returned.
3. Check the submitted DocumentReference and determine if it contains only changes to attributes which the role of the requester may update, as described in [Metadata which may be updated](#metadata-which-may-be-updated). If not, an OperationOutcome with the error code [UnmodifiableMetadataError](OperationOutcome-MhdOperationOutcomeErrorUnmodifiableMetadataError.html) SHALL be returned.

##### Response Message
See http://hl7.org/fhir/http.html#update for response.


### Security Consideration

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with server certificates. 

The transaction SHALL use client authentication and authorization using an extended access token defined in [IUA](iti-71.html) conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.

For every Update Document Metadata [CH:MHD-1] request, the Document Responder SHALL enforce the access rules of the
patient and of the requesting health professional or health institution, as described in [Appendix: Enforcement of Access Rules](accesscontrol.html).
The Document Responder SHALL reject the request if the requester is not authorized to update the metadata of the
document concerned.

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).

#### Security Audit Considerations

##### Document Source Audit

The **Document Source** SHALL record an audit event according to
[CH Audit Event for [CH:MHD-1] Document Source](StructureDefinition-ch-mhd-updatedocumentmetadata-audit-source.html)
([example](AuditEvent-ChAuditEventChMhd1SourceExample.html)).

##### Document Responder Audit

The **Document Responder** SHALL record an audit event according to
[CH Audit Event for [CH:MHD-1] Document Responder](StructureDefinition-ch-mhd-updatedocumentmetadata-audit-responder.html)
([example](AuditEvent-ChAuditEventChMhd1ResponderExample.html)).

For a [transaction](StructureDefinition-ch-mhd-1-updatedocumentmetadatatransactionrequest.html) instead of a direct PUT interaction, the actors SHALL also be able to record audit events for each Update Document Metadata Request Message in the Bundle.