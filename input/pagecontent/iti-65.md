This section describes the **additional requirements** for the Swiss EPR of the Provide Document Bundle [ITI-
65] transaction defined in the MHD Profile published in the IHE ITI Trial Implementation “Mobile Access to
Health Documents”.

### Scope

In the Swiss EPR the transaction is used by the MHD Document Source to store documents in the EPR.

### Actor Roles

**Actor:** Document Source
**Role:** Sends documents and metadata to the Document Recipient.
**Actor:** Document Recipient
**Role:** Accepts the document and metadata sent from the Document Source.

### Referenced Standards

[Mobile access to Health Documents (MHD), 2021-03-31, public comment release](https://profiles.ihe.net/ITI/MHD/4.0.0-comment/)   

This MHD Profile is based on Release 4 of the [HL7® FHIR®](https://www.hl7.org/fhir/index.html) standard.

### Messages

<div>{% include MHD_ActorDiagram_ITI-65.svg %}</div>

### Trigger Events

This method is invoked when the Document Source needs to submit one or more documents to a Document
Recipient.

### Message Semantics
The same message semantics as for 3.65.4.1.2 Message Semantics applies. The FHIR `Bundle.meta.profile` shall have the following value:   

`http://ihe.net/fhir/StructureDefinition/IHE_MHD_Provide_Comprehensive_DocumentBundle`

The additional Swiss EPR metadata is defined with:

* [DeletionStatus](#deletionstatus) (Annex 5.1 1.2.4.1)
* [SubmissionSet.Author.AuthorRole](#submissionsetauthorauthorrole) (Annex 5.1 1.2.4.3)
* [DocumentEntry.originalProviderRole ](#documentEntryoriginalproviderrole) (Annex 5.1 1.2.4.4)

#### DeletionStatus   
The optional metadata about the DeletionStatus of the document is represented in the DocumentReference using the extension with the URL [http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/ch-ext-deletionstatus](StructureDefinition-ch-ext-deletionstatus.html). The values are defined int the ValueSet [ch-ehealth-valueset-deletionstatus](ValueSet-ch-ehealth-valueset-deletionstatus.html).
#### SubmissionSet.Author.AuthorRole   
The SubmissionSet.Author element MAY be used to track the user who made the latest changes to the document metadata. If present, the value of the AuthorRole attribute SHALL be taken from the SubmissionSet.Author.AuthorRole value set with the OID 2.16.756.5.30.1.127.3.10.1.41. The required metadata about the AuthorRole of the Author is represented in the List for the SubmissionSet using the extension with the URL [http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/ch-ext-author-authorrole](StructureDefinition-ch-ext-author-authorrole.html). The values are defined in the ValueSet [SubmissionSet.Author.AuthorRole](http://fhir.ch/ig/ch-epr-term/ValueSet/SubmissionSet.Author.AuthorRole).

#### DocumentEntry.originalProviderRole   
An extra metadata attribute SHALL be used to distinguish document originally provided by patients or their representatives from documents originally provided by healthcare professionals, assistants, technical users or document administrators. The extra metadata attribute SHALL be set by the Document Source actor to the role value of the current user and SHALL NOT be updated by Update Initiator or Document Administrator actors. The required metadata about the originalProviderRole of the Author is represented in the DocumentReference using the extension with the URL [http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/ch-ext-author-authorrole](StructureDefinition-ch-ext-author-authorrole.html). The values are defined in the ValueSet [DocumentEntry.originalProviderRole](http://fhir.ch/ig/ch-epr-term/ValueSet/DocumentEntry.originalProviderRole).


### Message Example

See [Bundle example](Bundle-2-7-BundleProvideDocument.html) (and the corresponding [profile](StructureDefinition-ch-mhd-providedocumentbundle-comprehensive.html)) for the Provide Document Bundle **request**.   
See [Bundle example](Bundle-2-7-BundleProvideDocument-Response.html) (and the corresponding [profile](StructureDefinition-ch-mhd-providedocumentbundle-comprehensive-response.html)) for the Provide Document Bundle **response**.

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Document Recipient using IUA profile with extended access token. Consequently
the Provide Document Bundle [ITI-65] request must authorize using the Incorporate Access Token [ITI-
72] transaction of the IUA profile.