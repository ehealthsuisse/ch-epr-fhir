Instance: MhdOperationOutcomeErrorXdsMetadataIdentifier
InstanceOf: OperationOutcome
Title: "MHD OperationOutcome DocumentReference update error identifiers"
Description: "Error OperationOutcome that the updated DocumentReference has not same values for the identifiers"
Usage: #example
* issue[0].severity = #error
* issue[=].code = #processing
* issue[=].details.text = "XDSMetadataIdentifierError"

Instance: MhdOperationOutcomeErrorXDSPatientIDReconciliationError
InstanceOf: OperationOutcome
Title: "MHD OperationOutcome DocumentReference update error patient id reconciliation"
Description: "Error OperationOutcome that the updated DocumentReference references not the same patient"
Usage: #example
* issue[0].severity = #error
* issue[=].code = #processing
* issue[=].details.text = "XDSPatientIDReconciliationError"

Instance: MhdOperationOutcomeErrorUnmodifiableMetadataError
InstanceOf: OperationOutcome
Title: "MHD OperationOutcome DocumentReference update error unmodifiable metadata"
Description: "Error OperationOutcome that the updated DocumentReference changed unmodifiable metadata"
Usage: #example
* issue[0].severity = #error
* issue[=].code = #processing
* issue[=].details.text = "UnmodifiableMetadataError"

Extension: ChMhdHomeCommunityId
Id: ch-mhd-home-community-id
Title: "CH MHD Extension to provide the homeCommunityId"
Description: "This CH MHD extension enables to provide homeCommunityId in an OperationOutcome"
* ^context[+].type = #element
* ^context[=].expression = "OperationOutcome.issue.details"
* . ^short = "CH MHD Extension: homeCommunityId"
* value[x] 1..
* value[x] only Identifier
* valueIdentifier ^short = "Value of the homeCommunityId"

Extension: ChExtDeletionStatus
Id: ch-ext-deletionstatus
Title: "CH Extension Deletion Status"
Description: "Extension Deletion Status for DocumentReference"
Context: DocumentReference
* url only uri
* url MS
* valueCoding 1.. MS
* valueCoding only Coding
* valueCoding from $DocumentEntry.Ext.EprDeletionStatus (required)
* valueCoding ^short = "Value of extension"

Extension: ChExtAuthorAuthorRole
Id: ch-ext-author-authorrole
Title: "CH Extension Author AuthorRole"
Description: "Extension Author AuthorRole for SubmissionSet and DocumentEntry"
Context: List, DocumentReference
* url only uri
* url MS
* valueCoding 1.. MS
* valueCoding only Coding
* valueCoding from $DocumentEntry.originalProviderRole (required)
* valueCoding ^short = "Value of extension"

Profile: CHMhdDocumentReferenceComprehensive
Parent: $ch-core-documentreference
Id: ch-mhd-documentreference-comprehensive
Title: "CH MHD DocumentReference Comprehensive"
Description: "CH MHD Profile on CH Core DocumentReference"
* obeys ch-mhd
* extension contains
     ChExtDeletionStatus named deletionStatus 0..1 MS and
     ChExtAuthorAuthorRole named originalProviderRole 1..1 MS
* extension[deletionStatus] ^short = "Deletion status of the document"
* extension[originalProviderRole] ^short = "Original ProviderRole: This extra metadata attribute SHALL be set by the Document Source actor to the role value of the current user and SHALL NOT be updated by Update Initiator or Document Administrator actors."
* masterIdentifier 1.. MS
* masterIdentifier only $IHE.MHD.UniqueIdIdentifier
* identifier MS
* status MS
* status ^short = "current | superseded"
* status ^comment = "approved -> status=current, deprecated -> status=superseded"
* docStatus ..0
* docStatus ^comment = "These HL7 FHIR elements are not used in XDS, therefore would not be present. Document Consumers should be robust to these elements holding values."
* type 1.. MS
* type ^binding.strength = #required
* category 1..1 MS
* category ^binding.strength = #required
* subject 1.. MS
* subject.identifier 1..1
* subject.identifier only EPRSPIDIdentifier
* subject ^comment = "Not a contained resource. The identifier points to an existing patient in the XDS Affinity Domain."
* author only Reference
* author MS
* author ^comment = "Contained resource."
* author ^type.aggregation = #contained
* authenticator only Reference
* authenticator ^type.aggregation = #contained
* custodian ..0
* relatesTo MS
* relatesTo ^comment = "See ITI TF-2c: 3.65.4.1.2.3"
* description MS
* securityLabel 1.. MS
* securityLabel ^comment = "Note: This is NOT the DocumentReference.meta, as that holds the meta tags for the DocumentReference itself."
* securityLabel ^binding.strength = #required
* content ..1
* content.attachment MS
* content.attachment.contentType 1.. MS
* content.attachment.contentType from $DocumentEntry.mimeType (required)
* content.attachment.language 1.. MS
* content.attachment.language from $DocumentEntry.languageCode (required)
* content.attachment.data ..0
* content.attachment.data ^comment = "These HL7 FHIR elements are not used in XDS, therefore would not be present. Document Consumers should be robust to these elements holding values."
* content.attachment.url 1..1 MS
* content.attachment.url ^short = "The ITI-68 endpoint to use, or a reference to the Binary resource in the Bundle."
* content.attachment.url ^comment = "When providing the document, this URL SHALL point to the Binary resource wrapping
the document content (which SHALL be included in the Bundle). When retrieving the DocumentReference, this URL SHALL
be the the one to use in ITI-68 transactions to retrieve the document content."
* content.attachment.size MS
* content.attachment.hash MS
* content.attachment.title 1..1 MS
* content.attachment.creation 1.. MS
* content.format 1.. MS
* content.format from $DocumentEntry.formatCode (required)
* content.format ^binding.description = "Document Format Codes."
* context 1..
* context.event MS
* context.event from $DocumentEntry.eventCodeList (required)
* context.period MS
* context.facilityType 1.. MS
* context.facilityType from $DocumentEntry.healthcareFacilityTypeCode (required)
* context.facilityType ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
* context.facilityType ^binding.extension.valueString = "DocumentC80FacilityType"
* context.facilityType ^binding.description = "XDS Facility Type."
* context.practiceSetting 1.. MS
* context.practiceSetting from $DocumentEntry.practiceSettingCode (required)
* context.practiceSetting ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
* context.practiceSetting ^binding.extension.valueString = "DocumentC80PracticeSetting"
* context.practiceSetting ^binding.description = "Additional details about where the content was created (e.g. clinical specialty)."
* context.sourcePatientInfo 1.. MS
* context.sourcePatientInfo only Reference($ch-core-patient)
* context.sourcePatientInfo ^comment = "Contained Patient resource with Patient.identifier.use element set to ‘usual’.\r\n\r\nIndicates that the data within the XDS document entry be represented as a contained resource. See Section 4.5.4.4.7"
* context.sourcePatientInfo ^type.aggregation = #contained
* context.related ^slicing.discriminator.type = #value
* context.related ^slicing.discriminator.path = "identifier"
* context.related ^slicing.rules = #open
* context.related ^comment = "May be filled with URL pointers to Resources or Identifiers found in referenceIdList"
* context.related contains
    StudyInstanceUID 0..1 MS
* context.related[StudyInstanceUID].identifier MS
* context.related[StudyInstanceUID].identifier only DicomStudyInstanceUidIdentifier
* context.related[StudyInstanceUID].identifier ^short = "Requirements on XDS-I.b (Swiss context): When a Imaging Document Source provides a document to the Document Repository, it must provide the StudyInstanceUID, found in the to be registered KOS object, in the referenceIdList (urn:ihe:iti:xds:2013:referenceIdList) attribute of the documentEntry metadata."

Invariant: ch-mhd
Description: "The DocumentReference needs to conform to IHE.MHD.Comprehensive.DocumentReference"
* severity = #error
* expression = "conformsTo('https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Comprehensive.DocumentReference')"


Profile: ChFindDocumentReferencesComprehensiveResponse
Parent: Bundle
Id: ch-mhd-documentreference-comprehensive-bundle
Title: "CH MHD Find Document References Comprehensive Response message"
Description: "A profile on the Find Document References Comprehensive Response message for ITI-68"
* type = #searchset (exactly)
* total 1..
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry.fullUrl 1.. MS
* entry.fullUrl obeys ch-mhd-bdl-1

* entry contains 
    DocumentReference 0..* MS and 
    OperationOutcome 0..1
* entry[DocumentReference] ^short = "DocumentReference"
* entry[DocumentReference].resource 1.. MS
* entry[DocumentReference].resource only CHMhdDocumentReferenceComprehensive

* entry[OperationOutcome] ^short = "OperationOutcome"
* entry[OperationOutcome].resource 1..
* entry[OperationOutcome].resource ^type.code = "OperationOutcome"
* entry[OperationOutcome].resource ^type.profile = Canonical(OperationOutcome)

Invariant: ch-mhd-bdl-1
Description: "The fullUrl must be an absolute URL server address or an URI for UUID/OID"
* severity = #error
* expression = "startsWith('http') or startsWith('urn:uuid:') = true"

Profile: CHMhdProvideDocumentBundleComprehensive
Parent: $IHE.MHD.Comprehensive.ProvideBundle
Id: ch-mhd-providedocumentbundle-comprehensive
Title: "CH MHD Provide Document Bundle Comprehensive"
Description: "IHE MHD profile on Provide Document Bundle (ITI-65) transaction with Comprehensive Metadata for the Swiss EPR."
* meta 1..
* meta.profile MS
* meta.profile ^slicing.discriminator.type = #value
* meta.profile ^slicing.discriminator.path = "$this"
* meta.profile ^slicing.rules = #open
* meta.profile contains comprehensiveMetadata 1..1 MS
* meta.profile[comprehensiveMetadata] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Comprehensive.ProvideBundle"
* entry 3..
* entry[SubmissionSet] ^sliceName = "SubmissionSet"
* entry[SubmissionSet] ^mustSupport = true
* entry[SubmissionSet].resource 1.. MS
* entry[SubmissionSet].resource ^type.profile = $ch-mhd-submissionset-comprehensive
* entry[SubmissionSet].request 1.. MS
* entry[SubmissionSet].request.method = #POST
* entry[SubmissionSet].request.method MS
* entry[DocumentRefs] ^sliceName = "DocumentRefs"
* entry[DocumentRefs] ^mustSupport = true
* entry[DocumentRefs].resource 1.. MS
* entry[DocumentRefs].resource ^type.profile = Canonical(CHMhdDocumentReferenceComprehensive)
* entry[DocumentRefs].request MS
* entry[DocumentRefs].request.method = #POST
* entry[DocumentRefs].request.method MS
* entry[Documents] ^sliceName = "Documents"
* entry[Documents] ^mustSupport = true
* entry[Documents].resource 1.. MS
* entry[Documents].resource only Binary
* entry[Documents].request 1.. MS
* entry[Documents].request.method = #POST
* entry[Documents].request.method MS
* entry[Folders] 0..0 
* entry[Patient] 0..0

Profile: IHE_MHD_ProvideDocumentBundle_Comprehensive_Response_CH
Parent: Bundle
Id: ch-mhd-providedocumentbundle-comprehensive-response
Title: "CH MHD Provide Document Bundle Comprehensive Response"
Description: "IHE MHD profile on Response of Provide Document Bundle (ITI-65) transaction with Comprehensive Metadata."
* type = #transaction-response (exactly)
* type MS
* link MS
* link.url MS
* entry 2.. MS
* entry ^short = "One entry for each entry in the request, in the same order as received"
* entry.response 1.. MS
* entry.response ^short = "Indicating the results of processing the entry"
* entry.response.status MS
* entry.response.location 1.. MS
* entry.response.etag MS
* entry.response.outcome MS

Profile: CHMhdSubmissionSetComprehensive
Parent: $IHE.MHD.UnContained.Comprehensive.SubmissionSet
Id: ch-mhd-submissionset-comprehensive
Title: "CH MHD SubmissionSet Comprehensive"
Description: "CH MHD SubmissionSet Comprehensive"
* extension 2..
* extension contains $ch-ext-author-authorrole named authorAuthorRole 0..1 MS
* extension[designationType].value[x] from $SubmissionSet.contentTypeCode (required)
* extension[designationType] ^sliceName = "designationType"
* extension[designationType] ^mustSupport = true
* extension[sourceId] ^sliceName = "sourceId"
* extension[sourceId] ^mustSupport = true
* extension[authorAuthorRole] ^short = "The SubmissionSet.Author element MAY be used to track the user who made the latest changes to the document metadata."
* identifier[uniqueId] MS
* identifier[entryUUID] MS
* identifier ^short = "identifier, for uniqueID set use to usual"
* status MS
* mode MS
* code MS
* subject 1.. MS
* subject.identifier 1..1
* subject.identifier only EPRSPIDIdentifier
* subject ^comment = "Not a contained resource. The identifier points to an existing patient in the XDS Affinity Domain."
* date MS
* source MS
* source.extension[authorOrg] 0..0
* entry 1.. MS
* entry.item only Reference($ch-mhd-documentreference-comprehensive)
* entry.item MS
* entry.item ^type.aggregation[0] = #referenced
* entry.item ^type.aggregation[+] = #bundled

Profile: CHMhd1UpdateDocumentMetadataTransactionRequest
Id: ch-mhd-1-updatedocumentmetadatatransactionrequest
Parent: Bundle
Title: "CH MHD-1 Update Document Metadata Transaction Request"
Description: "A profile for Update Document Metadata (CH:MHD-1) transaction request"
* type = #transaction
* entry.request 1..1 MS
* entry.request.method = #PUT 
* entry.request.url 1..1 
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #closed
* entry ^slicing.description = "Slicing based on the profile conformance of the entry"
* entry.resource MS
* entry contains 
    DocumentReference 1..* MS 
* entry[DocumentReference] ^short = "DocumentReference"
* entry[DocumentReference].resource only CHMhdDocumentReferenceComprehensive

Profile: CHMhd1UpdateDocumentMetadataTransactionResponse
Id: ch-mhd-1-updatedocumentmetadatatransactionresponse
Parent: Bundle
Title: "CH MHD-1 Update Document Metadata Transaction Response"
Description: "A profile for Update Document Metadata (CH:MHD-1) transaction response"
* type = #transaction-response
* entry.response 1..1 MS
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #closed
* entry ^slicing.description = "Slicing based on the profile conformance of the entry"
* entry.resource MS
* entry contains 
    DocumentReference 0..*  MS and 
    OperationOutcome 0..1
 
* entry[DocumentReference] ^short = "DocumentReference"
* entry[DocumentReference].resource 1.. MS
* entry[DocumentReference].resource only CHMhdDocumentReferenceComprehensive

* entry[OperationOutcome] ^short = "OperationOutcome"
* entry[OperationOutcome].resource 1..
* entry[OperationOutcome].resource ^type.code = "OperationOutcome"
* entry[OperationOutcome].resource ^type.profile = Canonical(OperationOutcome)


Instance: DocRefPdf
InstanceOf: ch-mhd-documentreference-comprehensive
Title: "Comprehensive DocumentReference for a PDF Document"
Description: "Comprehensive DocumentReference for a PDF Document"
Usage: #example
* contained.resourceType = "Patient"
* contained.id = "1"
* contained.name.family = "Doe"
* contained.name.given = "John"
* contained.identifier.use = #usual
* contained.identifier.type = $v2-0203#MR
* contained.identifier.system = "urn:oid:2.999.1.2.3.4"
* contained.identifier.value = "8734"
* extension.url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-author-authorrole"
* extension.valueCoding = urn:oid:2.16.756.5.30.1.127.3.10.6#HCP "Healthcare professional"
* masterIdentifier.system = "urn:ietf:rfc:3986"
* masterIdentifier.value = "urn:oid:1.3.6.1.4.1.12559.11.13.2.1.2951"
* identifier.use = #official
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:7261fa25-b36d-4660-a58a-d9df4370e985"
* status = #current
* type = $sct#419891008 "Record artifact"
* category = $sct#405624007 "Administrative documentation"
* subject.identifier.system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* subject.identifier.value = "761337610411353650"
* date = "2025-09-24T12:01:30+00:00"
* description = "Test PDF"
* securityLabel = $sct#17621005 "Normal (qualifier value)"
* content.attachment.contentType = #application/pdf
* content.attachment.language = #de-CH
* content.attachment.url = "urn:uuid:d8d1fe44-07e9-4a84-985f-fde97d77d54b"
* content.attachment.title = "Test PDF"
* content.attachment.creation = "2025-09-24T12:01:30+00:00"
* content.format = urn:oid:2.16.756.5.30.1.127.3.10.10#urn:che:epr:EPR_Unstructured_Document "Unstructured EPR document"
* context.facilityType = $sct#264358009 "General practice premises (environment)"
* context.practiceSetting = $sct#394802001 "General medicine (qualifier value)"
* context.sourcePatientInfo = Reference(1)

Instance: 1
InstanceOf: Patient
Usage: #inline
* identifier.use = #usual
* identifier.type = $v2-0203#MR
* identifier.system = "urn:oid:2.999.1.2.3.4"
* identifier.value = "8734"

Instance: CHMhd1UpdateDocumentMetadataTransactionRequestExample
InstanceOf: CHMhd1UpdateDocumentMetadataTransactionRequest
Title: "CH MHD-1 Update Document Metadata Transaction Request Example"
Description: "Example of a CH MHD-1 Update Document Metadata Transaction Request"
Usage: #example
* type = http://hl7.org/fhir/bundle-type#transaction
* entry[DocumentReference].request.method = #PUT
* entry[DocumentReference].request.url = "DocumentReference/DocRefPdf"
* entry[DocumentReference].resource = DocRefPdf


Instance: CHMhd1UpdateDocumentMetadataTransactionResponseExample
InstanceOf: CHMhd1UpdateDocumentMetadataTransactionResponse
Title: "CH MHD-1 Update Document Metadata Transaction Response Example"
Description: "Example of a CH MHD-1 Update Document Metadata Transaction Response"
Usage: #example
* type = #transaction-response
* link.relation = "self"
* link.url = "http://example.org/fhir"
* entry.response.status = "200 OK"
* entry.response.location = "DocumentReference/DocRefPdf/_history/2"
* entry.response.etag = "2"

Instance: BundleProvideDocument
InstanceOf: CHMhdProvideDocumentBundleComprehensive
Title: "MHD Provide Document Bundle for a PDF Document"
Description: "MHD Provide Document Bundle for a PDF Document"
Usage: #example
* meta.profile[0] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-mhd-providedocumentbundle-comprehensive"
* meta.profile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Comprehensive.ProvideBundle"
* type = #transaction
* entry[SubmissionSet].fullUrl = "urn:uuid:68a928c0-df48-4743-a291-bfb0609bbddc"
* entry[SubmissionSet].resource = Inline-Instance-for-BundleProvideDocument-1
* entry[SubmissionSet].request.method = #POST
* entry[SubmissionSet].request.url = "List"
* entry[DocumentRefs].fullUrl = "urn:uuid:50383ae5-49e5-4dea-b0e6-660cb9e7b91f"
* entry[DocumentRefs].resource = Inline-Instance-for-BundleProvideDocument-2
* entry[DocumentRefs].request.method = #POST
* entry[DocumentRefs].request.url = "DocumentReference"
* entry[Documents].fullUrl = "urn:uuid:d8d1fe44-07e9-4a84-985f-fde97d77d54b"
* entry[Documents].resource = Inline-Instance-for-BundleProvideDocument-3
* entry[Documents].request.method = #POST
* entry[Documents].request.url = "Binary"

Instance: Inline-Instance-for-BundleProvideDocument-1
InstanceOf: List
Usage: #inline
* extension[0].url = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/ihe-designationType"
* extension[=].valueCodeableConcept = $sct#71388002 "Procedure (procedure)"
* extension[+].url = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/ihe-sourceId"
* extension[=].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[=].valueIdentifier.value = "urn:oid:1.3.6.1.4.1.12559.11.13.2.5"
* extension[+].url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-author-authorrole"
* extension[=].valueCoding = urn:oid:2.16.756.5.30.1.127.3.10.6#HCP "Healthcare professional"
* identifier.use = #usual
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:oid:1.3.6.1.4.1.12559.11.13.2.6.2949"
* status = #current
* mode = #working
* code = $MHDlistTypes#submissionset "SubmissionSet as a FHIR List"
* subject.identifier.system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* subject.identifier.value = "761337610411353650"
* date = "2025-09-24T12:01:30+00:00"
* entry.item = Reference(urn:uuid:50383ae5-49e5-4dea-b0e6-660cb9e7b91f)

Instance: Inline-Instance-for-BundleProvideDocument-2
InstanceOf: DocumentReference
Usage: #inline
* contained.resourceType = "Patient"
* contained.id = "1"
* contained.name.family = "Doe"
* contained.name.given = "John"
* contained.identifier.use = #usual
* contained.identifier.type = $v2-0203#MR
* contained.identifier.system = "urn:oid:2.999.1.2.3.4"
* contained.identifier.value = "8734"
* extension.url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-author-authorrole"
* extension.valueCoding = urn:oid:2.16.756.5.30.1.127.3.10.6#HCP "Healthcare professional"
* masterIdentifier.system = "urn:ietf:rfc:3986"
* masterIdentifier.value = "urn:oid:1.3.6.1.4.1.12559.11.13.2.1.2951"
* identifier.use = #official
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:7261fa25-b36d-4660-a58a-d9df4370e985"
* status = #current
* type = $sct#419891008 "Record artifact"
* category = $sct#405624007 "Administrative documentation"
* subject.identifier.system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* subject.identifier.value = "761337610411353650"
* date = "2025-09-24T12:01:30+00:00"
* description = "Test PDF"
* securityLabel = $sct#17621005 "Normal (qualifier value)"
* content.attachment.contentType = #application/pdf
* content.attachment.language = #de-CH
* content.attachment.url = "urn:uuid:d8d1fe44-07e9-4a84-985f-fde97d77d54b"
* content.attachment.title = "Test PDF"
* content.attachment.creation = "2025-09-24T12:01:30+00:00"
* content.format = urn:oid:2.16.756.5.30.1.127.3.10.10#urn:che:epr:EPR_Unstructured_Document "Unstructured EPR document"
* context.facilityType = $sct#264358009 "General practice premises (environment)"
* context.practiceSetting = $sct#394802001 "General medicine (qualifier value)"
* context.sourcePatientInfo = Reference(1)

Instance: Inline-Instance-for-BundleProvideDocument-3
InstanceOf: Binary
Usage: #inline
* contentType = #application/pdf
* data = "JVBERi0xLjQKJfbk/N8KMSAwIG9iago8PAovVHlwZSAvQ2F0YWxvZwovVmVyc2lvbiAvMS40Ci9QYWdlcyAyIDAgUgovTWV0YWRhdGEgMyAwIFIKL01hcmtJbmZvIDQgMCBSCi9MYW5nIChmci1DSCkKL1ZpZXdlclByZWZlcmVuY2VzIDUgMCBSCi9PdXRwdXRJbnRlbnRzIFs2IDAgUl0KL1N0cnVjdFRyZWVSb290IDcgMCBSCj4+CmVuZG9iago4IDAgb2JqCjw8Ci9DcmVhdGlvbkRhdGUgKEQ6MjAyMzAxMDcxMTAwMDYrMDAnMDAnKQovUHJvZHVjZXIgKFRoZSBIdXNreSBsaWJyYXJ5KQovU3ViamVjdCAoVHJvbmcgU2FuZyBORUZGLVdJTkdFSUVSKQovQXV0aG9yIChBdXRob3IpCi9kZXNjcmlwdGlvbiA8NTU2RTY1MjA2MzYxNzI3NDY1MjA2NDY1MjA2REU5NjQ2OTYzNjE3NDY5NkY2RTIwNzA2Rjc1NzIyMDZDNjUyMDczNzU2QTY1NzQyQzIwNjdFOTZFRTk3MkU5NjUyMEUwMjA2QzYxMjA2NDY1NkQ2MTZFNjQ2NT4KL3ZpZXdwb3J0ICh3aWR0aD1kZXZpY2Utd2lkdGgsIGluaXRpYWwtc2NhbGU9MSkKL1RpdGxlIDw0MzYxNzI3NDY1MjA2NDY1MjA2REU5NjQ2OTYzNjE3NDY5NkY2RT4KPj4KZW5kb2JqCjIgMCBvYmoKPDwKL1R5cGUgL1BhZ2VzCi9LaWRzIFs5IDAgUl0KL0NvdW50IDEKPj4KZW5kb2JqCjMgMCBvYmoKPDwKL0xlbmd0aCA0OTMyCi9UeXBlIC9NZXRhZGF0YQovU3VidHlwZSAvWE1MCj4+CnN0cmVhbQ0KPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz48eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIj4KICAgPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiB4bWxuczpwZGZhaWQ9Imh0dHA6Ly93d3cuYWlpbS5vcmcvcGRmYS9ucy9pZC8iIHJkZjphYm91dD0iIj4KICAgICAgICAgPHBkZmFpZDpjb25mb3JtYW5jZT5BPC9wZGZhaWQ6Y29uZm9ybWFuY2U+CiAgICAgICAgIDxwZGZhaWQ6cGFydD4xPC9wZGZhaWQ6cGFydD4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgICAgIDxyZGY6RGVzY3JpcHRpb24geG1sbnM6cGRmPSJodHRwOi8vbnMuYWRvYmUuY29tL3BkZi8xLjMvIiByZGY6YWJvdXQ9IiI+CiAgICAgICAgIDxwZGY6UERGVmVyc2lvbj4xLjQ8L3BkZjpQREZWZXJzaW9uPgogICAgICAgICA8cGRmOlByb2R1Y2VyPlRoZSBIdXNreSBsaWJyYXJ5PC9wZGY6UHJvZHVjZXI+CiAgICAgIDwvcmRmOkRlc2NyaXB0aW9uPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgcmRmOmFib3V0PSIiPgogICAgICAgICA8eG1wOkNyZWF0ZURhdGU+MjAyMy0wMS0wN1QxMTowMDowNiswMDowMDwveG1wOkNyZWF0ZURhdGU+CiAgICAgIDwvcmRmOkRlc2NyaXB0aW9uPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgcmRmOmFib3V0PSIiPgogICAgICAgICA8ZGM6Zm9ybWF0PmFwcGxpY2F0aW9uL3BkZjwvZGM6Zm9ybWF0PgogICAgICAgICA8ZGM6Y3JlYXRvcj4KICAgICAgICAgICAgPHJkZjpTZXE+CiAgICAgICAgICAgICAgIDxyZGY6bGk+QXV0aG9yPC9yZGY6bGk+CiAgICAgICAgICAgIDwvcmRmOlNlcT4KICAgICAgICAgPC9kYzpjcmVhdG9yPgogICAgICAgICA8ZGM6dGl0bGU+CiAgICAgICAgICAgIDxyZGY6QWx0PgogICAgICAgICAgICAgICA8cmRmOmxpIHhtbDpsYW5nPSJ4LWRlZmF1bHQiPkNhcnRlIGRlIG3DqWRpY2F0aW9uPC9yZGY6bGk+CiAgICAgICAgICAgIDwvcmRmOkFsdD4KICAgICAgICAgPC9kYzp0aXRsZT4KICAgICAgICAgPGRjOmRlc2NyaXB0aW9uPgogICAgICAgICAgICA8cmRmOkFsdD4KICAgICAgICAgICAgICAgPHJkZjpsaSB4bWw6bGFuZz0ieC1kZWZhdWx0Ij5Ucm9uZyBTYW5nIE5FRkYtV0lOR0VJRVI8L3JkZjpsaT4KICAgICAgICAgICAgPC9yZGY6QWx0PgogICAgICAgICA8L2RjOmRlc2NyaXB0aW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiB4bWxuczpwZGZhRXh0ZW5zaW9uPSJodHRwOi8vd3d3LmFpaW0ub3JnL3BkZmEvbnMvZXh0ZW5zaW9uLyIKICAgICAgICAgICAgICAgICAgICAgICB4bWxuczpwZGZhUHJvcGVydHk9Imh0dHA6Ly93d3cuYWlpbS5vcmcvcGRmYS9ucy9wcm9wZXJ0eSMiCiAgICAgICAgICAgICAgICAgICAgICAgeG1sbnM6cGRmYVNjaGVtYT0iaHR0cDovL3d3dy5haWltLm9yZy9wZGZhL25zL3NjaGVtYSMiCiAgICAgICAgICAgICAgICAgICAgICAgcmRmOmFib3V0PSIiPgogICAgICAgICA8cGRmYUV4dGVuc2lvbjpzY2hlbWFzPgogICAgICAgICAgICA8cmRmOkJhZz4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxwZGZhU2NoZW1hOnNjaGVtYT5BZG9iZSBQREYgU2NoZW1hPC9wZGZhU2NoZW1hOnNjaGVtYT4KICAgICAgICAgICAgICAgICAgPHBkZmFTY2hlbWE6bmFtZXNwYWNlVVJJPmh0dHA6Ly9ucy5hZG9iZS5jb20vcGRmLzEuMy88L3BkZmFTY2hlbWE6bmFtZXNwYWNlVVJJPgogICAgICAgICAgICAgICAgICA8cGRmYVNjaGVtYTpwcmVmaXg+cGRmPC9wZGZhU2NoZW1hOnByZWZpeD4KICAgICAgICAgICAgICAgICAgPHBkZmFTY2hlbWE6cHJvcGVydHk+CiAgICAgICAgICAgICAgICAgICAgIDxyZGY6U2VxPgogICAgICAgICAgICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgPHBkZmFQcm9wZXJ0eTpuYW1lPlBERlZlcnNpb248L3BkZmFQcm9wZXJ0eTpuYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICA8cGRmYVByb3BlcnR5OnZhbHVlVHlwZT5UZXh0PC9wZGZhUHJvcGVydHk6dmFsdWVUeXBlPgogICAgICAgICAgICAgICAgICAgICAgICAgICA8cGRmYVByb3BlcnR5OmNhdGVnb3J5PmludGVybmFsPC9wZGZhUHJvcGVydHk6Y2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgIDxwZGZhUHJvcGVydHk6ZGVzY3JpcHRpb24+VGhlIFBERiBmaWxlIHZlcnNpb24uPC9wZGZhUHJvcGVydHk6ZGVzY3JpcHRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgPHBkZmFQcm9wZXJ0eTpuYW1lPktleXdvcmRzPC9wZGZhUHJvcGVydHk6bmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgPHBkZmFQcm9wZXJ0eTp2YWx1ZVR5cGU+VGV4dDwvcGRmYVByb3BlcnR5OnZhbHVlVHlwZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgPHBkZmFQcm9wZXJ0eTpjYXRlZ29yeT5leHRlcm5hbDwvcGRmYVByb3BlcnR5OmNhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICA8cGRmYVByb3BlcnR5OmRlc2NyaXB0aW9uPktleXdvcmRzLjwvcGRmYVByb3BlcnR5OmRlc2NyaXB0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgICAgICAgICAgIDxwZGZhUHJvcGVydHk6bmFtZT5Qcm9kdWNlcjwvcGRmYVByb3BlcnR5Om5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgIDxwZGZhUHJvcGVydHk6dmFsdWVUeXBlPkFnZW50TmFtZTwvcGRmYVByb3BlcnR5OnZhbHVlVHlwZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgPHBkZmFQcm9wZXJ0eTpjYXRlZ29yeT5pbnRlcm5hbDwvcGRmYVByb3BlcnR5OmNhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICA8cGRmYVByb3BlcnR5OmRlc2NyaXB0aW9uPlRoZSBuYW1lIG9mIHRoZSB0b29sIHRoYXQgY3JlYXRlZCB0aGUgUERGIGRvY3VtZW50LjwvcGRmYVByb3BlcnR5OmRlc2NyaXB0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgICAgICAgPC9yZGY6U2VxPgogICAgICAgICAgICAgICAgICA8L3BkZmFTY2hlbWE6cHJvcGVydHk+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgICAgICAgPHBkZmFTY2hlbWE6c2NoZW1hPlBERi9BIElEIFNjaGVtYTwvcGRmYVNjaGVtYTpzY2hlbWE+CiAgICAgICAgICAgICAgICAgIDxwZGZhU2NoZW1hOm5hbWVzcGFjZVVSST5odHRwOi8vd3d3LmFpaW0ub3JnL3BkZmEvbnMvaWQvPC9wZGZhU2NoZW1hOm5hbWVzcGFjZVVSST4KICAgICAgICAgICAgICAgICAgPHBkZmFTY2hlbWE6cHJlZml4PnBkZmFpZDwvcGRmYVNjaGVtYTpwcmVmaXg+CiAgICAgICAgICAgICAgICAgIDxwZGZhU2NoZW1hOnByb3BlcnR5PgogICAgICAgICAgICAgICAgICAgICA8cmRmOlNlcT4KICAgICAgICAgICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgICAgICAgICAgIDxwZGZhUHJvcGVydHk6bmFtZT5wYXJ0PC9wZGZhUHJvcGVydHk6bmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgPHBkZmFQcm9wZXJ0eTp2YWx1ZVR5cGU+SW50ZWdlcjwvcGRmYVByb3BlcnR5OnZhbHVlVHlwZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgPHBkZmFQcm9wZXJ0eTpjYXRlZ29yeT5pbnRlcm5hbDwvcGRmYVByb3BlcnR5OmNhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICA8cGRmYVByb3BlcnR5OmRlc2NyaXB0aW9uPlBhcnQgb2YgUERGL0Egc3RhbmRhcmQ8L3BkZmFQcm9wZXJ0eTpkZXNjcmlwdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICAgICAgICAgICA8cGRmYVByb3BlcnR5Om5hbWU+Y29uZm9ybWFuY2U8L3BkZmFQcm9wZXJ0eTpuYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICA8cGRmYVByb3BlcnR5OnZhbHVlVHlwZT5UZXh0PC9wZGZhUHJvcGVydHk6dmFsdWVUeXBlPgogICAgICAgICAgICAgICAgICAgICAgICAgICA8cGRmYVByb3BlcnR5OmNhdGVnb3J5PmludGVybmFsPC9wZGZhUHJvcGVydHk6Y2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgIDxwZGZhUHJvcGVydHk6ZGVzY3JpcHRpb24+Q29uZm9ybWFuY2UgbGV2ZWwgb2YgUERGL0Egc3RhbmRhcmQ8L3BkZmFQcm9wZXJ0eTpkZXNjcmlwdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgICAgICAgIDwvcmRmOlNlcT4KICAgICAgICAgICAgICAgICAgPC9wZGZhU2NoZW1hOnByb3BlcnR5PgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgPC9yZGY6QmFnPgogICAgICAgICA8L3BkZmFFeHRlbnNpb246c2NoZW1hcz4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+Cjw/eHBhY2tldCBlbmQ9InciPz4KDQplbmRzdHJlYW0KZW5kb2JqCjQgMCBvYmoKPDwKL01hcmtlZCB0cnVlCj4+CmVuZG9iago1IDAgb2JqCjw8Ci9EaXNwbGF5RG9jVGl0bGUgdHJ1ZQo+PgplbmRvYmoKNiAwIG9iago8PAovVHlwZSAvT3V0cHV0SW50ZW50Ci9TIC9HVFNfUERGQTEKL0Rlc3RPdXRwdXRQcm9maWxlIDEwIDAgUgovSW5mbyAoc1JHQiBJRUM2MTk2Ni0yLjEpCi9PdXRwdXRDb25kaXRpb24gKHNSR0IgSUVDNjE5NjYtMi4xKQovT3V0cHV0Q29uZGl0aW9uSWRlbnRpZmllciAoc1JHQiBJRUM2MTk2Ni0yLjEpCi9SZWdpc3RyeU5hbWUgKGh0dHA6Ly93d3cuY29sb3Iub3JnKQo+PgplbmRvYmoKNyAwIG9iago8PAovVHlwZSAvU3RydWN0VHJlZVJvb3QKL1JvbGVNYXAgMTEgMCBSCi9LIDEyIDAgUgovUGFyZW50VHJlZU5leHRLZXkgMQovUGFyZW50VHJlZSAxMyAwIFIKPj4KZW5kb2JqCjkgMCBvYmoKPDwKL1R5cGUgL1BhZ2UKL01lZGlhQm94IFswLjAgMC4wIDg0MS44NzUgNTk1LjI3NV0KL1BhcmVudCAyIDAgUgovQ29udGVudHMgMTQgMCBSCi9SZXNvdXJjZXMgMTUgMCBSCi9TdHJ1Y3RQYXJlbnRzIDAKL1RhYnMgL1MKPj4KZW5kb2JqCjEwIDAgb2JqCjw8Ci9MZW5ndGggMjQ3MgovRmlsdGVyIC9GbGF0ZURlY29kZQovTiAzCj4+CnN0cmVhbQ0KeJztmWdQVFkWgO97nRMN3U2ToclJooQGJOckQbKoQHeTaaHJQVFk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YW0KZW5kb2JqCjE1IDAgb2JqCjw8Ci9Qcm9wZXJ0aWVzIDUyIDAgUgovRm9udCA1MyAwIFIKL1hPYmplY3QgPDwKL0Zvcm0xIDU0IDAgUgo+Pgo+PgplbmRvYmoKMTYgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL0RpdgovUCAxMiAwIFIKL1BnIDkgMCBSCi9LIFsxNyAwIFIgNTUgMCBSIDI0IDAgUiA1NiAwIFIgNDIgMCBSIDU3IDAgUl0KPj4KZW5kb2JqCjE3IDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9IMQovUCAxNiAwIFIKL1BnIDkgMCBSCi9LIDAKPj4KZW5kb2JqCjE4IDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9IMgovUCA1OCAwIFIKL1BnIDkgMCBSCi9LIDEKPj4KZW5kb2JqCjE5IDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9TcGFuCi9QIDU5IDAgUgovUGcgOSAwIFIKL0sgWzIgNjAgMCBSXQo+PgplbmRvYmoKMjAgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1NwYW4KL1AgNjAgMCBSCi9QZyA5IDAgUgovSyAzCj4+CmVuZG9iagoyMSAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvU3BhbgovUCA1OSAwIFIKL1BnIDkgMCBSCi9LIFs2MSAwIFIgNF0KPj4KZW5kb2JqCjIyIDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9IMgovUCA2MiAwIFIKL1BnIDkgMCBSCi9LIDUKPj4KZW5kb2JqCjIzIDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9EaXYKL1AgNjIgMCBSCi9QZyA5IDAgUgovSyA2Cj4+CmVuZG9iagoyNCAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvSDIKL1AgMTYgMCBSCi9QZyA5IDAgUgovSyA3Cj4+CmVuZG9iagoyNSAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvVEQKL1AgNjMgMCBSCi9QZyA5IDAgUgovQSA2NCAwIFIKL0sgOAo+PgplbmRvYmoKMjYgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RECi9QIDYzIDAgUgovUGcgOSAwIFIKL0EgNjUgMCBSCi9LIDkKPj4KZW5kb2JqCjI3IDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9URAovUCA2MyAwIFIKL1BnIDkgMCBSCi9BIDY2IDAgUgovSyAxMAo+PgplbmRvYmoKMjggMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RECi9QIDYzIDAgUgovUGcgOSAwIFIKL0EgNjcgMCBSCi9LIDExCj4+CmVuZG9iagoyOSAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvVEQKL1AgNjggMCBSCi9QZyA5IDAgUgovSyAxMgo+PgplbmRvYmoKMzAgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RECi9QIDY4IDAgUgovUGcgOSAwIFIKL0sgMTMKPj4KZW5kb2JqCjMxIDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9URAovUCA2OCAwIFIKL1BnIDkgMCBSCi9LIDE0Cj4+CmVuZG9iagozMiAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvVEQKL1AgNjggMCBSCi9QZyA5IDAgUgovSyAxNQo+PgplbmRvYmoKMzMgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RECi9QIDY5IDAgUgovUGcgOSAwIFIKL0sgMTYKPj4KZW5kb2JqCjM0IDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9TcGFuCi9QIDcwIDAgUgovUGcgOSAwIFIKL0sgWzE3IDM1IDAgUiAxOF0KPj4KZW5kb2JqCjM1IDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9TcGFuCi9QIDM0IDAgUgovUGcgOSAwIFIKL0sgMTkKPj4KZW5kb2JqCjM2IDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9URAovUCA2OSAwIFIKL1BnIDkgMCBSCi9LIDIwCj4+CmVuZG9iagozNyAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvVEQKL1AgNjkgMCBSCi9QZyA5IDAgUgovSyAyMQo+PgplbmRvYmoKMzggMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RECi9QIDY5IDAgUgovUGcgOSAwIFIKL0sgMjIKPj4KZW5kb2JqCjM5IDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9URAovUCA2OSAwIFIKL1BnIDkgMCBSCi9LIDIzCj4+CmVuZG9iago0MCAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvVEQKL1AgNjkgMCBSCi9QZyA5IDAgUgovSyAyNAo+PgplbmRvYmoKNDEgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RECi9QIDcxIDAgUgovUGcgOSAwIFIKL0EgNzIgMCBSCi9LIDI1Cj4+CmVuZG9iago0MiAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvSDIKL1AgMTYgMCBSCi9QZyA5IDAgUgovSyAyNgo+PgplbmRvYmoKNDMgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RECi9QIDczIDAgUgovUGcgOSAwIFIKL0EgNzQgMCBSCi9LIDI3Cj4+CmVuZG9iago0NCAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvVEQKL1AgNzMgMCBSCi9QZyA5IDAgUgovQSA3NSAwIFIKL0sgMjgKPj4KZW5kb2JqCjQ1IDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9URAovUCA3MyAwIFIKL1BnIDkgMCBSCi9BIDc2IDAgUgovSyAyOQo+PgplbmRvYmoKNDYgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RECi9QIDczIDAgUgovUGcgOSAwIFIKL0EgNzcgMCBSCi9LIDMwCj4+CmVuZG9iago0NyAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvVEQKL1AgNzggMCBSCi9QZyA5IDAgUgovSyAzMQo+PgplbmRvYmoKNDggMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RECi9QIDc4IDAgUgovUGcgOSAwIFIKL0sgMzIKPj4KZW5kb2JqCjQ5IDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9URAovUCA3OCAwIFIKL1BnIDkgMCBSCi9LIDMzCj4+CmVuZG9iago1MCAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvVEQKL1AgNzggMCBSCi9QZyA5IDAgUgovSyAzNAo+PgplbmRvYmoKNTEgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RECi9QIDc5IDAgUgovUGcgOSAwIFIKL0EgODAgMCBSCi9LIDM1Cj4+CmVuZG9iago1MiAwIG9iago8PAovUHJvcDEgODEgMCBSCi9Qcm9wMiA4MiAwIFIKL1Byb3AzIDgzIDAgUgovUHJvcDQgODQgMCBSCi9Qcm9wNSA4NSAwIFIKL1Byb3A2IDg2IDAgUgovUHJvcDcgODcgMCBSCi9Qcm9wOCA4OCAwIFIKL1Byb3A5IDg5IDAgUgovUHJvcDEwIDkwIDAgUgovUHJvcDExIDkxIDAgUgovUHJvcDEyIDkyIDAgUgovUHJvcDEzIDkzIDAgUgovUHJvcDE0IDk0IDAgUgovUHJvcDE1IDk1IDAgUgovUHJvcDE2IDk2IDAgUgovUHJvcDE3IDk3IDAgUgovUHJvcDE4IDk4IDAgUgovUHJvcDE5IDk5IDAgUgovUHJvcDIwIDEwMCAwIFIKL1Byb3AyMSAxMDEgMCBSCi9Qcm9wMjIgMTAyIDAgUgovUHJvcDIzIDEwMyAwIFIKL1Byb3AyNCAxMDQgMCBSCi9Qcm9wMjUgMTA1IDAgUgovUHJvcDI2IDEwNiAwIFIKL1Byb3AyNyAxMDcgMCBSCi9Qcm9wMjggMTA4IDAgUgovUHJvcDI5IDEwOSAwIFIKL1Byb3AzMCAxMTAgMCBSCi9Qcm9wMzEgMTExIDAgUgovUHJvcDMyIDExMiAwIFIKL1Byb3AzMyAxMTMgMCBSCi9Qcm9wMzQgMTE0IDAgUgovUHJvcDM1IDExNSAwIFIKL1Byb3AzNiAxMTYgMCBSCi9Qcm9wMzcgMTE3IDAgUgovUHJvcDM4IDExOCAwIFIKL1Byb3AzOSAxMTkgMCBSCi9Qcm9wNDAgMTIwIDAgUgovUHJvcDQxIDEyMSAwIFIKL1Byb3A0MiAxMjIgMCBSCi9Qcm9wNDMgMTIzIDAgUgovUHJvcDQ0IDEyNCAwIFIKL1Byb3A0NSAxMjUgMCBSCi9Qcm9wNDYgMTI2IDAgUgovUHJvcDQ3IDEyNyAwIFIKL1Byb3A0OCAxMjggMCBSCi9Qcm9wNDkgMTI5IDAgUgovUHJvcDUwIDEzMCAwIFIKL1Byb3A1MSAxMzEgMCBSCi9Qcm9wNTIgMTMyIDAgUgovUHJvcDUzIDEzMyAwIFIKL1Byb3A1NCAxMzQgMCBSCi9Qcm9wNTUgMTM1IDAgUgovUHJvcDU2IDEzNiAwIFIKL1Byb3A1NyAxMzcgMCBSCi9Qcm9wNTggMTM4IDAgUgovUHJvcDU5IDEzOSAwIFIKL1Byb3A2MCAxNDAgMCBSCi9Qcm9wNjEgMTQxIDAgUgovUHJvcDYyIDE0MiAwIFIKL1Byb3A2MyAxNDMgMCBSCi9Qcm9wNjQgMTQ0IDAgUgovUHJvcDY1IDE0NSAwIFIKL1Byb3A2NiAxNDYgMCBSCi9Qcm9wNjcgMTQ3IDAgUgovUHJvcDY4IDE0OCAwIFIKL1Byb3A2OSAxNDkgMCBSCi9Qcm9wNzAgMTUwIDAgUgovUHJvcDcxIDE1MSAwIFIKL1Byb3A3MiAxNTIgMCBSCi9Qcm9wNzMgMTUzIDAgUgovUHJvcDc0IDE1NCAwIFIKL1Byb3A3NSAxNTUgMCBSCi9Qcm9wNzYgMTU2IDAgUgovUHJvcDc3IDE1NyAwIFIKL1Byb3A3OCAxNTggMCBSCi9Qcm9wNzkgMTU5IDAgUgovUHJvcDgwIDE2MCAwIFIKL1Byb3A4MSAxNjEgMCBSCi9Qcm9wODIgMTYyIDAgUgovUHJvcDgzIDE2MyAwIFIKL1Byb3A4NCAxNjQgMCBSCi9Qcm9wODUgMTY1IDAgUgovUHJvcDg2IDE2NiAwIFIKL1Byb3A4NyAxNjcgMCBSCi9Qcm9wODggMTY4IDAgUgovUHJvcDg5IDE2OSAwIFIKL1Byb3A5MCAxNzAgMCBSCi9Qcm9wOTEgMTcxIDAgUgovUHJvcDkyIDE3MiAwIFIKL1Byb3A5MyAxNzMgMCBSCi9Qcm9wOTQgMTc0IDAgUgovUHJvcDk1IDE3NSAwIFIKL1Byb3A5NiAxNzYgMCBSCi9Qcm9wOTcgMTc3IDAgUgovUHJvcDk4IDE3OCAwIFIKL1Byb3A5OSAxNzkgMCBSCi9Qcm9wMTAwIDE4MCAwIFIKL1Byb3AxMDEgMTgxIDAgUgovUHJvcDEwMiAxODIgMCBSCi9Qcm9wMTAzIDE4MyAwIFIKL1Byb3AxMDQgMTg0IDAgUgovUHJvcDEwNSAxODUgMCBSCi9Qcm9wMTA2IDE4NiAwIFIKL1Byb3AxMDcgMTg3IDAgUgovUHJvcDEwOCAxODggMCBSCi9Qcm9wMTA5IDE4OSAwIFIKL1Byb3AxMTAgMTkwIDAgUgovUHJvcDExMSAxOTEgMCBSCi9Qcm9wMTEyIDE5MiAwIFIKL1Byb3AxMTMgMTkzIDAgUgovUHJvcDExNCAxOTQgMCBSCi9Qcm9wMTE1IDE5NSAwIFIKL1Byb3AxMTYgMTk2IDAgUgovUHJvcDExNyAxOTcgMCBSCi9Qcm9wMTE4IDE5OCAwIFIKL1Byb3AxMTkgMTk5IDAgUgovUHJvcDEyMCAyMDAgMCBSCi9Qcm9wMTIxIDIwMSAwIFIKL1Byb3AxMjIgMjAyIDAgUgovUHJvcDEyMyAyMDMgMCBSCi9Qcm9wMTI0IDIwNCAwIFIKL1Byb3AxMjUgMjA1IDAgUgovUHJvcDEyNiAyMDYgMCBSCi9Qcm9wMTI3IDIwNyAwIFIKL1Byb3AxMjggMjA4IDAgUgovUHJvcDEyOSAyMDkgMCBSCi9Qcm9wMTMwIDIxMCAwIFIKL1Byb3AxMzEgMjExIDAgUgovUHJvcDEzMiAyMTIgMCBSCi9Qcm9wMTMzIDIxMyAwIFIKL1Byb3AxMzQgMjE0IDAgUgovUHJvcDEzNSAyMTUgMCBSCi9Qcm9wMTM2IDIxNiAwIFIKL1Byb3AxMzcgMjE3IDAgUgovUHJvcDEzOCAyMTggMCBSCi9Qcm9wMTM5IDIxOSAwIFIKL1Byb3AxNDAgMjIwIDAgUgovUHJvcDE0MSAyMjEgMCBSCi9Qcm9wMTQyIDIyMiAwIFIKL1Byb3AxNDMgMjIzIDAgUgovUHJvcDE0NCAyMjQgMCBSCi9Qcm9wMTQ1IDIyNSAwIFIKL1Byb3AxNDYgMjI2IDAgUgovUHJvcDE0NyAyMjcgMCBSCi9Qcm9wMTQ4IDIyOCAwIFIKL1Byb3AxNDkgMjI5IDAgUgovUHJvcDE1MCAyMzAgMCBSCi9Qcm9wMTUxIDIzMSAwIFIKL1Byb3AxNTIgMjMyIDAgUgovUHJvcDE1MyAyMzMgMCBSCi9Qcm9wMTU0IDIzNCAwIFIKL1By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PAovVHlwZSAvU3RydWN0RWxlbQovUyAvVEQKL1AgMjU0IDAgUgovUGcgOSAwIFIKL0sgWzE4IDAgUiA1OSAwIFJdCj4+CmVuZG9iago1OSAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvRGl2Ci9QIDU4IDAgUgovUGcgOSAwIFIKL0sgWzE5IDAgUiAyMSAwIFJdCj4+CmVuZG9iago2MCAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvU3BhbgovUCAxOSAwIFIKL1BnIDkgMCBSCi9LIDIwIDAgUgo+PgplbmRvYmoKNjEgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1NwYW4KL1AgMjEgMCBSCi9QZyA5IDAgUgo+PgplbmRvYmoKNjIgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RECi9QIDI1NCAwIFIKL1BnIDkgMCBSCi9LIFsyMiAwIFIgMjMgMCBSXQo+PgplbmRvYmoKNjMgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RSCi9QIDU2IDAgUgovUGcgOSAwIFIKL0sgWzI1IDAgUiAyNiAwIFIgMjcgMCBSIDI4IDAgUl0KPj4KZW5kb2JqCjY0IDAgb2JqCjw8Ci9PIC9UYWJsZQovUm93U3BhbiAyCj4+CmVuZG9iago2NSAwIG9iago8PAovTyAvVGFibGUKL0NvbFNwYW4gNAo+PgplbmRvYmoKNjYgMCBvYmoKPDwKL08gL1RhYmxlCi9Sb3dTcGFuIDIKPj4KZW5kb2JqCjY3IDAgb2JqCjw8Ci9PIC9UYWJsZQovUm93U3BhbiAyCj4+CmVuZG9iago2OCAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvVFIKL1AgNTYgMCBSCi9QZyA5IDAgUgovSyBbMjkgMCBSIDMwIDAgUiAzMSAwIFIgMzIgMCBSXQo+PgplbmRvYmoKNjkgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RSCi9QIDU2IDAgUgovUGcgOSAwIFIKL0sgWzMzIDAgUiA3MCAwIFIgMzYgMCBSIDM3IDAgUiAzOCAwIFIgMzkgMCBSIDQwIDAgUl0KPj4KZW5kb2JqCjcwIDAgb2JqCjw8Ci9UeXBlIC9TdHJ1Y3RFbGVtCi9TIC9URAovUCA2OSAwIFIKL1BnIDkgMCBSCi9LIDM0IDAgUgo+PgplbmRvYmoKNzEgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RSCi9QIDU2IDAgUgovUGcgOSAwIFIKL0sgNDEgMCBSCj4+CmVuZG9iago3MiAwIG9iago8PAovTyAvVGFibGUKL0NvbFNwYW4gNwo+PgplbmRvYmoKNzMgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RSCi9QIDU3IDAgUgovUGcgOSAwIFIKL0sgWzQzIDAgUiA0NCAwIFIgNDUgMCBSIDQ2IDAgUl0KPj4KZW5kb2JqCjc0IDAgb2JqCjw8Ci9PIC9UYWJsZQovUm93U3BhbiAyCj4+CmVuZG9iago3NSAwIG9iago8PAovTyAvVGFibGUKL0NvbFNwYW4gNAo+PgplbmRvYmoKNzYgMCBvYmoKPDwKL08gL1RhYmxlCi9Sb3dTcGFuIDIKPj4KZW5kb2JqCjc3IDAgb2JqCjw8Ci9PIC9UYWJsZQovUm93U3BhbiAyCj4+CmVuZG9iago3OCAwIG9iago8PAovVHlwZSAvU3RydWN0RWxlbQovUyAvVFIKL1AgNTcgMCBSCi9QZyA5IDAgUgovSyBbNDcgMCBSIDQ4IDAgUiA0OSAwIFIgNTAgMCBSXQo+PgplbmRvYmoKNzkgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RSCi9QIDU3IDAgUgovUGcgOSAwIFIKL0sgNTEgMCBSCj4+CmVuZG9iago4MCAwIG9iago8PAovTyAvVGFibGUKL0NvbFNwYW4gNwo+PgplbmRvYmoKODEgMCBvYmoKPDwKL1R5cGUgL1BhZ2luYXRpb24KPj4KZW5kb2JqCjgyIDAgb2JqCjw8Ci9UeXBlIC9QYWdpbmF0aW9uCj4+CmVuZG9iago4MyAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgOTguMTc1MDIgODEzLjUyNSA1NjYuOTI1MDVdCj4+CmVuZG9iago4NCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgOTguMTc1MDIgODEzLjUyNSA1NjYuOTI1MDVdCj4+CmVuZG9iago4NSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgOTguMTc1MDIgODEzLjUyNSA1NjYuOTI1MDVdCj4+CmVuZG9iago4NiAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgNTE2LjQ1IDgxMy41MjUgNTUwLjgzNzVdCj4+CmVuZG9iago4NyAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgNDAxLjgxMjUgODEzLjUyNSA1MDAuMzYyNV0KPj4KZW5kb2JqCjg4IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyOC4zNSA0MDEuODEyNSA4MTMuNTI1IDUwMC4zNjI1XQo+PgplbmRvYmoKODkgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzI4LjM1IDQwMS44MTI1IDgxMy41MjUgNTAwLjM2MjVdCj4+CmVuZG9iago5MCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMzYuODYyNSA0MDcuNDc1MDQgMzg4Ljc2MjQ4IDQ5NC43MDAwNF0KPj4KZW5kb2JqCjkxIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNi44NjI1IDQ1NS40MDAwMiAzODguNzYyNDggNDgxLjJdCj4+CmVuZG9iago5MiAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMzYuODYyNSA0MDcuNDc1MDQgMzg4Ljc2MjQ4IDQ0MS45MDAwMl0KPj4KZW5kb2JqCjkzIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs0MDUuNzg3NSA0MDcuNDc1MDQgODA1LjAxMjUgNDk0LjcwMDA0XQo+PgplbmRvYmoKOTQgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzQwNS43ODc1IDQ0Ni44MTI1IDgwNS4wMTI1IDQ3Mi42MTI1XQo+PgplbmRvYmoKOTUgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzQwNS43ODc1IDQxNi4xMDAwNCA4MDUuMDEyNSA0MzMuMzEyNTNdCj4+CmVuZG9iago5NiAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgMzYyLjUxMjUgODEzLjUyNSAzODguMzEyNV0KPj4KZW5kb2JqCjk3IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyOC4zNSAyMzYuNTg3NTIgODEzLjUyNSAzNDkuMDEyNV0KPj4KZW5kb2JqCjk4IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyOC4zNSAyOTEuOTM3NTMgODEzLjUyNSAzNDkuMDEyNTRdCj4+CmVuZG9iago5OSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgMzIwLjQ3NSA4MTMuNTI1IDM0OS4wMTI1XQo+PgplbmRvYmoKMTAwIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNi44NjI1IDI5Ny42IDIxMS4xNjI1IDM0My4zNV0KPj4KZW5kb2JqCjEwMSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjI4LjE4NzUgMzI2LjEzNzUgNTAyLjM1IDM0My4zNV0KPj4KZW5kb2JqCjEwMiAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbNTE5LjM3NSAyOTcuNiA2MzkuNTYyNSAzNDMuMzVdCj4+CmVuZG9iagoxMDMgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzY1Ni41ODc1IDI5Ny42IDgwNS4wMTI1IDM0My4zNV0KPj4KZW5kb2JqCjEwNCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgMjkxLjkzNzUzIDgxMy41MjUgMzIwLjQ3NTA0XQo+PgplbmRvYmoKMTA1IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyMjguMTg3NSAyOTcuNiAzMzguOTI1IDMxNC44MTI1XQo+PgplbmRvYmoKMTA2IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNTUuOTUgMjk3LjYgMzk0LjA1MDAyIDMxNC44MTI1XQo+PgplbmRvYmoKMTA3IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs0MTEuMDc1IDI5Ny42IDQ0OC4yIDMxNC44MTI1XQo+PgplbmRvYmoKMTA4IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs0NjUuMjI1IDI5Ny42IDUwMi4zNSAzMTQuODEyNV0KPj4KZW5kb2JqCjEwOSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgMjM2LjU4NzUyIDgxMy41MjUgMjkxLjkzNzUzXQo+PgplbmRvYmoKMTEwIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyOC4zNSAyNjMuNDAwMDIgODEzLjUyNSAyOTEuOTM3NTNdCj4+CmVuZG9iagoxMTEgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM2Ljg2MjUgMjY5LjA2MjUzIDIxMC43ODc1IDI4Ni4yNzUwMl0KPj4KZW5kb2JqCjExMiAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjI4LjU2MjUgMjY5LjA2MjUzIDMzOC41NSAyODYuMjc1MDJdCj4+CmVuZG9iagoxMTMgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM1Ni4zMjUgMjY5LjA2MjUzIDM5My42NzUwMiAyODYuMjc1MDJdCj4+CmVuZG9iagoxMTQgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzQxMS40NSAyNjkuMDYyNTMgNDQ3LjgyNSAyODYuMjc1MDJdCj4+CmVuZG9iagoxMTUgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzQ2NS42IDI2OS4wNjI1MyA1MDEuOTc1IDI4Ni4yNzUwMl0KPj4KZW5kb2JqCjExNiAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbNTE5Ljc1IDI2OS4wNjI1MyA2MzkuMTg3NSAyODYuMjc1MDJdCj4+CmVuZG9iagoxMTcgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzY1Ni45NjI1IDI2OS4wNjI1MyA4MDQuNjM3NSAyODYuMjc1MDJdCj4+CmVuZG9iagoxMTggMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzI4LjM1IDIzNi41ODc1MiA4MTMuNTI1IDI2My40MDAwMl0KPj4KZW5kb2JqCjExOSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMzYuODYyNSAyNDIuMjUwMDMgODA0LjYzNzUgMjU3LjczNzUyXQo+PgplbmRvYmoKMTIwIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyOC4zNSAxOTcuMjg3NSA4MTMuNTI1IDIyMy4wODc1MV0KPj4KZW5kb2JqCjEyMSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgOTguMTc1MDIgODEzLjUyNSAxODMuNzg3NTJdCj4+CmVuZG9iagoxMjIgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzI4LjM1IDEyNi43MTI1MjQgODEzLjUyNSAxODMuNzg3NTJdCj4+CmVuZG9iagoxMjMgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzI4LjM1IDE1NS4yNSA4MTMuNTI1IDE4My43ODc1XQo+PgplbmRvYmoKMTI0IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNi44NjI1IDEzMi4zNzUgMjM3LjIyNSAxNzguMTI1XQo+PgplbmRvYmoKMTI1IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyNTQuMjUgMTYwLjkxMjUgNTEzLjE1IDE3OC4xMjVdCj4+CmVuZG9iagoxMjYgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzUzMC4xNzUgMTMyLjM3NSA2MDUuNjYyNSAxNzguMTI1XQo+PgplbmRvYmoKMTI3IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs2MjIuNjg3NSAxMzIuMzc1IDgwNS4wMTI1IDE3OC4xMjVdCj4+CmVuZG9iagoxMjggMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzI4LjM1IDEyNi43MTI1MjQgODEzLjUyNSAxNTUuMjUwMDNdCj4+CmVuZG9iagoxMjkgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzI1NC4yNSAxMzIuMzc1IDMxNi4xNjI1IDE0OS41ODc1XQo+PgplbmRvYmoKMTMwIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszMzMuMTg3NSAxMzIuMzc1IDM4Mi41NzUgMTQ5LjU4NzVdCj4+CmVuZG9iagoxMzEgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM5OS42IDEzMi4zNzUgNDQ3Ljg2MjUyIDE0OS41ODc1XQo+PgplbmRvYmoKMTMyIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs0NjQuODg3NSAxMzIuMzc1IDUxMy4xNSAxNDkuNTg3NV0KPj4KZW5kb2JqCjEzMyAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgOTguMTc1MDIgODEzLjUyNSAxMjYuNzEyNTJdCj4+CmVuZG9iagoxMzQgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzI4LjM1IDk4LjE3NTAyIDgxMy41MjUgMTI2LjcxMjUyXQo+PgplbmRvYmoKMTM1IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNi44NjI1IDEwMy44Mzc1MjQgODA0LjYzNzUgMTIxLjA1MDAyNl0KPj4KZW5kb2JqCjEzNiAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgNTE2LjQ1IDI1Ny43NzUgNTUwLjgzNzVdCj4+CmVuZG9iagoxMzcgMCBvYmoKPDwKL01DSUQgMAo+PgplbmRvYmoKMTM4IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyOC4zNSA1MTYuNDUgMjU3Ljc3NSA1NTAuODM3NV0KPj4KZW5kb2JqCjEzOSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMzYuODYyNSA0NTUuNDAwMDIgOTYuOSA0ODEuMl0KPj4KZW5kb2JqCjE0MCAwIG9iago8PAovTUNJRCAxCj4+CmVuZG9iagoxNDEgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM2Ljg2MjUgNDU1LjQwMDAyIDk2LjkgNDgxLjJdCj4+CmVuZG9iagoxNDIgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM2Ljg2MjUgNDI0LjY4NzUgMjAyLjMxMjUgNDQxLjldCj4+CmVuZG9iagoxNDMgMCBvYmoKPDwKL01DSUQgMgo+PgplbmRvYmoKMTQ0IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNi44NjI1IDQyNC42ODc1IDIwMi4zMTI1IDQ0MS45XQo+PgplbmRvYmoKMTQ1IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyMDIuMzEyNSA0MjQuNjg3NSAyMDIuMzEyNSA0NDEuOV0KPj4KZW5kb2JqCjE0NiAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjAyLjMxMjUgNDI0LjY4NzUgMjAyLjMxMjUgNDQxLjldCj4+CmVuZG9iagoxNDcgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzIwMi4zMTI1IDQyNC42ODc1IDIwMi4zMTI1IDQ0MS45XQo+PgplbmRvYmoKMTQ4IDAgb2JqCjw8Ci9NQ0lEIDMKPj4KZW5kb2JqCjE0OSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjAyLjMxMjUgNDI0LjY4NzUgMjAyLjMxMjUgNDQxLjldCj4+CmVuZG9iagoxNTAgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM2Ljg2MjUgNDA3LjQ3NTA0IDk2LjkzNzUgNDI0LjY4NzUzXQo+PgplbmRvYmoKMTUxIDAgb2JqCjw8Ci9NQ0lEIDQKPj4KZW5kb2JqCjE1MiAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMzYuODYyNSA0MDcuNDc1MDQgOTYuOTM3NSA0MjQuNjg3NTNdCj4+CmVuZG9iagoxNTMgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM2Ljg2MjUgNDA3LjQ3NTA0IDM2Ljg2MjUgNDI0LjY4NzUzXQo+PgplbmRvYmoKMTU0IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNi44NjI1IDQwNy40NzUwNCAzNi44NjI1IDQyNC42ODc1M10KPj4KZW5kb2JqCjE1NSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMzYuODYyNSA0MDcuNDc1MDQgMzYuODYyNSA0MjQuNjg3NTNdCj4+CmVuZG9iagoxNTYgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM2Ljg2MjUgNDA3LjQ3NTA0IDM2Ljg2MjUgNDI0LjY4NzUzXQo+PgplbmRvYmoKMTU3IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNi44NjI1IDQwNy40NzUwNCAzNi44NjI1IDQyNC42ODc1M10KPj4KZW5kb2JqCjE1OCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMzYuODYyNSA0MDcuNDc1MDQgMzYuODYyNSA0MjQuNjg3NTNdCj4+CmVuZG9iagoxNTkgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzQwNS43ODc1IDQ0Ni44MTI1IDU5MC44NSA0NzIuNjEyNV0KPj4KZW5kb2JqCjE2MCAwIG9iago8PAovTUNJRCA1Cj4+CmVuZG9iagoxNjEgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzQwNS43ODc1IDQ0Ni44MTI1IDU5MC44NSA0NzIuNjEyNV0KPj4KZW5kb2JqCjE2MiAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbNDA1Ljc4NzUgNDE2LjEwMDA0IDQ0MC40NzUgNDMzLjMxMjUzXQo+PgplbmRvYmoKMTYzIDAgb2JqCjw8Ci9NQ0lEIDYKPj4KZW5kb2JqCjE2NCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbNDA1Ljc4NzUgNDE2LjEwMDA0IDQ0MC40NzUgNDMzLjMxMjUzXQo+PgplbmRvYmoKMTY1IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyOC4zNSAzNjIuNTEyNSAxODIuNDM3NTIgMzg4LjMxMjVdCj4+CmVuZG9iagoxNjYgMCBvYmoKPDwKL01DSUQgNwo+PgplbmRvYmoKMTY3IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyOC4zNSAzNjIuNTEyNSAxODIuNDM3NTIgMzg4LjMxMjVdCj4+CmVuZG9iagoxNjggMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM2Ljg2MjUgMzExLjg4NzUgMTQ3LjYgMzI5LjFdCj4+CmVuZG9iagoxNjkgMCBvYmoKPDwKL01DSUQgOAo+PgplbmRvYmoKMTcwIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNi44NjI1IDMxMS44ODc1IDE0Ny42IDMyOS4xXQo+PgplbmRvYmoKMTcxIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyMjguMTg3NSAzMjYuMTM3NSAyNjkuNTUgMzQzLjM1XQo+PgplbmRvYmoKMTcyIDAgb2JqCjw8Ci9NQ0lEIDkKPj4KZW5kb2JqCjE3MyAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjI4LjE4NzUgMzI2LjEzNzUgMjY5LjU1IDM0My4zNV0KPj4KZW5kb2JqCjE3NCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbNTE5LjM3NSAzMTEuODg3NSA1NTYuNzI1IDMyOS4xXQo+PgplbmRvYmoKMTc1IDAgb2JqCjw8Ci9NQ0lEIDEwCj4+CmVuZG9iagoxNzYgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzUxOS4zNzUgMzExLjg4NzUgNTU2LjcyNSAzMjkuMV0KPj4KZW5kb2JqCjE3NyAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbNjU2LjU4NzUgMzExLjg4NzUgNzU2LjY3NTA1IDMyOS4xXQo+PgplbmRvYmoKMTc4IDAgb2JqCjw8Ci9NQ0lEIDExCj4+CmVuZG9iagoxNzkgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzY1Ni41ODc1IDMxMS44ODc1IDc1Ni42NzUwNSAzMjkuMV0KPj4KZW5kb2JqCjE4MCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjI4LjE4NzUgMjk3LjYgMjU3LjU1IDMxNC44MTI1XQo+PgplbmRvYmoKMTgxIDAgb2JqCjw8Ci9NQ0lEIDEyCj4+CmVuZG9iagoxODIgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzIyOC4xODc1IDI5Ny42IDI1Ny41NSAzMTQuODEyNV0KPj4KZW5kb2JqCjE4MyAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMzU1Ljk1IDI5Ny42IDM3Ny45NjI1MiAzMTQuODEyNV0KPj4KZW5kb2JqCjE4NCAwIG9iago8PAovTUNJRCAxMwo+PgplbmRvYmoKMTg1IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNTUuOTUgMjk3LjYgMzc3Ljk2MjUyIDMxNC44MTI1XQo+PgplbmRvYmoKMTg2IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs0MTEuMDc1IDI5Ny42IDQzMi40MTI1IDMxNC44MTI1XQo+PgplbmRvYmoKMTg3IDAgb2JqCjw8Ci9NQ0lEIDE0Cj4+CmVuZG9iagoxODggMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzQxMS4wNzUgMjk3LjYgNDMyLjQxMjUgMzE0LjgxMjVdCj4+CmVuZG9iagoxODkgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzQ2NS4yMjUgMjk3LjYgNDg2LjU2MjUgMzE0LjgxMjVdCj4+CmVuZG9iagoxOTAgMCBvYmoKPDwKL01DSUQgMTUKPj4KZW5kb2JqCjE5MSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbNDY1LjIyNSAyOTcuNiA0ODYuNTYyNSAzMTQuODEyNV0KPj4KZW5kb2JqCjE5MiAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMzYuODYyNSAyNjkuMDYyNTMgMTU0LjkxMjUgMjg2LjI3NTAyXQo+PgplbmRvYmoKMTkzIDAgb2JqCjw8Ci9NQ0lEIDE2Cj4+CmVuZG9iagoxOTQgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM2Ljg2MjUgMjY5LjA2MjUzIDE1NC45MTI1IDI4Ni4yNzUwMl0KPj4KZW5kb2JqCjE5NSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjI4LjU2MjUgMjY5LjA2MjUzIDMwMS4yNzUgMjg2LjI3NTAyXQo+PgplbmRvYmoKMTk2IDAgb2JqCjw8Ci9NQ0lEIDE3Cj4+CmVuZG9iagoxOTcgMCBvYmoKPDwKL01DSUQgMTgKPj4KZW5kb2JqCjE5OCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjI4LjU2MjUgMjY5LjA2MjUzIDMwMS4yNzUgMjg2LjI3NTAyXQo+PgplbmRvYmoKMTk5IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyNDguNTg3NTEgMjY5LjA2MjUzIDMwMS4yNzUwMiAyODYuMjc1MDJdCj4+CmVuZG9iagoyMDAgMCBvYmoKPDwKL01DSUQgMTkKPj4KZW5kb2JqCjIwMSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjQ4LjU4NzUxIDI2OS4wNjI1MyAzMDEuMjc1MDIgMjg2LjI3NTAyXQo+PgplbmRvYmoKMjAyIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNTYuMzI1IDI2OS4wNjI1MyAzNjguMzI1IDI4Ni4yNzUwMl0KPj4KZW5kb2JqCjIwMyAwIG9iago8PAovTUNJRCAyMAo+PgplbmRvYmoKMjA0IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNTYuMzI1IDI2OS4wNjI1MyAzNjguMzI1IDI4Ni4yNzUwMl0KPj4KZW5kb2JqCjIwNSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbNDExLjQ1IDI2OS4wNjI1MyA0MjMuNDUgMjg2LjI3NTAyXQo+PgplbmRvYmoKMjA2IDAgb2JqCjw8Ci9NQ0lEIDIxCj4+CmVuZG9iagoyMDcgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzQxMS40NSAyNjkuMDYyNTMgNDIzLjQ1IDI4Ni4yNzUwMl0KPj4KZW5kb2JqCjIwOCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbNDY1LjYgMjY5LjA2MjUzIDQ3Ny42IDI4Ni4yNzUwMl0KPj4KZW5kb2JqCjIwOSAwIG9iago8PAovTUNJRCAyMgo+PgplbmRvYmoKMjEwIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs0NjUuNiAyNjkuMDYyNTMgNDc3LjYgMjg2LjI3NTAyXQo+PgplbmRvYmoKMjExIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs1MTkuNzUgMjY5LjA2MjUzIDU5NS44IDI4Ni4yNzUwMl0KPj4KZW5kb2JqCjIxMiAwIG9iago8PAovTUNJRCAyMwo+PgplbmRvYmoKMjEzIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs1MTkuNzUgMjY5LjA2MjUzIDU5NS44IDI4Ni4yNzUwMl0KPj4KZW5kb2JqCjIxNCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbNjU2Ljk2MjUgMjY5LjA2MjUzIDcxMS4wIDI4Ni4yNzUwMl0KPj4KZW5kb2JqCjIxNSAwIG9iago8PAovTUNJRCAyNAo+PgplbmRvYmoKMjE2IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs2NTYuOTYyNSAyNjkuMDYyNTMgNzExLjAgMjg2LjI3NTAyXQo+PgplbmRvYmoKMjE3IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNi44NjI1IDI0Mi4yNTAwMyAxNzMuMTc1IDI1Ny43Mzc1Ml0KPj4KZW5kb2JqCjIxOCAwIG9iago8PAovTUNJRCAyNQo+PgplbmRvYmoKMjE5IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNi44NjI1IDI0Mi4yNTAwMyAxNzMuMTc1IDI1Ny43Mzc1Ml0KPj4KZW5kb2JqCjIyMCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMjguMzUgMTk3LjI4NzUgMjI1LjQ4NzUyIDIyMy4wODc1MV0KPj4KZW5kb2JqCjIyMSAwIG9iago8PAovTUNJRCAyNgo+PgplbmRvYmoKMjIyIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyOC4zNSAxOTcuMjg3NSAyMjUuNDg3NTIgMjIzLjA4NzUxXQo+PgplbmRvYmoKMjIzIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszNi44NjI1IDE0Ni42NjI1IDE0Ny42IDE2My44NzVdCj4+CmVuZG9iagoyMjQgMCBvYmoKPDwKL01DSUQgMjcKPj4KZW5kb2JqCjIyNSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMzYuODYyNSAxNDYuNjYyNSAxNDcuNiAxNjMuODc1XQo+PgplbmRvYmoKMjI2IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyNTQuMjUgMTYwLjkxMjUgMjk1LjYxMjUgMTc4LjEyNV0KPj4KZW5kb2JqCjIyNyAwIG9iago8PAovTUNJRCAyOAo+PgplbmRvYmoKMjI4IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyNTQuMjUgMTYwLjkxMjUgMjk1LjYxMjUgMTc4LjEyNV0KPj4KZW5kb2JqCjIyOSAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbNTMwLjE3NSAxNDYuNjYyNSA1NjcuNTI0OTYgMTYzLjg3NV0KPj4KZW5kb2JqCjIzMCAwIG9iago8PAovTUNJRCAyOQo+PgplbmRvYmoKMjMxIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs1MzAuMTc1IDE0Ni42NjI1IDU2Ny41MjQ5NiAxNjMuODc1XQo+PgplbmRvYmoKMjMyIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs2MjIuNjg3NSAxNDYuNjYyNSA3MjIuNzc1IDE2My44NzVdCj4+CmVuZG9iagoyMzMgMCBvYmoKPDwKL01DSUQgMzAKPj4KZW5kb2JqCjIzNCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbNjIyLjY4NzUgMTQ2LjY2MjUgNzIyLjc3NSAxNjMuODc1XQo+PgplbmRvYmoKMjM1IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyNTQuMjUgMTMyLjM3NSAyODMuNjEyNSAxNDkuNTg3NV0KPj4KZW5kb2JqCjIzNiAwIG9iago8PAovTUNJRCAzMQo+PgplbmRvYmoKMjM3IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFsyNTQuMjUgMTMyLjM3NSAyODMuNjEyNSAxNDkuNTg3NV0KPj4KZW5kb2JqCjIzOCAwIG9iago8PAovVHlwZSAvQmFja2dyb3VuZAovQkJveCBbMzMzLjE4NzUgMTMyLjM3NSAzNTUuMiAxNDkuNTg3NV0KPj4KZW5kb2JqCjIzOSAwIG9iago8PAovTUNJRCAzMgo+PgplbmRvYmoKMjQwIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszMzMuMTg3NSAxMzIuMzc1IDM1NS4yIDE0OS41ODc1XQo+PgplbmRvYmoKMjQxIDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFszOTkuNiAxMzIuMzc1IDQyMC45Mzc1IDE0OS41ODc1XQo+PgplbmRvYmoKMjQyIDAgb2JqCjw8Ci9NQ0lEIDMzCj4+CmVuZG9iagoyNDMgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM5OS42IDEzMi4zNzUgNDIwLjkzNzUgMTQ5LjU4NzVdCj4+CmVuZG9iagoyNDQgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzQ2NC44ODc1IDEzMi4zNzUgNDg2LjIyNSAxNDkuNTg3NV0KPj4KZW5kb2JqCjI0NSAwIG9iago8PAovTUNJRCAzNAo+PgplbmRvYmoKMjQ2IDAgb2JqCjw8Ci9UeXBlIC9CYWNrZ3JvdW5kCi9CQm94IFs0NjQuODg3NSAxMzIuMzc1IDQ4Ni4yMjUgMTQ5LjU4NzVdCj4+CmVuZG9iagoyNDcgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM2Ljg2MjUgMTAzLjgzNzUyNCAxMjcuNjEyNSAxMjEuMDUwMDI2XQo+PgplbmRvYmoKMjQ4IDAgb2JqCjw8Ci9NQ0lEIDM1Cj4+CmVuZG9iagoyNDkgMCBvYmoKPDwKL1R5cGUgL0JhY2tncm91bmQKL0JCb3ggWzM2Ljg2MjUgMTAzLjgzNzUyNCAxMjcuNjEyNSAxMjEuMDUwMDI2XQo+PgplbmRvYmoKMjUwIDAgb2JqCjw8Ci9UeXBlIC9Gb250Ci9CYXNlRm9udCAvQUFBSExFK0FyaW1vLUl0YWxpYwovU3VidHlwZSAvVHlwZTAKL0VuY29kaW5nIC9JZGVudGl0eS1ICi9EZXNjZW5kYW50Rm9udHMgWzI1NSAwIFJdCi9Ub1VuaWNvZGUgMjU2IDAgUgo+PgplbmRvYmoKMjUxIDAgb2JqCjw8Ci9UeXBlIC9Gb250Ci9CYXNlRm9udCAvQUFBUldIK0FyaW1vLVJlZ3VsYXIKL1N1YnR5cGUgL1R5cGUwCi9FbmNvZGluZyAvSWRlbnRpdHktSAovRGVzY2VuZGFudEZvbnRzIFsyNTcgMCBSXQovVG9Vbmljb2RlIDI1OCAwIFIKPj4KZW5kb2JqCjI1MiAwIG9iago8PAovVHlwZSAvRm9udAovQmFzZUZvbnQgL0FBQU1PRCtBcmltby1Cb2xkCi9TdWJ0eXBlIC9UeXBlMAovRW5jb2RpbmcgL0lkZW50aXR5LUgKL0Rlc2NlbmRhbnRGb250cyBbMjU5IDAgUl0KL1RvVW5pY29kZSAyNjAgMCBSCj4+CmVuZG9iagoyNTMgMCBvYmoKPDwKL2dzMSAyNjEgMCBSCj4+CmVuZG9iagoyNTQgMCBvYmoKPDwKL1R5cGUgL1N0cnVjdEVsZW0KL1MgL1RSCi9QIDU1IDAgUgovUGcgOSAwIFIKL0sgWzU4IDAgUiA2MiAwIFJdCj4+CmVuZG9iagoyNTUgMCBvYmoKPDwKL1R5cGUgL0ZvbnQKL1N1YnR5cGUgL0NJREZvbnRUeXBlMgovQmFzZUZvbnQgL0FBQUhMRStBcmltby1JdGFsaWMKL0NJRFN5c3RlbUluZm8gMjYyIDAgUgovRm9udERlc2NyaXB0b3IgMjYzIDAgUgovVyBbMCBbNzUwIDI3OCA2NjddCiA0IFs3MjJdCiA2IFs2NjcgNjExIDc3OF0KIDEwIFsyNzhdCiAxNCBbODMzIDcyMl0KMTkgWzcyMiA2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DQowMDAwMDA4NzUyIDAwMDAwIG4NCjAwMDAwMDkwMTUgMDAwMDAgbg0KMDAwMDAwOTEwMSAwMDAwMCBuDQowMDAwMDA5Mzg4IDAwMDAwIG4NCjAwMDAwMTE3MTAgMDAwMDAgbg0KMDAwMDAxMTc5MyAwMDAwMCBuDQowMDAwMDExOTA4IDAwMDAwIG4NCjAwMDAwMTE5ODAgMDAwMDAgbg0KMDAwMDAxMjA1MiAwMDAwMCBuDQowMDAwMDEyMTM1IDAwMDAwIG4NCjAwMDAwMTIyMDkgMDAwMDAgbg0KMDAwMDAxMjI5MiAwMDAwMCBuDQowMDAwMDEyMzY0IDAwMDAwIG4NCjAwMDAwMTI0MzcgMDAwMDAgbg0KMDAwMDAxMjUwOSAwMDAwMCBuDQowMDAwMDEyNTkxIDAwMDAwIG4NCjAwMDAwMTI2NzMgMDAwMDAgbg0KMDAwMDAxMjc1NiAwMDAwMCBuDQowMDAwMDEyODM5IDAwMDAwIG4NCjAwMDAwMTI5MTIgMDAwMDAgbg0KMDAwMDAxMjk4NSAwMDAwMCBuDQowMDAwMDEzMDU4IDAwMDAwIG4NCjAwMDAwMTMxMzEgMDAwMDAgbg0KMDAwMDAxMzIwNCAwMDAwMCBuDQowMDAwMDEzMjkxIDAwMDAwIG4NCjAwMDAwMTMzNjYgMDAwMDAgbg0KMDAwMDAxMzQzOSAwMDAwMCBuDQowMDAwMDEzNTEyIDAwMDAwIG4NCjAwMDAwMTM1ODUgMDAwMDAgbg0KMDAwMDAxMzY1OCAwMDAwMCBuDQowMDAwMDEzNzMxIDAwMDAwIG4NCjAwMDAwMTM4MTQgMDAwMDAgbg0KMDAwMDAxMzg4NyAwMDAwMCBuDQowMDAwMDEzOTcwIDAwMDAwIG4NCjAwMDAwMTQwNTMgMDAwMDAgbg0KMDAwMDAxNDEzNiAwMDAwMCBuDQowMDAwMDE0MjE5IDAwMDAwIG4NCjAwMDAwMTQyOTIgMDAwMDAgbg0KMDAwMDAxNDM2NSAwMDAwMCBuDQowMDAwMDE0NDM4IDAwMDAwIG4NCjAwMDAwMTQ1MTEgMDAwMDAgbg0KMDAwMDAxNDU5NCAwMDAwMCBuDQowMDAwMDE3MzYyIDAwMDAwIG4NCjAwMDAwMTc0MjAgMDAwMDAgbg0KMDAwMDAyMzExMCAwMDAwMCBuDQowMDAwMDIzMTkxIDAwMDAwIG4NCjAwMDAwMjMyOTQgMDAwMDAgbg0KMDAwMDAyMzM5MCAwMDAwMCBuDQowMDAwMDIzNDc3IDAwMDAwIG4NCjAwMDAwMjM1NjQgMDAwMDAgbg0KMDAwMDAyMzY0MyAwMDAwMCBuDQowMDAwMDIzNzEyIDAwMDAwIG4NCjAwMDAwMjM3OTkgMDAwMDAgbg0KMDAwMDAyMzg5OSAwMDAwMCBuDQowMDAwMDIzOTQyIDAwMDAwIG4NCjAwMDAwMjM5ODUgMDAwMDAgbg0KMDAwMDAyNDAyOCAwMDAwMCBuDQowMDAwMDI0MDcxIDAwMDAwIG4NCjAwMDAwMjQxNzEgMDAwMDAgbg0KMDAwMDAyNDI5MiAwMDAwMCBuDQowMDAwMDI0MzY5IDAwMDAwIG4NCjAwMDAwMjQ0NDYgMDAwMDAgbg0KMDAwMDAyNDQ4OSAwMDAwMCBuDQowMDAwMDI0NTg5IDAwMDAwIG4NCjAwMDAwMjQ2MzIgMDAwMDAgbg0KMDAwMDAyNDY3NSAwMDAwMCBuDQowMDAwMDI0NzE4IDAwMDAwIG4NCjAwMDAwMjQ3NjEgMDAwMDAgbg0KMDAwMDAyNDg2MSAwMDAwMCBuDQowMDAwMDI0OTM4IDAwMDAwIG4NCjAwMDAwMjQ5ODEgMDAwMDAgbg0KMDAwMDAyNTAyMSAwMDAwMCBuDQowMDAwMDI1MDYxIDAwMDAwIG4NCjAwMDAwMjUxNDIgMDAwMDAgbg0KMDAwMDAyNTIyMyAwMDAwMCBuDQowMDAwMDI1MzA0IDAwMDAwIG4NCjAwMDAwMjUzODIgMDAwMDAgbg0KMDAwMDAyNTQ2MiAwMDAwMCBuDQowMDAwMDI1NTQyIDAwMDAwIG4NCjAwMDAwMjU2MjIgMDAwMDAgbg0KMDAwMDAyNTcwOCAwMDAwMCBuDQowMDAwMDI1NzkwIDAwMDAwIG4NCjAwMDAwMjU4NzYgMDAwMDAgbg0KMDAwMDAyNTk2MiAwMDAwMCBuDQowMDAwMDI2MDQ2IDAwMDAwIG4NCjAwMDAwMjYxMzIgMDAwMDAgbg0KMDAwMDAyNjIxMiAwMDAwMCBuDQowMDAwMDI2MjkzIDAwMDAwIG4NCjAwMDAwMjYzNzUgMDAwMDAgbg0KMDAwMDAyNjQ1NCAwMDAwMCBuDQowMDAwMDI2NTMzIDAwMDAwIG4NCjAwMDAwMjY2MTQgMDAwMDAgbg0KMDAwMDAyNjY5MyAwMDAwMCBuDQowMDAwMDI2NzczIDAwMDAwIG4NCjAwMDAwMjY4NTYgMDAwMDAgbg0KMDAwMDAyNjkzNyAwMDAwMCBuDQowMDAwMDI3MDE4IDAwMDAwIG4NCjAwMDAwMjcwOTYgMDAwMDAgbg0KMDAwMDAyNzE3NSAwMDAwMCBuDQowMDAwMDI3MjU4IDAwMDAwIG4NCjAwMDAwMjczNDEgMDAwMDAgbg0KMDAwMDAyNzQyNyAwMDAwMCBuDQowMDAwMDI3NTEyIDAwMDAwIG4NCjAwMDAwMjc1OTkgMDAwMDAgbg0KMDAwMDAyNzY4MyAwMDAwMCBuDQowMDAwMDI3NzY2IDAwMDAwIG4NCjAwMDAwMjc4NTEgMDAwMDAgbg0KMDAwMDAyNzkzOCAwMDAwMCBuDQowMDAwMDI4MDIxIDAwMDAwIG4NCjAwMDAwMjgxMDcgMDAwMDAgbg0KMDAwMDAyODE4OSAwMDAwMCBuDQowMDAwMDI4MjcxIDAwMDAwIG4NCjAwMDAwMjgzNTUgMDAwMDAgbg0KMDAwMDAyODQzNCAwMDAwMCBuDQowMDAwMDI4NTE1IDAwMDAwIG4NCjAwMDAwMjg1OTUgMDAwMDAgbg0KMDAwMDAyODY3NyAwMDAwMCBuDQowMDAwMDI4NzYwIDAwMDAwIG4NCjAwMDAwMjg4NDQgMDAwMDAgbg0KMDAwMDAyODkyNiAwMDAwMCBuDQowMDAwMDI5MDA5IDAwMDAwIG4NCjAwMDAwMjkwOTEgMDAwMDAgbg0KMDAwMDAyOTE3MyAwMDAwMCBuDQowMDAwMDI5MjU1IDAwMDAwIG4NCjAwMDAwMjkzMzcgMDAwMDAgbg0KMDAwMDAyOTQyNSAwMDAwMCBuDQowMDAwMDI5NTA0IDAwMDAwIG4NCjAwMDAwMjk1MzUgMDAwMDAgbg0KMDAwMDAyOTYxNCAwMDAwMCBuDQowMDAwMDI5NjkyIDAwMDAwIG4NCjAwMDAwMjk3MjMgMDAwMDAgbg0KMDAwMDAyOTgwMSAwMDAwMCBuDQowMDAwMDI5ODgyIDAwMDAwIG4NCjAwMDAwMjk5MTMgMDAwMDAgbg0KMDAwMDAyOTk5NCAwMDAwMCBuDQowMDAwMDMwMDc2IDAwMDAwIG4NCjAwMDAwMzAxNTggMDAwMDAgbg0KMDAwMDAzMDI0MCAwMDAwMCBuDQowMDAwMDMwMjcxIDAwMDAwIG4NCjAwMDAwMzAzNTMgMDAwMDAgbg0KMDAwMDAzMDQzOCAwMDAwMCBuDQowMDAwMDMwNDY5IDAwMDAwIG4NCjAwMDAwMzA1NTQgMDAwMDAgbg0KMDAwMDAzMDYzOSAwMDAwMCBuDQowMDAwMDMwNzI0IDAwMDAwIG4NCjAwMDAwMzA4MDkgMDAwMDAgbg0KMDAwMDAzMDg5NCAwMDAwMCBuDQowMDAwMDMwOTc5IDAwMDAwIG4NCjAwMDAwMzEwNjQgMDAwMDAgbg0KMDAwMDAzMTE0NyAwMDAwMCBuDQowMDAwMDMxMTc4IDAwMDAwIG4NCjAwMDAwMzEyNjEgMDAwMDAgbg0KMDAwMDAzMTM0NyAwMDAwMCBuDQowMDAwMDMxMzc4IDAwMDAwIG4NCjAwMDAwMzE0NjQgMDAwMDAgbg0KMDAwMDAzMTU0NyAwMDAwMCBuDQowMDAwMDMxNTc4IDAwMDAwIG4NCjAwMDAwMzE2NjEgMDAwMDAgbg0KMDAwMDAzMTczOSAwMDAwMCBuDQowMDAwMDMxNzcwIDAwMDAwIG4NCjAwMDAwMzE4NDggMDAwMDAgbg0KMDAwMDAzMTkyOSAwMDAwMCBuDQowMDAwMDMxOTYwIDAwMDAwIG4NCjAwMDAwMzIwNDEgMDAwMDAgbg0KMDAwMDAzMjEyMSAwMDAwMCBuDQowMDAwMDMyMTUzIDAwMDAwIG4NCjAwMDAwMzIyMzMgMDAwMDAgbg0KMDAwMDAzMjMxNiAwMDAwMCBuDQowMDAwMDMyMzQ4IDAwMDAwIG4NCjAwMDAwMzI0MzEgMDAwMDAgbg0KMDAwMDAzMjUxMSAwMDAwMCBuDQowMDAwMDMyNTQzIDAwMDAwIG4NCjAwMDAwMzI2MjMgMDAwMDAgbg0KMDAwMDAzMjcwNCAwMDAwMCBuDQowMDAwMDMyNzM2IDAwMDAwIG4NCjAwMDAwMzI4MTcgMDAwMDAgbg0KMDAwMDAzMjg5OCAwMDAwMCBuDQowMDAwMDMyOTMwIDAwMDAwIG4NCjAwMDAwMzMwMTEgMDAwMDAgbg0KMDAwMDAzMzA5MiAwMDAwMCBuDQowMDAwMDMzMTI0IDAwMDAwIG4NCjAwMDAwMzMyMDUgMDAwMDAgbg0KMDAwMDAzMzI5MSAwMDAwMCBuDQowMDAwMDMzMzIzIDAwMDAwIG4NCjAwMDAwMzM0MDkgMDAwMDAgbg0KMDAwMDAzMzQ5NSAwMDAwMCBuDQowMDAwMDMzNTI3IDAwMDAwIG4NCjAwMDAwMzM1NTkgMDAwMDAgbg0KMDAwMDAzMzY0NSAwMDAwMCBuDQowMDAwMDMzNzM0IDAwMDAwIG4NCjAwMDAwMzM3NjYgMDAwMDAgbg0KMDAwMDAzMzg1NSAwMDAwMCBuDQowMDAwMDMzOTQwIDAwMDAwIG4NCjAwMDAwMzM5NzIgMDAwMDAgbg0KMDAwMDAzNDA1NyAwMDAwMCBuDQowMDAwMDM0MTQwIDAwMDAwIG4NCjAwMDAwMzQxNzIgMDAwMDAgbg0KMDAwMDAzNDI1NSAwMDAwMCBuDQowMDAwMDM0MzM2IDAwMDAwIG4NCjAwMDAwMzQzNjggMDAwMDAgbg0KMDAwMDAzNDQ0OSAwMDAwMCBuDQowMDAwMDM0NTMxIDAwMDAwIG4NCjAwMDAwMzQ1NjMgMDAwMDAgbg0KMDAwMDAzNDY0NSAwMDAwMCBuDQowMDAwMDM0NzI5IDAwMDAwIG4NCjAwMDAwMzQ3NjEgMDAwMDAgbg0KMDAwMDAzNDg0NSAwMDAwMCBuDQowMDAwMDM0OTMwIDAwMDAwIG4NCjAwMDAwMzQ5NjIgMDAwMDAgbg0KMDAwMDAzNTA0NyAwMDAwMCBuDQowMDAwMDM1MTMxIDAwMDAwIG4NCjAwMDAwMzUxNjMgMDAwMDAgbg0KMDAwMDAzNTI0NyAwMDAwMCBuDQowMDAwMDM1MzI3IDAwMDAwIG4NCjAwMDAwMzUzNTkgMDAwMDAgbg0KMDAwMDAzNTQzOSAwMDAwMCBuDQowMDAwMDM1NTIxIDAwMDAwIG4NCjAwMDAwMzU1NTMgMDAwMDAgbg0KMDAwMDAzNTYzNSAwMDAwMCBuDQowMDAwMDM1NzE5IDAwMDAwIG4NCjAwMDAwMzU3NTEgMDAwMDAgbg0KMDAwMDAzNTgzNSAwMDAwMCBuDQowMDAwMDM1OTE4IDAwMDAwIG4NCjAwMDAwMzU5NTAgMDAwMDAgbg0KMDAwMDAzNjAzMyAwMDAwMCBuDQowMDAwMDM2MTE1IDAwMDAwIG4NCjAwMDAwMzYxNDcgMDAwMDAgbg0KMDAwMDAzNjIyOSAwMDAwMCBuDQowMDAwMDM2MzEwIDAwMDAwIG4NCjAwMDAwMzYzNDIgMDAwMDAgbg0KMDAwMDAzNjQyMyAwMDAwMCBuDQowMDAwMDM2NTA0IDAwMDAwIG4NCjAwMDAwMzY1MzYgMDAwMDAgbg0KMDAwMDAzNjYxNyAwMDAwMCBuDQowMDAwMDM2NzAwIDAwMDAwIG4NCjAwMDAwMzY3MzIgMDAwMDAgbg0KMDAwMDAzNjgxNSAwMDAwMCBuDQowMDAwMDM2OTAzIDAwMDAwIG4NCjAwMDAwMzY5MzUgMDAwMDAgbg0KMDAwMDAzNzAyMyAwMDAwMCBuDQowMDAwMDM3MTczIDAwMDAwIG4NCjAwMDAwMzczMjQgMDAwMDAgbg0KMDAwMDAzNzQ3MiAwMDAwMCBuDQowMDAwMDM3NTA4IDAwMDAwIG4NCjAwMDAwMzc1OTUgMDAwMDAgbg0KMDAwMDAzODAzNiAwMDAwMCBuDQowMDAwMDM4NDc2IDAwMDAwIG4NCjAwMDAwMzg5NTggMDAwMDAgbg0KMDAwMDAzOTM4NiAwMDAwMCBuDQowMDAwMDM5NzE0IDAwMDAwIG4NCjAwMDAwNDAxMDYgMDAwMDAgbg0KMDAwMDA0MDE2MiAwMDAwMCBuDQowMDAwMDQwMjM4IDAwMDAwIG4NCjAwMDAwNDA1NDEgMDAwMDAgbg0KMDAwMDA0MDcyNCAwMDAwMCBuDQowMDAwMDQwODAwIDAwMDAwIG4NCjAwMDAwNDExMDAgMDAwMDAgbg0KMDAwMDA0MTMxMyAwMDAwMCBuDQowMDAwMDQxMzg5IDAwMDAwIG4NCjAwMDAwNDE2ODYgMDAwMDAgbg0KMDAwMDA0MTgyOCAwMDAwMCBuDQowMDAwMDQ1MjE2IDAwMDAwIG4NCjAwMDAwNDUzMDQgMDAwMDAgbg0KMDAwMDA0OTA5OSAwMDAwMCBuDQowMDAwMDQ5MTg3IDAwMDAwIG4NCjAwMDAwNTA5ODMgMDAwMDAgbg0KdHJhaWxlcgo8PAovUm9vdCAxIDAgUgovSW5mbyA4IDAgUgovSUQgWzw5RTBFRjMxODM5MjcwNjBBNUNDNEJBNEJEMkM5OTZFNj4gPDlFMEVGMzE4MzkyNzA2MEE1Q0M0QkE0QkQyQzk5NkU2Pl0KL1NpemUgMjc3Cj4+CnN0YXJ0eHJlZgo1MTA3MQolJUVPRgo="

Instance: BundleProvideDocument-Response
InstanceOf: Bundle
Title: "MHD Provide Document Bundle Response for PDF publication"
Description: "MHD Provide Document Bundle Response for PDF publication"
Usage: #example
* meta.profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-mhd-providedocumentbundle-comprehensive-response"
* type = #transaction-response
* link.relation = "self"
* link.url = "http://example.org"
* entry[0].response.status = "201 Created"
* entry[=].response.location = "http://example.org/xdsretrieve?uniqueId=1.3.6.1.4.1.12559.11.13.2.1.2964&repositoryUniqueId=1.1.4567332.1.2"
* entry[=].response.lastModified = "2020-10-02T11:56:15.094+00:00"
* entry[+].response.status = "201 Created"
* entry[=].response.location = "List/68a928c0-df48-4743-a291-bfb0609bbddc"
* entry[=].response.lastModified = "2020-10-02T11:56:15.094+00:00"
* entry[+].response.status = "201 Created"
* entry[=].response.location = "DocumentReference/50383ae5-49e5-4dea-b0e6-660cb9e7b91f"
* entry[=].response.lastModified = "2020-10-02T11:56:15.101+00:00"

Instance: Bundle-FindDocumentReferences
InstanceOf: ChFindDocumentReferencesComprehensiveResponse
Title: "MHD Find DocumentReferences"
Description: "MHD Find DocumentReferences - Bundle as Response"
Usage: #example
* meta.profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-mhd-documentreference-comprehensive-bundle"
* type = #searchset
* total = 1
* link.relation = "self"
* link.url = "http://example.org/DocumentReference?patient.identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|761337610411353650&status=current"
* entry.fullUrl = "http://example.org/DocumentReference/DocRefPdf"
* entry.resource = DocRefPdf