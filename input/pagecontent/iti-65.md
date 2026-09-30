This section describes the additional requirements for the Swiss EPR of the [Provide Document Bundle
[ITI-65]](https://profiles.ihe.net/ITI/MHD/ITI-65.html) transaction defined in the MHD Profile published in the IHE ITI 
Trial Implementation “Mobile Access to Health Documents”.

### Scope

In the Swiss EPR the transaction is used by the MHD Document Source to store documents in the EPR.

### Actor Roles

**Actor:** Document Source  
**Role:** Sends documents and metadata to the Document Recipient.  
**Actor:** Document Recipient  
**Role:** Accepts the document and metadata sent from the Document Source.  

### Referenced Standards

1. [Mobile access to Health Documents (MHD), Rev. {{site.data.fhir.ver.ihemhdfhir | split: "/" | last}}]({{site.data.fhir.ver.ihemhdfhir}})  
2. This MHD Profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include MHD_ActorDiagram_ITI-65.svg %}</div>

#### Provide Document Bundle Request Message

The FHIR `Bundle.meta.profile` shall have the following value:

`https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Minimal.ProvideBundle`

The additional Swiss EPR metadata is defined with:

* [DeletionStatus](#deletionstatus) (Annex 5.1 1.2.4.1)
* [SubmissionSet.Author.AuthorRole](#submissionsetauthorauthorrole) (Annex 5.1 1.2.4.3)
* [DocumentEntry.originalProviderRole ](#documententryoriginalproviderrole) (Annex 5.1 1.2.4.4)

The request Bundle SHALL follow the [CH MHD Provide Document Bundle](StructureDefinition-ch-mhd-providedocumentbundle.html)
Profile ([example: Bundle: BundleProvideDocument](Bundle-BundleProvideDocument.html)).

The `DocumentReference.content.attachment.url` value SHALL point to the resource carrying the document content, which
SHALL be included in the Bundle: a Binary resource, or the FHIR document Bundle resource for a FHIR document published
with the [ITI-65 FHIR Documents Publish Option](#publishing-a-fhir-document) (see
[Resolving references in Bundles](https://hl7.org/fhir/R4/bundle.html#references) for how to create a valid reference).

##### Publishing a FHIR document

The Document Source and the Document Recipient SHALL support the ITI-65 FHIR Documents Publish Option (see
[Actor options](iti-mhd.html#actor-options)). A FHIR document is published as the FHIR document Bundle resource itself,
carried in the entry of the Provide Document Bundle, and is not converted to a base64 encoded Binary
resource. `DocumentReference.content.attachment.url` points to that Bundle resource, `contentType` is
`application/fhir+json` or `application/fhir+xml`, and `size` and `hash` SHALL be absent.

The document is retrieved as a native FHIR document Bundle resource as well, see
[ITI-68](iti-68.html#expected-actions).

Example: [Provide Document Bundle for a FHIR document](Bundle-BundleProvideFhirDocument.html).

##### Correction of a published document

To correct a document (see the use case [Correction of a published document by a healthcare
professional](iti-mhd.html#use-cases)), the Document Source publishes the corrected document and points with
`DocumentReference.relatesTo` of type `replaces` to the document it corrects. The Document Recipient SHALL set the
`status` of the replaced document to `superseded` and SHALL keep it accessible: a superseded document is no longer
returned when searching for the current documents, but it can still be found with the `status` search parameter in
[ITI-67](iti-67.html) and retrieved with [ITI-68](iti-68.html).

Examples: [Provide Document Bundle for a corrected document](Bundle-BundleProvideDocumentCorrection.html), which
replaces the document [DocRefPdf](DocumentReference-DocRefPdf.html), and the replaced document
[as returned by the Document Responder after the correction](DocumentReference-DocRefPdfSuperseded.html), with the
`status` `superseded`.

##### DeletionStatus

The optional metadata about the DeletionStatus of the document is represented in the DocumentReference using the
extension with the URL [http://fhir.ch/ig/ch-health-dossier/StructureDefinition/ch-ext-deletionstatus](StructureDefinition-ch-ext-deletionstatus.html).
The values are defined in the ValueSet [DocumentEntry.Ext.EprDeletionStatus](http://fhir.ch/ig/ch-term/ValueSet/DocumentEntry.Ext.EprDeletionStatus).

##### SubmissionSet.Author.AuthorRole

The SubmissionSet.Author element MAY be used to track the user who made the latest changes to the document metadata.
If present, the value of the AuthorRole attribute SHALL be taken from the value set
[CH Health Dossier Author Role](ValueSet-HealthDossierAuthorRole.html). The required metadata about the AuthorRole of
the Author is represented in the List for the SubmissionSet using the extension with the URL [http://fhir.ch/ig/ch-health-dossier/StructureDefinition/ch-ext-author-authorrole](StructureDefinition-ch-ext-author-authorrole.html).

##### DocumentEntry.originalProviderRole

An extra metadata attribute SHALL be used to distinguish documents originally provided by patients, their
representatives or legal representatives from documents originally provided by healthcare professionals, assistants,
technical users or the administration. The extra metadata attribute SHALL be set by the Document Source actor to the
role value of the current user. It SHALL NOT be changed with
[Update Document Metadata [CH:MHD-1]](ch-mhd-1.html#metadata-which-may-be-updated), and the Document Responder rejects
such a request with an UnmodifiableMetadataError. The required metadata about the originalProviderRole of the Author is
represented in the DocumentReference using the extension with the URL
[http://fhir.ch/ig/ch-health-dossier/StructureDefinition/ch-ext-author-authorrole](StructureDefinition-ch-ext-author-authorrole.html).
The values are defined in the value set [CH Health Dossier Author Role](ValueSet-HealthDossierAuthorRole.html).

#### Provide Document Bundle Response Message

The response Bundle SHALL follow the [CH MHD Provide Document Bundle Response](StructureDefinition-ch-mhd-providedocumentbundle-response.html)
Profile ([example: Bundle: BundleProvideDocument-Response](Bundle-BundleProvideDocument-Response.html)).

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Document Source** is [MHD Document Source](CapabilityStatement-CH.MHD.DocumentSource.html).

The CapabilityStatement resource for the **Document Recipient** is [MHD Document Recipient](CapabilityStatement-CH.MHD.DocumentRecipient.html).

### Security Consideration

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with 
server certificates. 

The transaction SHALL use client authentication and authorization using an extended access token defined in [IUA](iti-71.html) conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.

For every Provide Document Bundle [ITI-65] request, the Document Recipient SHALL enforce the access rules of the
patient and of the requesting health professional or health institution, as described in [Appendix: Enforcement of Access Rules](accesscontrol.html).
The Document Recipient SHALL reject the request if the requester is not authorized to record data in the health
dossier of the patient concerned, or if the patient has declared that the data of the treatment concerned shall not
be recorded in their health dossier.

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).

#### Security Audit Considerations

##### Document Source Audit

The **Document Source** SHALL record an audit event according to
[CH Audit Event for [ITI-65] Document Source](StructureDefinition-ChAuditEventIti65Source.html) 
([example](AuditEvent-ChAuditEventIti65SourceExample.html)).

##### Document Recipient Audit

The **Document Recipient** SHALL record an audit event according to
[CH Audit Event for [ITI-65] Document Recipient](StructureDefinition-ChAuditEventIti65Recipient.html)
([example](AuditEvent-ChAuditEventIti65RecipientExample.html)).
