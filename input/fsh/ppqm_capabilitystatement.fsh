// Server Actor
Instance: CH.PPQm.PolicyRepository
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-mhealth/CapabilityStatement/CH.PPQm.PolicyRepository"
* name = "CH_PPQm_Policy_Repository"
* title = "PPQm Policy Repository (server)"
* status = #active
* experimental = false
* date = "2024-03-13"
* description = "CapabilityStatement for Server Actor in the CH.PPQm profile."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #server
* rest.documentation = "CH:PPQm endpoints"
* rest.resource[+].type = #Consent
* rest.resource[=].interaction[+].code = #create                  // PPQ-3
* rest.resource[=].interaction[=].documentation = "PPQ-3 Add Policy Set"
* rest.resource[=].interaction[+].code = #delete                  // PPQ-3
* rest.resource[=].interaction[=].documentation = "PPQ-3 Delete Policy Set"
* rest.resource[=].interaction[+].code = #search-type             // PPQ-5
* rest.resource[=].interaction[=].documentation = "PPQ-5 Retrieve Policy Set"
* rest.resource[=].conditionalCreate = true                       // PPQ-3
* rest.resource[=].conditionalUpdate = true                       // PPQ-3
* rest.resource[=].versioning = #no-version
* rest.resource[=].searchParam[+].name = "patient:identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "PPQm-5 Query by Patient ID"
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "PPQm-5 Query by Policy Set ID"
* rest.resource[=].supportedProfile[+] = "http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/PpqmConsent"
* rest.resource[+].type = #Bundle
* rest.resource[=].supportedProfile[+] = "http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/PpqmFeedRequestBundle"
* rest.resource[=].supportedProfile[+] = "http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/PpqmRetrieveResponseBundle"
* rest.interaction[+].code = #transaction
* rest.interaction[=].documentation = "Only the PPQ-4 transaction is supported."


// Client Actor
Instance: CH.PPQm.PolicySourceConsumer
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-mhealth/CapabilityStatement/CH.PPQm.PolicySourceConsumer"
* name = "CH_PPQm_Policy_Source_Consumer"
* title = "CH:PPQm Policy Source and Consumer (client)"
* status = #active
* experimental = false
* date = "2024-03-13"
* description = "CapabilityStatement for Client Actor in the CH.PPQm profile."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #client
* rest.documentation = "CH:PPQm endpoints"
* rest.resource[+].type = #Consent
* rest.resource[=].interaction[+].code = #create                  // PPQ-3
* rest.resource[=].interaction[=].documentation = "PPQ-3 Add Policy Set"
* rest.resource[=].interaction[+].code = #delete                  // PPQ-3
* rest.resource[=].interaction[=].documentation = "PPQ-3 Delete Policy Set"
* rest.resource[=].interaction[+].code = #search-type             // PPQ-5
* rest.resource[=].interaction[=].documentation = "PPQ-5 Retrieve Policy Set"
* rest.resource[=].conditionalCreate = true                       // PPQ-3
* rest.resource[=].conditionalUpdate = true                       // PPQ-3
* rest.resource[=].versioning = #no-version
* rest.resource[=].searchParam[+].name = "patient:identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "PPQm-5 Query by Patient ID"
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "PPQm-5 Query by Policy Set ID"
* rest.resource[=].supportedProfile[+] = "http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/PpqmConsent"
* rest.resource[+].type = #Bundle
* rest.resource[=].supportedProfile[+] = "http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/PpqmFeedRequestBundle"
* rest.resource[=].supportedProfile[+] = "http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/PpqmRetrieveResponseBundle"
* rest.interaction[+].code = #transaction
* rest.interaction[=].documentation = "Only the PPQ-4 transaction is supported."
