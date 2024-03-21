// Server Actor
Instance: CH.PPQm.PolicyRepository
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-fhir/CapabilityStatement/CH.PPQm.PolicyRepository"
* name = "CH_PPQm_Policy_Repository"
* title = "PPQm Policy Repository (server)"
* status = #active
* experimental = false
* date = "2024-03-19"
* description = "CapabilityStatement for the Policy Repository actor in the CH:PPQm profile (server)."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #server
* rest.documentation = "CH:PPQm endpoints"
* rest.resource[+].type = #Consent
* rest.resource[=].interaction[+].code = #create                  // PPQ-3 POST
* rest.resource[=].interaction[=].documentation = "PPQ-3 POST — Add Policy Set"
* rest.resource[=].interaction[+].code = #search-type             // PPQ-5
* rest.resource[=].interaction[=].documentation = "PPQ-5 — Retrieve Policy Set"
* rest.resource[=].conditionalUpdate = true                       // PPQ-3 PUT
* rest.resource[=].conditionalDelete = #single                    // PPQ-3 DELETE
* rest.resource[=].versioning = #no-version
* rest.resource[=].searchParam[+].name = "patient:identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "PPQ-5 — Query by Patient ID"
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "PPQ-5 — Query by Policy Set ID"
* rest.resource[=].supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/PpqmConsent"
* rest.resource[+].type = #Bundle
* rest.resource[=].supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/PpqmFeedRequestBundle"
* rest.resource[=].supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/PpqmRetrieveResponseBundle"
* rest.interaction[+].code = #transaction
* rest.interaction[=].documentation = "Only the PPQ-4 transaction is supported."


// Client Actor
Instance: CH.PPQm.PolicySourceConsumer
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-fhir/CapabilityStatement/CH.PPQm.PolicySourceConsumer"
* name = "CH_PPQm_Policy_Source_Consumer"
* title = "PPQm Policy Source and Consumer (client)"
* status = #active
* experimental = false
* date = "2024-03-19"
* description = "CapabilityStatement for the Policy Source and Policy Consumer actors in the CH:PPQm profile (client)."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #client
* rest.documentation = "CH:PPQm endpoints"
* rest.resource[+].type = #Consent
* rest.resource[=].interaction[+].code = #create                  // PPQ-3 POST
* rest.resource[=].interaction[=].documentation = "PPQ-3 POST — Add Policy Set"
* rest.resource[=].interaction[+].code = #search-type             // PPQ-5
* rest.resource[=].interaction[=].documentation = "PPQ-5 — Retrieve Policy Set"
* rest.resource[=].conditionalUpdate = true                       // PPQ-3 PUT
* rest.resource[=].conditionalDelete = #single                    // PPQ-3 DELETE
* rest.resource[=].versioning = #no-version
* rest.resource[=].searchParam[+].name = "patient:identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "PPQ-5 — Query by Patient ID"
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "PPQ-5 — Query by Policy Set ID"
* rest.resource[=].supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/PpqmConsent"
* rest.resource[+].type = #Bundle
* rest.resource[=].supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/PpqmFeedRequestBundle"
* rest.resource[=].supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/PpqmRetrieveResponseBundle"
* rest.interaction[+].code = #transaction
* rest.interaction[=].documentation = "Only the PPQ-4 transaction is supported."