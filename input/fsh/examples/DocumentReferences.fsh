Instance: relativeReference
InstanceOf: CHMhdDocumentReferenceUnRestrictedComprehensive
Usage: #example
Description: "Example with literal relative reference only"
* extension[0].url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-deletionstatus"
* extension[=].valueCoding = urn:oid:2.16.756.5.30.1.127.3.10.18#urn:e-health-suisse:2019:deletionStatus:deletionNotRequested
* extension[+].url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-author-authorrole"
* extension[=].valueCoding = urn:oid:2.16.756.5.30.1.127.3.10.6#HCP "Healthcare professional"
* masterIdentifier.system = "urn:ietf:rfc:3986"
* masterIdentifier.value = "urn:oid:1.3.6.1.4.1.12559.11.13.2.1.2951"
* identifier[LogicalID].system = "http://fhir.ch/ig/ch-epr-fhir/xds-logical-id"
* identifier[LogicalID].value = "123"
* status = #current
* type = $sct#721912009 "Medication summary document (record artifact)"
* category = $sct#422735006 "Summary clinical document (record artifact)"
* subject = Reference(http://example.org/Patient/Patient-Kaenel)
* date = "2020-06-29T11:58:00.000+00:00"
* description = "2-7-MedicationCard"
* securityLabel = $sct#17621005 "Normal (qualifier value)"
* content.attachment.contentType = #text/xml
* content.attachment.language = #de-CH
* content.attachment.url = "http://example.com/xdsretrieve?uniqueId=urn:uuid:413eb0f7-aa72-4405-86a4-7793a23fcc27&repositoryUniqueId=2.999.756.42.1"
* content.attachment.title = "Medikationsplan"
* content.attachment.creation = "2020-06-29T11:58:00+00:00"
* content.format = $formatcode#urn:ihe:pharm:pml:2013 "Pharmacy PML"
* context.facilityType = $sct#264358009 "General practice premises (environment)"
* context.practiceSetting = $sct#394802001 "General medicine (qualifier value)"
* context.sourcePatientInfo = Reference(Kaenel)



Instance: relativeReferenceLogicalReference
InstanceOf: CHMhdDocumentReferenceUnRestrictedComprehensive
Usage: #example
Description: "Example with literal relative reference and logical reference (Post community)"
* extension[0].url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-deletionstatus"
* extension[=].valueCoding = urn:oid:2.16.756.5.30.1.127.3.10.18#urn:e-health-suisse:2019:deletionStatus:deletionNotRequested
* extension[+].url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-author-authorrole"
* extension[=].valueCoding = urn:oid:2.16.756.5.30.1.127.3.10.6#HCP "Healthcare professional"
* masterIdentifier.system = "urn:ietf:rfc:3986"
* masterIdentifier.value = "urn:oid:1.3.6.1.4.1.12559.11.13.2.1.2951"
* identifier[LogicalID].system = "http://fhir.ch/ig/ch-epr-fhir/xds-logical-id"
* identifier[LogicalID].value = "123"
* status = #current
* type = $sct#721912009 "Medication summary document (record artifact)"
* category = $sct#422735006 "Summary clinical document (record artifact)"
* subject = Reference(http://example.org/Patient/Patient-Kaenel)
* date = "2020-06-29T11:58:00.000+00:00"
* description = "2-7-MedicationCard"
* securityLabel = $sct#17621005 "Normal (qualifier value)"
* content.attachment.contentType = #text/xml
* content.attachment.language = #de-CH
* content.attachment.url = "http://example.com/xdsretrieve?uniqueId=urn:uuid:413eb0f7-aa72-4405-86a4-7793a23fcc27&repositoryUniqueId=2.999.756.42.1"
* content.attachment.title = "Medikationsplan"
* content.attachment.creation = "2020-06-29T11:58:00+00:00"
* content.format = $formatcode#urn:ihe:pharm:pml:2013 "Pharmacy PML"
* context.facilityType = $sct#264358009 "General practice premises (environment)"
* context.practiceSetting = $sct#394802001 "General medicine (qualifier value)"
* context.sourcePatientInfo = Reference(Kaenel)
* context.sourcePatientInfo.identifier.system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* context.sourcePatientInfo.identifier.value = "761337614042587767"



Instance: absoluteReferenceLogicalReference
InstanceOf: CHMhdDocumentReferenceUnRestrictedComprehensive
Usage: #example
Description: "Example with literal absolute reference and logical reference (Non-Post community)"
* extension[0].url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-deletionstatus"
* extension[=].valueCoding = urn:oid:2.16.756.5.30.1.127.3.10.18#urn:e-health-suisse:2019:deletionStatus:deletionNotRequested
* extension[+].url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-author-authorrole"
* extension[=].valueCoding = urn:oid:2.16.756.5.30.1.127.3.10.6#HCP "Healthcare professional"
* masterIdentifier.system = "urn:ietf:rfc:3986"
* masterIdentifier.value = "urn:oid:1.3.6.1.4.1.12559.11.13.2.1.2951"
* identifier[LogicalID].system = "http://fhir.ch/ig/ch-epr-fhir/xds-logical-id"
* identifier[LogicalID].value = "123"
* status = #current
* type = $sct#721912009 "Medication summary document (record artifact)"
* category = $sct#422735006 "Summary clinical document (record artifact)"
* subject = Reference(http://example.org/Patient/Patient-Kaenel)
* date = "2020-06-29T11:58:00.000+00:00"
* description = "2-7-MedicationCard"
* securityLabel = $sct#17621005 "Normal (qualifier value)"
* content.attachment.contentType = #text/xml
* content.attachment.language = #de-CH
* content.attachment.url = "http://example.com/xdsretrieve?uniqueId=urn:uuid:413eb0f7-aa72-4405-86a4-7793a23fcc27&repositoryUniqueId=2.999.756.42.1"
* content.attachment.title = "Medikationsplan"
* content.attachment.creation = "2020-06-29T11:58:00+00:00"
* content.format = $formatcode#urn:ihe:pharm:pml:2013 "Pharmacy PML"
* context.facilityType = $sct#264358009 "General practice premises (environment)"
* context.practiceSetting = $sct#394802001 "General medicine (qualifier value)"
* context.sourcePatientInfo = Reference(http://example.org/Patient/Patient-Kaenel)
* context.sourcePatientInfo.identifier.system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* context.sourcePatientInfo.identifier.value = "761337614042587767"


Instance: containedReferenceLogicalReference
InstanceOf: CHMhdDocumentReferenceUnRestrictedComprehensive
Usage: #example
Description: "Example with contained reference (Non-Post community)"
* extension[0].url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-deletionstatus"
* extension[=].valueCoding = urn:oid:2.16.756.5.30.1.127.3.10.18#urn:e-health-suisse:2019:deletionStatus:deletionNotRequested
* extension[+].url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-author-authorrole"
* extension[=].valueCoding = urn:oid:2.16.756.5.30.1.127.3.10.6#HCP "Healthcare professional"
* contained = containedPatient
* masterIdentifier.system = "urn:ietf:rfc:3986"
* masterIdentifier.value = "urn:oid:1.3.6.1.4.1.12559.11.13.2.1.2951"
* identifier[LogicalID].system = "http://fhir.ch/ig/ch-epr-fhir/xds-logical-id"
* identifier[LogicalID].value = "123"
* status = #current
* type = $sct#721912009 "Medication summary document (record artifact)"
* category = $sct#422735006 "Summary clinical document (record artifact)"
* subject = Reference(http://example.org/Patient/Patient-Kaenel)
* date = "2020-06-29T11:58:00.000+00:00"
* description = "2-7-MedicationCard"
* securityLabel = $sct#17621005 "Normal (qualifier value)"
* content.attachment.contentType = #text/xml
* content.attachment.language = #de-CH
* content.attachment.url = "http://example.com/xdsretrieve?uniqueId=urn:uuid:413eb0f7-aa72-4405-86a4-7793a23fcc27&repositoryUniqueId=2.999.756.42.1"
* content.attachment.title = "Medikationsplan"
* content.attachment.creation = "2020-06-29T11:58:00+00:00"
* content.format = $formatcode#urn:ihe:pharm:pml:2013 "Pharmacy PML"
* context.facilityType = $sct#264358009 "General practice premises (environment)"
* context.practiceSetting = $sct#394802001 "General medicine (qualifier value)"
* context.sourcePatientInfo = Reference(containedPatient)

Instance: containedPatient
InstanceOf: Patient
Usage: #inline
* identifier.use = #usual
* identifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#MR
* identifier.system = "urn:oid:2.16.756.888888.3.1"
* identifier.value = "8734"

Alias: $formatcode = http://ihe.net/fhir/ihe.formatcode.fhir/CodeSystem/formatcode