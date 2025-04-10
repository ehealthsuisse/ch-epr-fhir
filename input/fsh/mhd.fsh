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
* context.related MS
* context.related ^comment = "May be filled with URL pointers to Resources or Identifiers found in referenceIdList"
* context.related.identifier MS
* context.related.identifier ^short = "Requirements on XDS-I.b (Swiss context): When a Imaging Document Source provides a document to the Document Repository, it must provide the StudyInstanceUID, found in the to be registered KOS object, in the referenceIdList (urn:ihe:iti:xds:2013:referenceIdList) attribute of the documentEntry metadata."

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
* entry MS
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry.fullUrl 1.. MS
* entry.fullUrl obeys ch-mhd-bdl-1

* entry contains DocumentReference 0..* and OperationOutcome 0..1
* entry[DocumentReference] ^short = "DocumentReference"
* entry[DocumentReference] ^mustSupport = true
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
* identifier MS
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