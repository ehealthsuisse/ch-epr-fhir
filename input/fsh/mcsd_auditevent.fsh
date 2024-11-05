// Audit events [ITI-90]
Profile:     ChAuditEventIti90Read
Parent:      AuditMcsdCareServicesRead
Title:       "CH Audit Event for [ITI-90] Care Services Selective Consumer & Supplier / Read"
Description: "This profile is used to define the CH Audit Event for the [ITI-90] transaction and the actors 'Care
Services Selective Consumer' & Supplier, when reading care service resources."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Care Services Selective Consumer' actor (EPR application)"
* agent[server] ^short = "The 'Care Services Selective Supplier' actor (EPR API)"
* entity[data].what only Reference(IHE.mCSD.Practitioner or IHE.mCSD.PractitionerRole or IHE.mCSD.Organization)
  * type 1..1
  * identifier 0..1
    * ^short = "The identifier of the care service resource, required for a Practitioner or Organization"
    * value 1..1
    * system 1..1


Profile:     ChAuditEventIti90Query
Parent:      AuditMcsdCareServicesQuery
Title:       "CH Audit Event for [ITI-90] Care Services Selective Consumer & Supplier / Query"
Description: "This profile is used to define the CH Audit Event for the [ITI-90] transaction and the actors 'Care
Services Selective Consumer' & Supplier, when querying care service resources."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Care Services Selective Consumer' actor (EPR application)"
* agent[server] ^short = "The 'Care Services Selective Supplier' actor (EPR API)"


Instance:   ChAuditEventIti90ReadExample
InstanceOf: ChAuditEventIti90Read
Usage:      #example
* insert ChAuditEventIti90ExampleRules
* insert ChExampleAuditEventBaseRules(server, client)
* insert ChExampleAuditEventClientRules
* subtype[anyRead] = $restfulInteraction#read "read"
* agent[client].network.address = "https://example.org/fhir/"
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
* agent[server].network.address = "https://example.org/fhir/"
* entity[query]
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#24 "Query"
  * query = "aHR0cDovL2V4YW1wbGUuY29tL2ZoaXIvUHJhY3RpdGlvbmVyP2ZhbWlseT1Nw7xsbGVy"


RuleSet: ChAuditEventIti90ExampleRules
* insert ChExampleAuditEventHcpRules
* subtype[iti90] = $eventTypeCode#ITI-90 "Find Matching Care Services"


// Audit events [CH:mCSD-1]

Profile:      ChAuditEventmCSD1Create
Parent:       Create // https://profiles.ihe.net/ITI/BALP/1.1.3/StructureDefinition-IHE.BasicAudit.Create.html
Title:       "CH Audit Event for [CH:mCSD-1] Care Services Source & Directory / Add"
Description: "This profile is used to define the CH Audit Event for the [CH:mCSD-1] transaction and the actors 'Care
Services Source' & Directory, when adding care service resources."
* insert ChAuditEventmCSD1Rules


Profile:     ChAuditEventmCSD1Update
Parent:      Update // https://profiles.ihe.net/ITI/BALP/1.1.3/StructureDefinition-IHE.BasicAudit.Update.html
Title:       "CH Audit Event for [CH:mCSD-1] Care Services Source & Directory / Update"
Description: "This profile is used to define the CH Audit Event for the [CH:mCSD-1] transaction and the actors 'Care
Services Source' & Directory, when updating care service resources."
* insert ChAuditEventmCSD1Rules


Profile:      ChAuditEventmCSD1Delete
Parent:       Delete // https://profiles.ihe.net/ITI/BALP/1.1.3/StructureDefinition-IHE.BasicAudit.Delete.html
Title:       "CH Audit Event for [CH:mCSD-1] Care Services Source & Directory / Delete"
Description: "This profile is used to define the CH Audit Event for the [CH:mCSD-1] transaction and the actors 'Care
Services Source' & Directory, when deleting care service resources."
* insert ChAuditEventmCSD1Rules


RuleSet: ChAuditEventmCSD1Rules
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Care Services Source' actor (EPR application)"
* agent[server] ^short = "The 'Care Services Directory' actor (EPR API)"
* entity contains practitioner 0..1 and organization 0..1
* entity[data].what
  * type 1..1
  * identifier 0..1
    * ^short = "The identifier of the care service resource, required for a Practitioner or Organization"
    * value 1..1
    * system 1..1
* entity[practitioner] ^short = "The Practitioner referenced in the created/updated/deleted PractitionerRole"
  * what 1..1
  * what ^short = "The practitioner identifier"
    * identifier 1..1
      * value 1..1
      * system 1..1
  * type = $auditEntityType#1 "Person"
  * role = $objectRole#15 "Practitioner"
* entity[organization] ^short = "The Organization referenced in the created/updated/deleted PractitionerRole"
  * what 1..1
  * what ^short = "The organization identifier"
    * identifier 1..1
      * value 1..1
      * system 1..1
  * type = $auditEntityType#3 "Organization"
  * role = $objectRole#15 "Practitioner"


Instance:   ChAuditEventmCSD1CreateExample
InstanceOf: ChAuditEventmCSD1Create
Usage:      #example
* insert ChAuditEventmCSD1ExampleRules
* insert ChExampleAuditEventClientRules
* subtype[anyCreate] = $restfulInteraction#create "create"
* agent[client].type = DCM#110153 "Source Role ID"
* agent[server].network.address = "https://example.org/fhir/"
* agent[server].type = DCM#110152 "Destination Role ID"
* entity[data].what
  * type = "PractitionerRole"
  * identifier
    * value = "CN=CommunityA:00000001001,OU=Relationship,DC=HPD,O=BAG,C=ch"
    * system = "urn:ietf:rfc:4514"
* entity[practitioner].what.identifier
  * value = "7601000102737"
  * system = "urn:oid:2.51.1.3"
* entity[organization].what.identifier
  * value = "urn:oid:2.16.10.89.210"
  * system = "urn:ietf:rfc:3986"


Instance:   ChAuditEventmCSD1UpdateExample
InstanceOf: ChAuditEventmCSD1Update
Usage:      #example
* insert ChAuditEventmCSD1ExampleRules
* insert ChExampleAuditEventServerRules
* subtype[anyUpdate] = $restfulInteraction#update "update"
* agent[server].network.address = "https://example.org/fhir/"
* entity[data].what
  * type = "Practitioner"
  * identifier
    * value = "7601000102737"
    * system = "urn:oid:2.51.1.3"
* agent[client].type = DCM#110153 "Source Role ID"
* agent[server].type = DCM#110152 "Destination Role ID"


Instance:   ChAuditEventmCSD1DeleteExample
InstanceOf: ChAuditEventmCSD1Delete
Usage:      #example
* insert ChAuditEventmCSD1ExampleRules
* insert ChExampleAuditEventServerRules
* subtype[anyDelete] = $restfulInteraction#delete "delete"
* agent[server].network.address = "https://example.org/fhir/"
* entity[data].what
  * type = "Organization"
  * identifier
    * system = "urn:ietf:rfc:3986"
    * value = "urn:oid:2.16.10.89.203"
* agent[client].type = DCM#110150 "Application"
* agent[server].type = $provenanceParticipantType#custodian "Custodian"


RuleSet: ChAuditEventmCSD1ExampleRules
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
