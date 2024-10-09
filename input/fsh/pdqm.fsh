Profile: CHPDQmProviderOrganization
Parent: Organization
Id: ch-pdqm-provider-organization
Title: "CH PDQm Provider Organization"
Description: "Organization"
* obeys ch-epr-fhir-org-1
* . ^short = "CH PDQm Provider Organization"
* identifier 1.. MS
* identifier ^short = "The value shall be expressed as an ISO OID"

Invariant: ch-epr-fhir-org-1
Description: "The organization SHALL have at least one of telecom, address, or contact person to be present."
* severity = #error
* expression = "(telecom.count() + address.count() + contact.name.count()) > 0"

Profile: CHPDQmPatient
Parent: $ch-core-patient
Id: ch-pdqm-patient
Title: "CH PDQm Patient"
Description: "The patient demographics and identifier information which can be provided in the PDQm response according to the EPR. If the patient is already registered in a community, the MPI-PID SHALL be provided as an identifier. The EPR-SPID as an identifier MAY be added. The birthname can be added with the  ISO 21090 qualifier extension."
* extension[PatReligion] 0..0
* identifier MS
* identifier[EPR-SPID] 1..1 MS
* identifier[LocalPid] 0..* MS
* name MS
* name ^slicing.discriminator.type = #profile
* name ^slicing.discriminator.path = "$this"
* name ^slicing.rules = #open
* name contains
    HumanName 1..* MS and
    BirthName 0..1 MS
* name[HumanName] only $ch-epr-fhir-humanname
* name[HumanName] ^short = "A name associated with the patient"
* name[BirthName] only $ch-epr-fhir-birthname
* name[BirthName] ^short = "The birthname of the patient"
* name[BirthName] ^comment = "The birthname is added  with the ISO 21090 qualifier https://www.hl7.org/fhir/extension-iso21090-en-qualifier.html BR"
* contact 0..0
* managingOrganization only Reference(CHPDQmProviderOrganization)
* managingOrganization MS
* managingOrganization ^short = "Provider organization of the patient"

CodeSystem: ChEhealthCodesystemPqdMoreAttriburesRequested
Id: 2.16.756.5.30.1.127.3.10.17
Title: "CH Codesystem PDQ More Attributes Requested"
Description: "Codes for indicating which additional attributes are requested to lower the results number."
* ^url = "urn:oid:2.16.756.5.30.1.127.3.10.17"
* ^status = #active
* ^experimental = false
* ^publisher = "eHealth Suisse"
* ^contact.name = "eHealth Suisse"
* ^contact.telecom.system = #url
* ^contact.telecom.value = "https://www.e-health-suisse.ch/"
* ^jurisdiction = urn:iso:std:iso:3166#CH
* ^copyright = "CC0-1.0"
* ^caseSensitive = true
* ^content = #complete
* #BirthNameRequested "BirthNameRequested"

CodeSystem: IheXcpdMoreAttriburesRequested
Id: 1.3.6.1.4.1.19376.1.2.27.1
Title: "IHE XCPD Codesystem more attributes requested"
Description: "Codes for indicating which additional attributes are requested to lower the results number."
* ^url = "urn:oid:1.3.6.1.4.1.19376.1.2.27.1"
* ^status = #active
* ^experimental = false
* ^publisher = "IHE International"
* ^contact.name = "IHE IT Infrastructure Technical Committee"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "iti@ihe.net"
* ^jurisdiction = $m49.htm#001
* ^copyright = "CC0-1.0"
* ^caseSensitive = true
* ^content = #complete
* #LivingSubjectAdministrativeGenderRequested "LivingSubjectAdministrativeGenderRequested"
* #PatientAddressRequested "PatientAddressRequested"
* #LivingSubjectBirthPlaceNameRequested "LivingSubjectBirthPlaceNameRequested"

ValueSet: ChPdqmMoreAttriburesRequested
Id: ChPdqmMoreAttriburesRequested
Title: "CH PDQm ValueSet More Attributes Requested"
Description: "Coded Values for indicating which additional attributes are requested to lower the results number."
* ^status = #active
* ^experimental = false
* IheXcpdMoreAttriburesRequested#LivingSubjectAdministrativeGenderRequested
* IheXcpdMoreAttriburesRequested#PatientAddressRequested 
* IheXcpdMoreAttriburesRequested#LivingSubjectBirthPlaceNameRequested
* ChEhealthCodesystemPqdMoreAttriburesRequested#BirthNameRequested

Profile: ChPdqmResponseMoreAttributesRequested
Parent: OperationOutcome
Id: ch-pdqm-moreattributesrequested
Title: "CH PDQm OperationOutcome More Attributes Requested"   // need to be put it ig.xml
Description: "A profile on the OperationOutcome for indicating which additional attributes are requested to lower the results number."   // need to be put it ig.xml
* issue.severity = #warning 
* issue.code = #incomplete
* issue.details from ChPdqmMoreAttriburesRequested (required)

Instance: PDQmResponseMoreAttributesRequested
InstanceOf: ch-pdqm-moreattributesrequested
Title: "PDQm OperationOutcome More Attributes Requested Example"
Description: "An example on the OperationOutcome for indicating which additional attributes are requested to lower the results number."
Usage: #example
* issue[0].severity = #warning
* issue[=].code = #incomplete
* issue[=].details.coding[0] = urn:oid:1.3.6.1.4.1.19376.1.2.27.1#LivingSubjectAdministrativeGenderRequested "LivingSubjectAdministrativeGenderRequested"
* issue[+].severity = #warning
* issue[=].code = #incomplete
* issue[=].details.coding[0] = urn:oid:1.3.6.1.4.1.19376.1.2.27.1#LivingSubjectBirthPlaceNameRequested "LivingSubjectBirthPlaceNameRequested"
* issue[+].severity = #warning
* issue[=].code = #incomplete
* issue[=].details.coding[0] = 2.16.756.5.30.1.127.3.10.17#BirthNameRequested "BirthNameRequested"

Profile:        ChPDQmQueryPatientResourceResponseMessage
Parent:         Bundle
Id:             ch-pdqm-querypatientresourceresponsemessage
Title:          "CH PDQm Query Patient Resource Response message"
Description:    "A profile on the Query Patient Resource Response message for ITI-78"
* type = #searchset (exactly)
* total 1..
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open
* entry.fullUrl 1..
* entry contains Patient 0..* and OperationOutcome 0..1
* entry[Patient] ^short = "Patient"
* entry[Patient].resource 1..
* entry[Patient].resource only ch-pdqm-patient
* entry[OperationOutcome] ^short = "OperationOutcome"
* entry[OperationOutcome].resource 1..
// * entry[OperationOutcome].resource ^type.code = "OperationOutcome"
// * entry[OperationOutcome].resource ^type.profile = Canonical(OperationOutcome)
* entry[OperationOutcome].resource only ch-pdqm-moreattributesrequested

Instance: FranzMuster
InstanceOf: Patient
Usage: #inline
* identifier[0].system = "urn:oid:2.999.5.6.7"
* identifier[=].value = "value of MPI-PID"
* identifier[+].type = $v2-0203#MR
* identifier[=].system = "urn:oid:2.16.756.888888.3.1"
* identifier[=].value = "8734"
* identifier[+].system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* identifier[=].value = "761337610411353650"
* name.family = "Muster"
* name.given = "Franz"
* gender = #male
* birthDate = "1995-01-27"
* managingOrganization.identifier.system = "urn:oid:2.51.1.3"
* managingOrganization.identifier.value = "7601000201041"

Instance: PDQm-QueryResponse
InstanceOf: ChPDQmQueryPatientResourceResponseMessage
Title: "PDQm Query response message"               // need to be put it ig.xml
Description: "CH PDQm Query response message example result for Franz Muster, 27.1.1995"           // need to be put it ig.xml
Usage: #example
* type = #searchset
* total = 1
* link.relation = "self"
* link.url = "http://example.com/fhir/Patient?family=Muster&birthdate=1995-01-27"
* entry.fullUrl = "http://example.com/fhir/Patient/FranzMuster"
* entry.resource = FranzMuster
* entry.search.mode = #match

Instance: PDQm-QueryResponseTooManyResults
InstanceOf: ChPDQmQueryPatientResourceResponseMessage
Title: "PDQm Query response message too many results"    // need to be put it ig.xml
Description: "CH PDQm Query response message with too many results indication" // need to be put it ig.xml
Usage: #example
* type = #searchset
* total = 0
* link.relation = "self"
* link.url = "http://example.com/fhir/Patient?family=M"
* entry.fullUrl = "urn:uuid:13c56fd3-f2f1-4174-ae56-c91f027ffddf"
* entry.resource = PDQmResponseMoreAttributesRequested
* entry.search.mode = #outcome