// https://github.com/IHE/ITI.PDQm/blob/main/input/fsh/capability.fsh
Instance: CH.PDQm.Consumer
InstanceOf: CapabilityStatement
Title: "CH PDQm Consumer requirements CapabilityStatement"
Description: """
The PDQm Patient Demographics Consumer Actor requirements CapabilityStatement expresses the requirements that can be utilized while being compliant.

- Query against the FHIR endpoint to the Patient Resource endpoint
- Using FHIR R4
- may request json or xml encoding
- TLS SHALL be used together with IUA basic access token
"""
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-fhir/CapabilityStatement/CH.PDQm.Consumer"
* name = "CH_PDQm_Consumer"
* title = "PDQm Consumer (client)"
* status = #active
* experimental = false
* date = "2024-10-15"
* description = "CapabilityStatement for Client Actor in the IHE IT Infrastructure Technical Framework Supplement IHE PDQm."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #client
* rest.documentation = "PDQm client will query for Patient resources matching a FHIR Patient resource"
* rest.security.description = "TLS SHALL be used together with IUA basic access token"
* rest.resource.type = #Patient
* rest.resource.supportedProfile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-pdqm-patient"
* rest.resource.operation[+].name = "match"
* rest.resource.operation[=].definition = Canonical(CHPDQmMatch)
* rest.resource.operation[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource.operation[=].extension[=].valueCode = #SHALL
* rest.resource.operation[=].documentation = """Implementation SHALL conform to [ITI-119](iti-119.html)"""
* rest.interaction.code = #search-system

// https://github.com/IHE/ITI.PDQm/blob/main/input/fsh/capability.fsh
Instance: CH.PDQm.Supplier
InstanceOf: CapabilityStatement
Description: """
The PDQm Patient Demographics Supplier Actor requirements CapabilityStatement expresses the requirements that shall be provided.

- Query against the FHIR endpoint to the Patient Resource endpoint
- Using FHIR R4
- shall support both json or xml encoding
- TLS SHALL be used together with IUA basic access token
- SHALL support the PDQm $match operation
- SHALL return Patient Resources conforming to the PDQm Patient Profile
"""
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-fhir/CapabilityStatement/CH.PDQm.Supplier"
* name = "CH_PDQm_Supplier"
* title = "PDQm Supplier (server)"
* status = #active
* experimental = false
* date = "2024-10-15"
* description = "CapabilityStatement for Server Actor in the IHE IT Infrastructure Technical Framework Supplement IHE PDQm."
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #server
* rest.documentation = "PDQm server provides capability to query for Patient resources matching a FHIR Patient resource"
* rest.security.cors = false
* rest.security.description = "TLS SHALL be used together with IUA basic access token"
* rest.resource.type = #Patient
* rest.resource.supportedProfile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-pdqm-patient"
* rest.resource.operation[+].name = "match"
* rest.resource.operation[=].definition = Canonical(CHPDQmMatch)
* rest.resource.operation[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource.operation[=].extension[=].valueCode = #SHALL
* rest.resource.operation[=].documentation = """Implementation SHALL conform to [ITI-119](iti-119.html)"""
* rest.interaction.code = #search-system