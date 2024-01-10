Instance: CH.PDQm.Consumer
InstanceOf: CapabilityStatement
Title: "CH PDQm Consumer requirements CapabilityStatement"
Description: """
The PDQm Patient Demographics Consumer Actor requirements CapabilityStatement expresses the requirements that can be utilized while being compliant.

- Query against the FHIR endpoint to the Patient Resource endpoint
- Using FHIR R4
- may request json or xml encoding
- [Search Parameters that may be used](https://profiles.ihe.net/ITI/PDQm/ITI-78.html#23784121-query-search-parameters)
  - _id
  - active
  - family
  - given
  - identifier
  - telecom
  - birthdate
  - address
  - gender
- TLS SHALL be used together with IUA basic access token
"""
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-mhealth/CapabilityStatement/CH.PDQm.Consumer"
* name = "CH_PDQm_Consumer"
* title = "PDQm Consumer (client)"
* status = #active
* experimental = false
* date = "2023-04-25"
* description = "CapabilityStatement for Client Actor in the IHE IT Infrastructure Technical Framework Supplement IHE PDQm."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #client
* rest.documentation = "PDQm client will query for Patient resources matching a sub-set of the FHIR core Patient resource query parameters"
* rest.security.description = "TLS SHALL be used together with IUA basic access token"
* rest.resource.type = #Patient
* rest.resource.supportedProfile = "http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/ch-pdqm-patient"
* rest.resource.interaction[0].code = #read
* rest.resource.interaction[+].code = #search-type
* rest.resource.searchParam[0].name = "_id"
* rest.resource.searchParam[=].type = #token
* rest.resource.searchParam[=].documentation = "Logical id of this artifact"
* rest.resource.searchParam[+].name = "active"
* rest.resource.searchParam[=].type = #token
* rest.resource.searchParam[=].documentation = "Whether the patient record is active"
* rest.resource.searchParam[+].name = "address-city"
* rest.resource.searchParam[=].type = #string
* rest.resource.searchParam[=].documentation = "A city specified in an address"
* rest.resource.searchParam[+].name = "address-country"
* rest.resource.searchParam[=].type = #string
* rest.resource.searchParam[=].documentation = "A country specified in an address"
* rest.resource.searchParam[+].name = "address-postalcode"
* rest.resource.searchParam[=].type = #string
* rest.resource.searchParam[=].documentation = "A postalCode specified in an address"
* rest.resource.searchParam[+].name = "address-state"
* rest.resource.searchParam[=].type = #string
* rest.resource.searchParam[=].documentation = "A state specified in an address"
* rest.resource.searchParam[+].name = "birthdate"
* rest.resource.searchParam[=].type = #date
* rest.resource.searchParam[=].documentation = "The patient's date of birth"
* rest.resource.searchParam[+].name = "family"
* rest.resource.searchParam[=].type = #string
* rest.resource.searchParam[=].documentation = "A portion of the family name of the patient"
* rest.resource.searchParam[+].name = "gender"
* rest.resource.searchParam[=].type = #token
* rest.resource.searchParam[=].documentation = "Gender of the patient"
* rest.resource.searchParam[+].name = "given"
* rest.resource.searchParam[=].type = #string
* rest.resource.searchParam[=].documentation = "A portion of the given name of the patient"
* rest.resource.searchParam[+].name = "identifier"
* rest.resource.searchParam[=].type = #token
* rest.resource.searchParam[=].documentation = "A patient identifier"
* rest.resource.searchParam[+].name = "telecom"
* rest.resource.searchParam[=].type = #token
* rest.resource.searchParam[=].documentation = "The value in any kind of telecom details of the patient"
* rest.resource.searchParam[+].name = "_lastUpdated"
* rest.resource.searchParam[=].type = #date
* rest.resource.searchParam[=].documentation = "When the resource version last changed"
* rest.interaction.code = #search-system

Instance: CH.PDQm.Supplier
InstanceOf: CapabilityStatement
Description: """
The PDQm Patient Demographics Supplier Actor requirements CapabilityStatement expresses the requirements that shall be provided.

- Query against the FHIR endpoint to the Patient Resource endpoint
- Using FHIR R4
- shall support both json or xml encoding
- [Search Parameters that shall be supported](https://profiles.ihe.net/ITI/PDQm/ITI-78.html#23784121-query-search-parameters)
  - _id
  - active
  - family
  - given
  - identifier
  - telecom
  - birthdate
  - address
  - gender
- TLS SHALL be used together with IUA basic access token
"""
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-mhealth/CapabilityStatement/CH.PDQm.Supplier"
* name = "CH_PDQm_Supplier"
* title = "PDQm Supplier (server)"
* status = #active
* experimental = false
* date = "2023-04-25"
* description = "CapabilityStatement for Server Actor in the IHE IT Infrastructure Technical Framework Supplement IHE PDQm."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #server
* rest.documentation = "PDQm server provides capability to query for Patient resources matching a sub-set of the FHIR core Patient resource query parameters"
* rest.security.cors = false
* rest.security.description = "None mandated by IHE, encouraged IHE-IUA or SMART-on-FHIR"
* rest.resource.type = #Patient
* rest.resource.supportedProfile = "http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/ch-pdqm-patient"
* rest.resource.interaction[0].code = #read
* rest.resource.interaction[+].code = #search-type
* rest.resource.searchParam[0].name = "_id"
* rest.resource.searchParam[=].type = #token
* rest.resource.searchParam[=].documentation = "Logical id of this artifact"
* rest.resource.searchParam[+].name = "active"
* rest.resource.searchParam[=].type = #token
* rest.resource.searchParam[=].documentation = "Whether the patient record is active"
* rest.resource.searchParam[+].name = "address-city"
* rest.resource.searchParam[=].type = #string
* rest.resource.searchParam[=].documentation = "A city specified in an address"
* rest.resource.searchParam[+].name = "address-country"
* rest.resource.searchParam[=].type = #string
* rest.resource.searchParam[=].documentation = "A country specified in an address"
* rest.resource.searchParam[+].name = "address-postalcode"
* rest.resource.searchParam[=].type = #string
* rest.resource.searchParam[=].documentation = "A postalCode specified in an address"
* rest.resource.searchParam[+].name = "address-state"
* rest.resource.searchParam[=].type = #string
* rest.resource.searchParam[=].documentation = "A state specified in an address"
* rest.resource.searchParam[+].name = "birthdate"
* rest.resource.searchParam[=].type = #date
* rest.resource.searchParam[=].documentation = "The patient's date of birth"
* rest.resource.searchParam[+].name = "family"
* rest.resource.searchParam[=].type = #string
* rest.resource.searchParam[=].documentation = "A portion of the family name of the patient"
* rest.resource.searchParam[+].name = "gender"
* rest.resource.searchParam[=].type = #token
* rest.resource.searchParam[=].documentation = "Gender of the patient"
* rest.resource.searchParam[+].name = "given"
* rest.resource.searchParam[=].type = #string
* rest.resource.searchParam[=].documentation = "A portion of the given name of the patient"
* rest.resource.searchParam[+].name = "identifier"
* rest.resource.searchParam[=].type = #token
* rest.resource.searchParam[=].documentation = "A patient identifier"
* rest.resource.searchParam[+].name = "telecom"
* rest.resource.searchParam[=].type = #token
* rest.resource.searchParam[=].documentation = "The value in any kind of telecom details of the patient"
* rest.resource.searchParam[+].name = "_lastUpdated"
* rest.resource.searchParam[=].type = #date
* rest.resource.searchParam[=].documentation = "When the resource version last changed"
* rest.interaction.code = #search-system
