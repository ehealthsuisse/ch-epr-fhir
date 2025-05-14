Profile: PpqmRetrieveResponseBundle
Parent: Bundle
Id: PpqmRetrieveResponseBundle
Title: "CH PPQm Retrieve Response Bundle"
Description: "Bundle for Mobile Privacy Policy Retrieve responses"


* type  = http://hl7.org/fhir/bundle-type#searchset

* entry.resource    only PpqmConsent


Instance: PpqmRetrieveResponseBundle
InstanceOf: PpqmRetrieveResponseBundle
Title: "CH PPQm Retrieve Response Bundle"
Description: "PPQm Retrieve Response Bundle"
Usage: #example
* type = http://hl7.org/fhir/bundle-type#searchset
* total = 3
* link.relation = "self"
* link.url = "http://example.com/ppqm/Consent?patient:identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|761337610411353650"
* entry[+].resource     = PpqmConsentTemplate201Example
* entry[=].fullUrl      = "http://example.com/ppqm/Consent/PpqmConsentTemplate201Example"
* entry[=].search.mode  = #match
* entry[=].search.score = 1
* entry[+].resource     = PpqmConsentTemplate202Example
* entry[=].fullUrl      = "http://example.com/ppqm/Consent/PpqmConsentTemplate202Example"
* entry[=].search.mode  = #match
* entry[=].search.score = 1
* entry[+].resource     = PpqmConsentTemplate203Example
* entry[=].fullUrl      = "http://example.com/ppqm/Consent/PpqmConsentTemplate203Example"
* entry[=].search.mode  = #match
* entry[=].search.score = 1
