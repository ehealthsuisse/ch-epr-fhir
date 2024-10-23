// PPQ-3
Profile:     ChAuditEventPpq3Create
Parent:      PatientCreate
Title:       "CH Audit Event for [PPQ-3] Create privacy policy"
Description: "This profile is used to define the CH Audit Event for the [PPQ-3] transaction and the actors 'Policy
Source' and 'Policy Repository' when creating a privacy policy."
* insert ChAuditEventPpq3Rules


Profile:     ChAuditEventPpq3Update
Parent:      PatientUpdate
Title:       "CH Audit Event for [PPQ-3] Update privacy policy"
Description: "This profile is used to define the CH Audit Event for the [PPQ-3] transaction and the actors 'Policy
Source' and 'Policy Repository' when updating a privacy policy."
* insert ChAuditEventPpq3Rules
* subtype[anyUpdate] = $restfulInteraction#update "update"


Profile:     ChAuditEventPpq3Delete
Parent:      PatientDelete
Title:       "CH Audit Event for [PPQ-3] Delete privacy policy"
Description: "This profile is used to define the CH Audit Event for the [PPQ-3] transaction and the actors 'Policy
Source' and 'Policy Repository' when deleting a privacy policy."
* insert ChAuditEventPpq3Rules


RuleSet: ChAuditEventPpq3Rules
* insert ChAuditEventExtendedRules
* agent[client] ^short = "The 'Policy Source' actor (EPR application)"
* agent[server] ^short = "The 'Policy Repository' actor (EPR API)"
* subtype contains ppq3 1..1
* subtype[ppq3] = urn:e-health-suisse:event-type-code#PPQ-3 "Mobile Privacy Policy Feed"
* entity[data] ^short = "The privacy policy being created, updated or deleted"
  * what.identifier 1..1
    * value 1..1
    * system 1..1
    * system = "urn:ietf:rfc:3986"
  * role = $objectRole#4 "Domain Resource" // TODO: 13 is not allowed here
* entity[patient] ^short = "The patient whose privacy policies are being managed"


Instance:   ChAuditEventPpq3CreateExample
InstanceOf: ChAuditEventPpq3Create
Usage:      #example
* insert ChAuditEventPpq3ExampleRules
* insert ChExampleAuditEventClientRules
* insert ChExampleAuditEventBaseRules(client, server)
* subtype[anyCreate] = $restfulInteraction#create "create"



Instance:   ChAuditEventPpq3UpdateExample
InstanceOf: ChAuditEventPpq3Update
Usage:      #example
* insert ChAuditEventPpq3ExampleRules
* insert ChExampleAuditEventServerRules
* insert ChExampleAuditEventBaseRules(client, server)
* subtype[anyUpdate] = $restfulInteraction#update "update"


Instance:   ChAuditEventPpq3DeleteExample
InstanceOf: ChAuditEventPpq3Delete
Usage:      #example
* insert ChAuditEventPpq3ExampleRules
* insert ChExampleAuditEventClientRules
* recorded = "2024-10-28T09:43:56Z"
* outcome = #0
* subtype[anyDelete] = $restfulInteraction#delete "delete"
* agent[client]
  * type = DCM#110150 "Application"
  * who.display = "My e-Health App"
  * requestor = false
  * network
    * address = "192.168.1.1"
    * type = #2
* agent[server]
  * type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#custodian "Custodian"
  * who.display = "Community A"
  * requestor = false
  * network.type = #5 // The address needs to be define in each example (transaction specific)
* entity[traceparent]
  * what.identifier.value = "00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00"
  * type = $auditEntityType#4 "Other"
  * role = $objectRole#26 "Processing Element"


RuleSet: ChAuditEventPpq3ExampleRules
* insert ChExampleAuditEventHcpRules
* insert ChExampleAuditEventEntityPatientRules
* type = $auditEventType#rest "Restful Operation"
* subtype[ppq3] = urn:e-health-suisse:event-type-code#PPQ-3 "Mobile Privacy Policy Feed"
* agent[server].network.address = "https://example.org/fhir/"
* entity[data]
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#4 "Domain Resource"
  * what.identifier
    * system = "urn:ietf:rfc:3986"
    * value = "urn:uuid:9a420810-9666-4eab-92ef-3145286de9eb"


// ---------------------------------------------------------------------------------------------------------------------
// PPQ-4
Instance:   ChAuditEventPpq4Example
InstanceOf: Bundle
Usage:      #example
* type = #batch
* entry[+]
  * resource = ChAuditEventPpq3CreateExample
  * request
    * method = #POST
    * url = "http://example.org/fhir/AuditEvent"
* entry[+]
  * resource = ChAuditEventPpq3UpdateExample
  * request
    * method = #POST
    * url = "http://example.org/fhir/AuditEvent"
* entry[+]
  * resource = ChAuditEventPpq3DeleteExample
  * request
    * method = #POST
    * url = "http://example.org/fhir/AuditEvent"


// ---------------------------------------------------------------------------------------------------------------------
// PPQ-5
Profile:     ChAuditEventPpq5Consumer
Parent:      PatientQuery
Title:       "CH Audit Event for [PPQ-5] Policy Consumer"
Description: "This profile is used to define the CH Audit Event for the [PPQ-5] transaction and the actor 'Policy
Consumer'."
* insert ChAuditEventPpq5Rules


Profile:     ChAuditEventPpq5Repository
Parent:      PatientQuery
Title:       "CH Audit Event for [PPQ-5] Policy Repository"
Description: "This profile is used to define the CH Audit Event for the [PPQ-5] transaction and the actor 'Policy
Repository'."
* insert ChAuditEventPpq5Rules


RuleSet: ChAuditEventPpq5Rules
* insert ChAuditEventExtendedRules
* agent[client] ^short = "The 'Policy Consumer' actor (EPR application)"
* agent[server] ^short = "The 'Policy Repository' actor (EPR API)"
* subtype contains ppq5 1..1
* subtype[anySearch] = $restfulInteraction#search "search"
* subtype[ppq5] = urn:e-health-suisse:event-type-code#PPQ-5 "Mobile Privacy Policy Retrieve"
* entity[query] ^short = "The privacy policy query"
// * entity[query].role = $objectRole#13 "Security Resource" TODO: #24 in BALP, #13 in PPQ-2
* entity[patient] ^short = "The patient whose privacy policies are being accessed"


Instance:   ChAuditEventPpq5ConsumerExample
InstanceOf: ChAuditEventPpq5Consumer
Usage:      #example
* insert ChAuditEventPpq5ExampleRules
* insert ChExampleAuditEventServerRules
* insert ChExampleAuditEventBaseRules(client, server)


Instance:   ChAuditEventPpq5RepositoryExample
InstanceOf: ChAuditEventPpq5Repository
Usage:      #example
* insert ChAuditEventPpq5ExampleRules
* insert ChExampleAuditEventServerRules
* insert ChExampleAuditEventBaseRules(client, server)


RuleSet: ChAuditEventPpq5ExampleRules
* insert ChExampleAuditEventHcpRules
* insert ChExampleAuditEventEntityPatientRules
* type = $auditEventType#rest "Restful Operation"
* subtype[ppq5] = urn:e-health-suisse:event-type-code#PPQ-5 "Mobile Privacy Policy Retrieve"
* agent[server].network.address = "https://example.org/fhir/"
* entity[query]
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#24 "Query"
  * query = "aHR0cHM6Ly9leGFtcGxlLm9yZy9maGlyL0NvbnNlbnQ/cGF0aWVudDppZGVudGlmaWVyPXVybjpvaWQ6Mi4xNi43NTYuNS4zMC4xLjEyNy4zLjEwLjN8NzYxMzM3NjEwNDExMzUzNjUw"