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
* entry[Patient].resource only ch-pixm-patient
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
Description: "CH PDQm Query response message example result for Franz Muster, 27.1.1955"           // need to be put it ig.xml
Usage: #example
* type = #searchset
* total = 1
* link.relation = "self"
* link.url = "http://example.com/fhir/Patient?birthdate=1995-01-27&name=Muster"
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
* link.url = "http://example.com/fhir/Patient?name=M"
* entry.fullUrl = "urn:uuid:13c56fd3-f2f1-4174-ae56-c91f027ffddf"
* entry.resource = PDQmResponseMoreAttributesRequested
* entry.search.mode = #outcome