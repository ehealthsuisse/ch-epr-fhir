Profile: CHPIXmPatientFeed
Parent: CHPDQmPatient
Id: ch-pixm-patient-feed
Title: "CH PIXm Patient Feed"
Description: "The patient contacts information which can be provided in the PIXm Feed."
* address MS
* telecom MS


// ---------------------------------------------------------------------------------------------------------------------
// Audit events [ITI-104]
Profile:     ChAuditEventIti104Source
Parent:      AuditPixmFeedSourceUpdate
Title:       "CH Audit Event for [ITI-104] Patient Identity Source"
Description: "This profile is used to define the CH Audit Event for the [ITI-104] transaction and the actor 'Patient
Identity Source'."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Patient Identifier Source' actor (EPR application)"
* agent[server] ^short = "The 'Patient Identifier Cross-reference Manager' actor (Health Dossier API)"


Profile:     ChAuditEventIti104ManagerCreate
Parent:      AuditPixmFeedManagerCreate
Title:       "CH Audit Event for [ITI-104] Patient Identifier Cross-reference Manager / Create patient"
Description: "This profile is used to define the CH Audit Event for the [ITI-104] transaction and the actor 'Patient
Identifier Cross-reference Manager' when creating a patient."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Patient Identifier Source' actor (EPR application)"
* agent[server] ^short = "The 'Patient Identifier Cross-reference Manager' actor (Health Dossier API)"
* entity[patient].what.identifier 1..1
  * value 1..1
  * system 1..1


Profile:     ChAuditEventIti104ManagerUpdate
Parent:      AuditPixmFeedManagerUpdate
Title:       "CH Audit Event for [ITI-104] Patient Identifier Cross-reference Manager / Update patient"
Description: "This profile is used to define the CH Audit Event for the [ITI-104] transaction and the actor 'Patient
Identifier Cross-reference Manager' when updating a patient."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Patient Identifier Source' actor (EPR application)"
* agent[server] ^short = "The 'Patient Identifier Cross-reference Manager' actor (Health Dossier API)"
* entity[patient].what.identifier 1..1
  * value 1..1
  * system 1..1


Instance:   ChAuditEventIti104SourceExample
InstanceOf: ChAuditEventIti104Source
Usage:      #example
* insert ChAuditEventIti104ExampleRules
* insert ChExampleAuditEventClientRules
* subtype[anyUpdate] = $restfulInteraction#update "update"

Instance:   ChAuditEventIti104ManagerUpdateExample
InstanceOf: ChAuditEventIti104ManagerUpdate
Usage:      #example
* insert ChAuditEventIti104ExampleRules
* insert ChExampleAuditEventServerRules(MPI)
* subtype[anyUpdate] = $restfulInteraction#update "update"


RuleSet: ChAuditEventIti104ExampleRules
* insert ChExampleAuditEventBaseRules(client, server, MPI)
* insert ChExampleAuditEventHcpRules
* insert ChExampleAuditEventEntityPatientRules
* type = $auditEventType#rest
* subtype[iti104] = $eventTypeCode#ITI-104 "Patient Identity Feed FHIR"
* agent[server].network.address = "http://example.com"
* entity[data]
  * what.identifier
    * value = "761337610411353650"
    * system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
  * type = $auditEntityType#2
  * role = $objectRole#4
