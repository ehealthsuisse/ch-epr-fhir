Profile: PpqmRetrieveResponseBundle
Parent: Bundle
Id: PpqmRetrieveResponseBundle
Title: "PpqmRetrieveResponseBundle"
Description: "Bundle for Mobile Privacy Policy Retrieve responses"

* type  = http://hl7.org/fhir/bundle-type#searchset
* entry.resource    only PpqmConsent


// #####################################################################################################################
// Instances ###########################################################################################################
// #####################################################################################################################

Instance: PpqmRetrieveResponseBundle
InstanceOf: PpqmRetrieveResponseBundle
Title: "PPQm Retrieve Response Bundle"
Description: "PPQm Retrieve Response Bundle"
Usage: #example
* type = http://hl7.org/fhir/bundle-type#searchset
* total = 3
* link.relation = "self"
* link.url = "https://fhir.ch/ppqm/Consent?patient:identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|123456789012345678"
* entry[+].resource     = Template201Consent
* entry[=].fullUrl      = "https://fhir.ch/ppqm/Consent/201"
* entry[=].search.mode  = #match
* entry[=].search.score = 1
* entry[+].resource     = Template202Consent
* entry[=].fullUrl      = "https://fhir.ch/ppqm/Consent/202"
* entry[=].search.mode  = #match
* entry[=].search.score = 1
* entry[+].resource     = Template203Consent
* entry[=].fullUrl      = "https://fhir.ch/ppqm/Consent/203"
* entry[=].search.mode  = #match
* entry[=].search.score = 1
