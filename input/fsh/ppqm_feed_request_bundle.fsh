Profile: PpqmFeedRequestBundle
Parent: Bundle
Id: PpqmFeedRequestBundle
Title: "CH PPQm Feed Request Bundle"
Description: "Bundle for Mobile Privacy Policy Bundle Feed requests"

* obeys ch-epr-ppqm-method-equality


* type  = http://hl7.org/fhir/bundle-type#transaction

* entry             1..*
* entry             obeys ch-epr-ppqm-constistent-ids
* entry.resource    only PpqmConsent

* entry.request                 obeys ch-epr-ppqm-url-format
* entry.request.method          from PpqmFeedRequestHttpMethod (required)
* entry.request.ifNoneMatch     0..0
* entry.request.ifModifiedSince 0..0
* entry.request.ifMatch         0..0
* entry.request.ifNoneExist     0..0



Invariant:      ch-epr-ppqm-method-equality
Description:    "HTTP methods of all request shall be the same"
Expression:     "entry.request.method.distinct().count() = 1"
Severity:       #error

Invariant:      ch-epr-ppqm-url-format
Description:    "URL format shall suit the HTTP method"
Expression:     "(
                    (method = 'POST') and (url = 'Consent')
                ) or (
                    (method != 'POST') and url.startsWith('Consent?identifier=') and url.lower().matches('^consent\\\\?identifier=urn:uuid:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$')
                )"
Severity:       #error

Invariant:      ch-epr-ppqm-constistent-ids
Description:    "For PUT, policy set ID in the embedded resource shall be the same as in the entry URL"
Expression:     "(request.method != 'PUT') or (resource.identifier.where(
                    type.coding.exists((system = 'http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType') and (code = 'policySetId'))
                ).value.lower() = request.url.substring(19).lower())"       // 19 is the length of "Consent?identifier="
Severity:       #error


Instance: PpqmFeedRequestBundleAdd
InstanceOf: PpqmFeedRequestBundle
Title: "PPQm Feed Request Bundle (POST)"
Description: "CH:PPQm Feed Request Bundle for HTTP method POST -- add new policy sets"
Usage: #example
* type = http://hl7.org/fhir/bundle-type#transaction
* entry[+].request.method = #POST
* entry[=].request.url = "Consent"
* entry[=].resource = Template201Consent
* entry[+].request.method = #POST
* entry[=].request.url = "Consent"
* entry[=].resource = Template202Consent
* entry[+].request.method = #POST
* entry[=].request.url = "Consent"
* entry[=].resource = Template203Consent

Instance: PpqmFeedRequestBundleUpdate
InstanceOf: PpqmFeedRequestBundle
Title: "PPQm Feed Request Bundle (PUT)"
Description: "CH:PPQm Feed Request Bundle for HTTP method PUT -- conditionally update policy sets"
Usage: #example
* type = http://hl7.org/fhir/bundle-type#transaction
* entry[+].request.method = #PUT
* entry[=].request.url = "Consent?identifier=urn:uuid:f1e1ed8e-0582-4e47-a76e-5e8f6cc0908f"
* entry[=].resource = Template301Consent
* entry[+].request.method = #PUT
* entry[=].request.url = "Consent?identifier=urn:uuid:c23c862a-b297-43c7-875b-d933982c9756"
* entry[=].resource = Template302Consent
* entry[+].request.method = #PUT
* entry[=].request.url = "Consent?identifier=urn:uuid:f663289d-4cc4-41d7-a01d-213e18e1f722"
* entry[=].resource = Template303Consent

Instance: PpqmFeedRequestBundleDelete
InstanceOf: PpqmFeedRequestBundle
Title: "PPQm Feed Request Bundle (DELETE)"
Description: "CH:PPQm Feed Request Bundle for HTTP method DELETE -- delete policy sets"
Usage: #example
* type = http://hl7.org/fhir/bundle-type#transaction
* entry[+].request.method = #DELETE
* entry[=].request.url = "Consent?identifier=urn:uuid:f1e1ed8e-0582-4e47-a76e-5e8f6cc0908f"
* entry[+].request.method = #DELETE
* entry[=].request.url = "Consent?identifier=urn:uuid:c23c862a-b297-43c7-875b-d933982c9756"
* entry[+].request.method = #DELETE
* entry[=].request.url = "Consent?identifier=urn:uuid:f663289d-4cc4-41d7-a01d-213e18e1f722"

Instance: PpqmFeedResponseBundle
InstanceOf: Bundle
Title: "PPQm Feed Response Bundle"
Description: "CH:PPQm Feed Response Bundle"
Usage: #example
* id = "6de90529-3baa-4157-9bef-e945363b2c39"
* type = http://hl7.org/fhir/bundle-type#transaction-response
* link[+].relation = "self"
* link[=].url = "http://localhost:8999/fhir"
* entry[+].fullUrl = "http://localhost:8999/fhir/Consent/a0336005-dfb6-4b57-a904-d9172d112535"
* entry[=].response.status = "201 Created"
* entry[+].fullUrl = "http://localhost:8999/fhir/Consent/d0e1c5b1-fbc9-48e1-a677-75ea2ef69fae"
* entry[=].response.status = "201 Created"
* entry[+].fullUrl = "http://localhost:8999/fhir/Consent/05460feb-62bb-49eb-aa16-fbe3baa2785a"
* entry[=].response.status = "201 Created"
