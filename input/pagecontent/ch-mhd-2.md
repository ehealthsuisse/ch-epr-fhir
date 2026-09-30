This section corresponds to transaction [CH:MHD-2]. Transaction [CH:MHD-2] is used by the Document Source and Document Responder Actors.

### Scope

The Purge Document [CH:MHD-2] transaction is used by the Document Source to irrevocably remove a document, with all
versions of its metadata, from the health dossier of a patient.

### Actor Roles

**Actor:** Document Source   
**Role:** Requests the purge of a document   
**Actor:** Document Responder    
**Role:** Removes the document with its metadata and responds with the outcome of the purge    

### Referenced Standards

1. [Mobile access to Health Documents (MHD), Rev. 4.2.3 – Trial-Implementation, 2025-10-31](https://profiles.ihe.net/ITI/MHD/index.html)
2. This MHD Profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.
3. [FHIR Operations](https://hl7.org/fhir/R4/operations.html).

### Messages

<div>{% include MHD_ActorDiagram_CH-2.svg %}</div>

#### Purge Document Request Message

The Purge Document Request Message requests the irrevocable removal of a document from the health dossier of a patient.

##### Trigger Events

The Purge Document Request Message is triggered when a document has to be deleted from the health dossier:

- a healthcare professional or a health institution has published the document in the health dossier of the wrong
  person (see the use case [Healthcare professional deletes a document published for the wrong person](iti-mhd.html#use-cases));
- the patient, or a person acting on their behalf, deletes a document (see the use case
  [Patient deletes a document](iti-mhd.html#use-cases)).

##### Message Semantics

The Document Source invokes the [CH MHD $purge](OperationDefinition-CHMhdPurge.html) operation on the
DocumentReference of the document to be deleted:

```
POST [base]/DocumentReference/[id]/$purge
```

The operation has no input parameters and the request has no body. The operation is synchronous: the Document
Responder processes the request completely before it responds.

The operation SHALL be invoked as a standalone HTTP request, it SHALL NOT be part of a batch or transaction Bundle.

##### Roles which may purge a document

{:class="table table-bordered"}
| Roles                          | Documents which may be purged                                                                 |
|--------------------------------|-----------------------------------------------------------------------------------------------|
| `PAT`, `REP`, `LEGREP`, `ADM`  | Any document of the health dossier, the ones recorded by the patient as well as the ones published by a healthcare professional or a health institution |
| `HCP`, `ASS`, `TCU`            | The documents published by the healthcare professional, or by the health institution, on whose behalf the request is made (`DocumentReference.author`) |

<figcaption ID="1">Table 1: Roles which may purge a document.</figcaption>

<br/>

The roles are the ones of the [CH Health Dossier Role](CodeSystem-HealthDossierRole.html) code system, conveyed in the
access token of the requester (see [Get Access Token [ITI-71]](iti-71.html)).

##### Example

```http
POST [base]/DocumentReference/DocRefPdf/$purge HTTP/1.1
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00

```

##### Expected Actions

The Document Responder shall provide a [CapabilityStatement](CapabilityStatement-CH.MHD.DocumentResponder.html) with
the capabilities interaction and indicate that the operation `purge` is available on the DocumentReference.

The Document Responder SHALL process the Purge Document Request Message as follows:

1. Verify that the DocumentReference exists and that the requester is allowed to access it, as described in
   [Security Consideration](#security-consideration). If the DocumentReference does not exist, or the requester is not
   allowed to access it, respond with HTTP `404 Not Found`. The response SHALL NOT disclose whether a document the
   requester is not allowed to access exists.
2. Verify that the requester is allowed to purge the document, as described in
   [Roles which may purge a document](#roles-which-may-purge-a-document). If the requester is allowed to access the
   document but not to purge it, e.g. a healthcare professional who is not the author of the document, respond with
   HTTP `403 Forbidden` and an OperationOutcome with the issue code `forbidden`
   ([example](OperationOutcome-MhdOperationOutcomeErrorPurgeForbidden.html)).
3. Remove the DocumentReference with all its versions. A logical delete, which keeps the version history, is not sufficient.
4. Remove the document referenced in `DocumentReference.content.attachment.url`, the Binary or the FHIR document Bundle.
5. Remove the references to the DocumentReference from other resources held by the Document Responder, e.g. the entry
   in the [SubmissionSet](StructureDefinition-ch-mhd-submissionset.html) the document was published with.

Any error that occurs during the processing SHALL cause the entire request to fail, nothing is removed and the Document
Responder returns the status and the error in its response message.

After a successful purge the document and its metadata SHALL NOT be accessible anymore: a read of the DocumentReference
or of the document responds with HTTP `404 Not Found`, and the DocumentReference is not returned by
[Find Document References [ITI-67]](iti-67.html). A repeated purge of the same document therefore responds with
HTTP `404 Not Found`.

Documents which refer to the purged document with `DocumentReference.relatesTo`, e.g. a new version replacing it, are not
purged, their reference to the purged document can no longer be resolved.

Audit events recorded for the document, including the audit events of this transaction, SHALL NOT be purged.

#### Purge Document Response Message

On success, the Document Responder SHALL respond with HTTP `200 OK` and an OperationOutcome with an issue of severity
`information` and code `informational`:

{% fragment OperationOutcome/MhdOperationOutcomePurgeSuccess JSON %}

On failure, the Document Responder SHALL respond with the HTTP status code as described in
[Expected Actions](#expected-actions) and an OperationOutcome describing the error.

### Security Consideration

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with server certificates. 

The transaction SHALL use client authentication and authorization using an extended access token defined in [IUA](iti-71.html) conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.

For every Purge Document [CH:MHD-2] request, the Document Responder SHALL enforce the access rules of the patient and of
the requesting health professional or health institution, as described in
[Appendix: Enforcement of Access Rules](accesscontrol.html) and in
[Roles which may purge a document](#roles-which-may-purge-a-document). The Document Responder SHALL reject the request
if the requester is not authorized to purge the document concerned.

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).

#### Security Audit Considerations

##### Document Source Audit

The **Document Source** SHALL record an audit event according to
[CH Audit Event for [CH:MHD-2] Document Source](StructureDefinition-ch-mhd-purgedocument-audit-source.html)
([example](AuditEvent-ChAuditEventChMhd2SourceExample.html)).

##### Document Responder Audit

The **Document Responder** SHALL record an audit event according to
[CH Audit Event for [CH:MHD-2] Document Responder](StructureDefinition-ch-mhd-purgedocument-audit-responder.html)
([example](AuditEvent-ChAuditEventChMhd2ResponderExample.html)).
