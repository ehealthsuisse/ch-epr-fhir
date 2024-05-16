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

1. [Mobile access to Health Documents (MHD), Rev. 4.2.1 – Trial-Implementation,  August 2, 2023](https://profiles.ihe.net/ITI/MHD/index.html)  
2. This MHD Profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include MHD_ActorDiagram_ITI-65.svg %}</div>

#### Provide Document Bundle Request Message

The FHIR `Bundle.meta.profile` shall have the following value:

`https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Comprehensive.ProvideBundle`

The additional Swiss EPR metadata is defined with:

* [DeletionStatus](#deletionstatus) (Annex 5.1 1.2.4.1)
* [SubmissionSet.Author.AuthorRole](#submissionsetauthorauthorrole) (Annex 5.1 1.2.4.3)
* [DocumentEntry.originalProviderRole ](#documententryoriginalproviderrole) (Annex 5.1 1.2.4.4)

The request Bundle SHALL follow the [CH MHD Provide Document Bundle Comprehensive](StructureDefinition-ch-mhd-providedocumentbundle-comprehensive.html)
Profile ([example: Bundle: 2-7-BundleProvideDocument](Bundle-2-7-BundleProvideDocument.html)).

##### DeletionStatus

The optional metadata about the DeletionStatus of the document is represented in the DocumentReference using the
extension with the URL [http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-deletionstatus](StructureDefinition-ch-ext-deletionstatus.html).
The values are defined in the ValueSet [DocumentEntry.Ext.EprDeletionStatus](http://fhir.ch/ig/ch-term/ValueSet/DocumentEntry.Ext.EprDeletionStatus).

##### SubmissionSet.Author.AuthorRole

The SubmissionSet.Author element MAY be used to track the user who made the latest changes to the document metadata.
If present, the value of the AuthorRole attribute SHALL be taken from the SubmissionSet.Author.AuthorRole value set
with the OID `2.16.756.5.30.1.127.3.10.1.41`. The required metadata about the AuthorRole of the Author is represented
in the List for the SubmissionSet using the extension with the URL [http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-author-authorrole](StructureDefinition-ch-ext-author-authorrole.html).
The values are defined in the ValueSet [SubmissionSet.Author.AuthorRole](http://fhir.ch/ig/ch-term/ValueSet/SubmissionSet.Author.AuthorRole).

##### DocumentEntry.originalProviderRole

An extra metadata attribute SHALL be used to distinguish document originally provided by patients or their
representatives from documents originally provided by healthcare professionals, assistants, technical users or document
administrators. The extra metadata attribute SHALL be set by the Document Source actor to the role value of the current
user and SHALL NOT be updated by Update Initiator or Document Administrator actors. The required metadata about the
originalProviderRole of the Author is represented in the DocumentReference using the extension with the URL
[http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-author-authorrole](StructureDefinition-ch-ext-author-authorrole.html).
The values are defined in the ValueSet [DocumentEntry.originalProviderRole](http://fhir.ch/ig/ch-term/ValueSet/DocumentEntry.originalProviderRole).

#### Provide Document Bundle Response Message

The response Bundle SHALL follow the [CH MHD Provide Document Bundle Comprehensive Response](StructureDefinition-ch-mhd-providedocumentbundle-comprehensive-response.html)
Profile ([example: Bundle: 2-7-BundleProvideDocument-Response](Bundle-2-7-BundleProvideDocument-Response.html)).

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Document Source** is [MHD Document Source](CapabilityStatement-CH.MHD.DocumentSource.html).

The CapabilityStatement resource for the **Document Recipient** is [MHD Document Recipient](CapabilityStatement-CH.MHD.DocumentRecipient.html).

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Document Recipient using the IUA profile with extended access token. Consequently
the _Provide Document Bundle_ [ITI-65] request must authorize using the [[ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72)
transaction of the IUA profile.

For the `traceparent` header handling refer to [Trace Context header](tracecontext.html).

#### Security Audit Considerations

##### Document Source Audit

The **Document Source** shall record an
[Audit Event for Provide Bundle Transaction at Source](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.ProvideBundle.Audit.Source.html).
[Audit Example for a Provide Bundle Transaction from source perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditProvideBundle-source.html).

##### Document Recipient Audit

The **Document Recipient** shall record an
[Audit Event for Provide Bundle Transaction at Recipient](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.ProvideBundle.Audit.Recipient.html).
[Audit Example for a Provide Bundle Transaction from recipient perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditProvideBundle-recipient.html).
