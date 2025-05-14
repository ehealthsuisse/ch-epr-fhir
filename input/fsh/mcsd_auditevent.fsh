// Audit events [ITI-90]
Profile:     ChAuditEventIti90Read
Parent:      AuditMcsdCareServicesRead
Title:       "CH Audit Event for [ITI-90] Query Client & Directory / Read"
Description: "This profile is used to define the CH Audit Event for the [ITI-90] transaction and the actors 'Query
Client' & Directory, when reading care service resources."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Query Client' actor (EPR application)"
* agent[server] ^short = "The 'Directory' actor (EPR API)"
* entity[data].what only Reference(IHE.mCSD.Practitioner or IHE.mCSD.PractitionerRole or IHE.mCSD.Organization)
  * type 1..1
  * identifier 0..1
    * ^short = "The identifier of the care service resource, required for a Practitioner or Organization"
    * value 1..1
    * system 1..1


Profile:     ChAuditEventIti90Query
Parent:      AuditMcsdCareServicesQuery
Title:       "CH Audit Event for [ITI-90] Query Client & Directory / Query"
Description: "This profile is used to define the CH Audit Event for the [ITI-90] transaction and the actors 'Query
Client' & Directory, when querying care service resources."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Query Client' actor (EPR application)"
* agent[server] ^short = "The 'Directory' actor (EPR API)"


Instance:   ChAuditEventIti90ReadExample
InstanceOf: ChAuditEventIti90Read
Usage:      #example
* insert ChAuditEventIti90ExampleRules
* insert ChExampleAuditEventBaseRules(server, client)
* insert ChExampleAuditEventClientRules
* subtype[anyRead] = $restfulInteraction#read "read"
* agent[client].network.address = "https://example.com"
* entity[data]
  * what
    * type = "Organization"
    * identifier
      * system = "urn:ietf:rfc:3986"
      * value = "urn:oid:2.16.10.89.203"
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#4 "Domain Resource"


Instance:   ChAuditEventIti90QueryExample
InstanceOf: ChAuditEventIti90Query
Usage:      #example
* insert ChAuditEventIti90ExampleRules
* insert ChExampleAuditEventBaseRules(client, server)
* insert ChExampleAuditEventServerRules
* subtype[anySearch] = $restfulInteraction#search "search"
* agent[server].network.address = "https://example.com"
* entity[query]
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#24 "Query"
  * query = "aHR0cDovL2V4YW1wbGUuY29tL2ZoaXIvUHJhY3RpdGlvbmVyP2ZhbWlseT1Nw7xsbGVy"


RuleSet: ChAuditEventIti90ExampleRules
* insert ChExampleAuditEventHcpRules
* subtype[iti90] = $eventTypeCode#ITI-90 "Find Matching Care Services"


// Audit events [ITI-130]

Profile:      ChAuditEventIti130Create
Parent:       IHE.mCSD.Audit.CareServices.Create
Title:       "CH Audit Event for [ITI-130] Data Source & Directory / Create"
Description: "This profile is used to define the CH Audit Event for the [ITI-130] transaction and the actors 'Data
Source' & Directory, when adding care service resources."
* insert ChAuditEventIti130Rules


Profile:     ChAuditEventIti130Update
Parent:      IHE.mCSD.Audit.CareServices.Update
Title:       "CH Audit Event for [ITI-130] Data Source & Directory / Update"
Description: "This profile is used to define the CH Audit Event for the [ITI-130] transaction and the actors 'Data
Source' & Directory, when updating care service resources."
* insert ChAuditEventIti130Rules


Profile:      ChAuditEventIti130Delete
Parent:       IHE.mCSD.Audit.CareServices.Delete
Title:       "CH Audit Event for [ITI-130] Data Source & Directory / Delete"
Description: "This profile is used to define the CH Audit Event for the [ITI-130] transaction and the actors 'Data
Source' & Directory, when deleting care service resources."
* insert ChAuditEventIti130Rules


RuleSet: ChAuditEventIti130Rules
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Data Source' actor (EPR application)"
* agent[server] ^short = "The 'Directory' actor (EPR API)"
* entity[data].what only Reference(IHE.mCSD.Practitioner or IHE.mCSD.PractitionerRole or IHE.mCSD.Organization)


Instance:   ChAuditEventIti130CreateExample
InstanceOf: ChAuditEventIti130Create
Usage:      #example
* insert ChAuditEventIti130ExampleRules
* insert ChExampleAuditEventClientRules
* subtype[anyCreate] = $restfulInteraction#create "create"
* agent[client].type = DCM#110153 "Source Role ID"
* agent[server].network.address = "https://example.com"
* agent[server].type = DCM#110152 "Destination Role ID"
* entity[data].what.reference = "PractitionerRole/PeterPanSpitalXDept3"


Instance:   ChAuditEventIti130UpdateExample
InstanceOf: ChAuditEventIti130Update
Usage:      #example
* insert ChAuditEventIti130ExampleRules
* insert ChExampleAuditEventServerRules
* subtype[anyUpdate] = $restfulInteraction#update "update"
* agent[server].network.address = "https://example.com"
* entity[data].what.reference = "Practitioner/DrPeterPan"
* agent[client].type = DCM#110153 "Source Role ID"
* agent[server].type = DCM#110152 "Destination Role ID"


Instance:   ChAuditEventIti130DeleteExample
InstanceOf: ChAuditEventIti130Delete
Usage:      #example
* insert ChAuditEventIti130ExampleRules
* insert ChExampleAuditEventServerRules
* subtype[anyDelete] = $restfulInteraction#delete "delete"
* agent[server].network.address = "https://example.com"
* entity[data].what.reference = "Organization/SpitalX"
* agent[client].type = DCM#110150 "Application"
* agent[server].type = $provenanceParticipantType#custodian "Custodian"


RuleSet: ChAuditEventIti130ExampleRules
// Copy of ChExampleAuditEventBaseRules, with agent codes fixed
* recorded = "2024-10-28T09:43:56Z"
* outcome = #0
* agent[client]
  * who.display = "My e-Health App"
  * requestor = false
  * network
    * address = "192.168.1.1"
    * type = #2
* agent[server]
  * who.display = "Community A"
  * requestor = false
  * network
    * type = #5 // The address needs to be define in each example (transaction specific)
* entity[traceparent]
  * what.identifier.value = "00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00"
  * type = $auditEntityType#4 "Other"
  * role = $objectRole#26 "Processing Element"
* entity[data]
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#4 "Domain Resource"
// End of copy of ChExampleAuditEventBaseRules
* insert ChExampleAuditEventHcpRules
* type = $auditEventType#rest "Restful Operation"
