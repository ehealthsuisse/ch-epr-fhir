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

[Mobile access to Health Documents (MHD) With XDS on FHIR Rev. 3.1 – 2019-03-06](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_MHD.pdf)   

This MHD Profile is based on Release 4 of the emerging [HL7® FHIR®](https://www.hl7.org/fhir/index.html) standard.

### Messages

{% include img.html img="MHD_ActorDiagram_ITI-65.plantuml.png" width="40%" %}

### Trigger Events

This method is invoked when the Document Source needs to submit one or more documents to a Document
Recipient.

### Message Semantics
The same message semantics as for 3.65.4.1.2 Message Semantics applies. The FHIR `Bundle.meta.profile` shall have the following value:   

`http://ihe.net/fhir/StructureDefinition/IHE_MHD_Provide_Comprehensive_DocumentBundle`

In addition the following extensions have been defined for the Swiss EPR additional metadata:

* [SubmissionSet.Author.AuthorRole](#submissionsetauthorauthorrole) (Annex 5.1 1.2.4) on the DocumentManifest
* [DeletionStatus](#deletionstatus) (Annex 5.1 1.2.4) on the DocumentReference

#### SubmissionSet.Author.AuthorRole   
The required metadata about the AuthorRole of the Author is represented in the DocumentManifest using the extension with the URL [http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/ch-ext-author-authorrole](StructureDefinition-ch-ext-author-authorrole.html). The values are definded in the ValueSet [SubmissionSet.Author.AuthorRole](http://fhir.ch/ig/ch-epr-term/ValueSet/SubmissionSet.Author.AuthorRole).

#### DeletionStatus   
The optional metadata about the DeletionStatus of the document is represented in the DocumentReference using the extension with the URL [http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/ch-ext-deletionstatus](StructureDefinition-ch-ext-deletionstatus.html). The values are defined int the ValueSet [ch-ehealth-valueset-deletionstatus](ValueSet-ch-ehealth-valueset-deletionstatus.html).


### Message Example

See [Bundle example](Bundle-2-7-BundleProvideDocument.html) (and the corresponding [profile](StructureDefinition-ch-mhd-providedocumentbundle-comprehensive.html)) for the Provide Document Bundle **request**.   
See [Bundle example](Bundle-2-7-BundleProvideDocument-Response.html) (and the corresponding [profile](StructureDefinition-ch-mhd-providedocumentbundle-comprehensive-response.html)) for the Provide Document Bundle **response**.

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Patient Identity Manager using IUA profile with basic access token. Consequently
the Provide Document Bundle [ITI-65] request must authorize using the Incorporate Authorization Token [ITI-
72] transaction of the IUA profile.