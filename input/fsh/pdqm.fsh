CodeSystem: ChEhealthCodesystemPqdMoreAttriburesRequested
Id: 2.16.756.5.30.1.127.3.10.17
Title: "ch-ehealth-codesystem-pdq-more-attributes-requested"
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
Title: "ihe-xcpd-codesystem-more-attributes-requested"
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

Instance: ChPdqmMoreAttriburesRequested
InstanceOf: ValueSet
* url = "http://fhir.ch/ig/ch-epr-mhealth/ValueSet/ChPdqmMoreAttriburesRequested"
* identifier.use = #official
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:oid:2.16.756.5.30.1.127.3.10.16.1"
* name = "ChPqmdMoreAttriburesRequested"
* title = "CHPqdmMoreAttriburesRequested"
* status = #active
* experimental = false
* publisher = "eHealth Suisse"
* contact.name = "eHealth Suisse"
* contact.telecom.system = #url
* contact.telecom.value = "https://www.e-health-suisse.ch/"
* description = "As per Annex 5."
* jurisdiction = urn:iso:std:iso:3166#CH
* copyright = "CC0-1.0"
* compose.include[0].system = "urn:oid:1.3.6.1.4.1.19376.1.2.27.1"
* compose.include[=].concept[0].code = #LivingSubjectAdministrativeGenderRequested
* compose.include[=].concept[+].code = #PatientAddressRequested
* compose.include[=].concept[+].code = #LivingSubjectBirthPlaceNameRequested
* compose.include[+].system = "urn:oid:2.16.756.5.30.1.127.3.10.17"
* compose.include[=].concept[0].code = #BirthNameRequested

Profile: ChPdqmResponseMoreAttributesRequested
Parent: OperationOutcome
Id: CH.PDQm.ResponseMoreAttributesRequested
Title: "ChPdqmResponseMoreAttributesRequested"
Description: "ChPdqmResponseMoreAttributesRequested"
* issue.severity = #warning 
* issue.code = #incomplete
* issue.details from http://fhir.ch/ig/ch-epr-mhealth/ValueSet/ChPdqmMoreAttriburesRequested (required)

Instance: PDQmResponseMoreAttributesRequestedExample
InstanceOf: ChPdqmResponseMoreAttributesRequested
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
