Instance: ex-auditProvideBundle-source
InstanceOf: IHE.MHD.ProvideBundle.Audit.Source
Title: "Audit Example of ITI-65 at source"
Description: "Audit Example for a Provide Bundle Transaction from source perspective"
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* type = DCM#110106 "Export"
* action = #R
* subtype = urn:ihe:event-type-code#ITI-65 "Provide Document Bundle"
//* severity = #Informational
* recorded = 2020-06-29T12:01:30+00:00
* outcome = http://terminology.hl7.org/CodeSystem/audit-event-outcome#0 "Success"
* purposeOfEvent = urn:oid:2.16.756.5.30.1.127.3.10.5#NORM "Normal Access"
* source.site = "urn:oid:1.3.6.1.4.1.12559.11.13.2.5"
* source.observer.display = "ihe-sourceId"
* source.type = http://terminology.hl7.org/CodeSystem/security-source-type#1 "User Device"
// documentSender
* agent[0].type = DCM#110153 "Source Role ID"
* agent[0].who.display = "ihe-sourceId"
* agent[0].requestor = false
* agent[0].network.address = "myDevice.example.com"
* agent[0].network.type = http://hl7.org/fhir/network-type#1 "domain name"
// documentRecipeint
* agent[1].type = DCM#110152 "Destination Role ID"
* agent[1].requestor = false
* agent[1].who.display = "myMachine.example.org"
* agent[1].network.address = "http://server.example.com/fhir"
* agent[1].network.type = http://hl7.org/fhir/network-type#5 "URI"
// user
* agent[2].type = http://terminology.hl7.org/CodeSystem/v3-RoleClass#PROV "healthcare provider" // the user is the hcp
* agent[2].role = urn:oid:2.16.756.5.30.1.127.3.10.6#HCP "Healthcare professional"
* agent[2].name = "Martina Musterarzt"
* agent[2].requestor = true
* agent[2].who.identifier.system = "urn:gs1:gln"
* agent[2].who.identifier.value = "2000000090108"
// iua token jit
* agent[2].policy[0] = "c5436729-3f26-4dbf-abd3-2790dc7771a"
* entity[patient].type = http://terminology.hl7.org/CodeSystem/audit-entity-type#1 "Person"
* entity[patient].role = http://terminology.hl7.org/CodeSystem/object-role#1 "Patient"
* entity[patient].what = Reference(http://example.org/Patient/FranzMusterNeedsAbsoluteUrl)
* entity[submissionSet].type = http://terminology.hl7.org/CodeSystem/audit-entity-type#2 "System Object"
* entity[submissionSet].role = http://terminology.hl7.org/CodeSystem/object-role#20 "Job"
* entity[submissionSet].what.identifier.system = "urn:ietf:rfc:3986"
* entity[submissionSet].what.identifier.value = "urn:oid:1.3.6.1.4.1.12559.11.13.2.6.2949"

