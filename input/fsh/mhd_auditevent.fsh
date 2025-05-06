// Audit events [ITI-65]
Profile:     ChAuditEventIti65Source
Parent:      AuditProvideBundleSource
Title:       "CH Audit Event for [ITI-65] Document Source"
Description: "This profile is used to define the CH Audit Event for the [ITI-65] transaction and the actor 'Document
Source'."
* insert ChAuditEventExtendedRules
* agent[documentSource] ^short = "The 'Document Source' actor (EPR application)"
* agent[documentRecipient] ^short = "The 'Document Recipient' actor (EPR API)"
* entity[submissionSet].what.identifier 1..1
  * value 1..1
  * system 1..1
  * system = "urn:ietf:rfc:3986"


Profile:     ChAuditEventIti65Recipient
Parent:      AuditProvideBundleRecipient
Title:       "CH Audit Event for [ITI-65] Document Recipient"
Description: "This profile is used to define the CH Audit Event for the [ITI-65] transaction and the actor 'Document
Recipient'."
* insert ChAuditEventExtendedRules
* agent[documentSource] ^short = "The 'Document Source' actor (EPR application)"
* agent[documentRecipient] ^short = "The 'Document Recipient' actor (EPR API)"
* entity[submissionSet].what.identifier 1..1
  * value 1..1
  * system 1..1
  * system = "urn:ietf:rfc:3986"


Instance:   ChAuditEventIti65SourceExample
InstanceOf: ChAuditEventIti65Source
Usage:      #example
* insert ChAuditEventIti65ExampleRules
* insert ChExampleAuditEventClientRules
* type = DCM#110106 "Export"


Instance:   ChAuditEventIti65RecipientExample
InstanceOf: ChAuditEventIti65Recipient
Usage:      #example
* insert ChAuditEventIti65ExampleRules
* insert ChExampleAuditEventServerRules
* type = DCM#110107 "Import"


RuleSet: ChAuditEventIti65ExampleRules
* insert ChExampleAuditEventBaseRules(documentSource, documentRecipient)
* insert ChExampleAuditEventHcpRules
* insert ChExampleAuditEventEntityPatientRules
* subtype[iti65] = $eventTypeCode#ITI-65 "Provide Document Bundle"
* agent[documentRecipient].network.address = "https://example.org/fhir/"
* entity[submissionSet]
  * what.identifier
    * value = "urn:oid:1.3.6.1.4.1.12559.11.13.2.6.2949"
    * system = "urn:ietf:rfc:3986"
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#20 "Job"


// ---------------------------------------------------------------------------------------------------------------------
// Audit events [ITI-67]
Profile:     ChAuditEventIti67Consumer
Parent:      AuditFindDocumentReferencesConsumer
Title:       "CH Audit Event for [ITI-67] Document Consumer"
Description: "This profile is used to define the CH Audit Event for the [ITI-67] transaction and the actor 'Document
Consumer'."
* insert ChAuditEventExtendedRules
* agent[client] ^short = "The 'Document Consumer' actor (EPR application)"
* agent[server] ^short = "The 'Document Responder' actor (EPR API)"


Profile:     ChAuditEventIti67Responder
Parent:      AuditFindDocumentReferencesResponder
Title:       "CH Audit Event for [ITI-67] Document Responder"
Description: "This profile is used to define the CH Audit Event for the [ITI-67] transaction and the actor 'Document
Responder'."
* insert ChAuditEventExtendedRules
* agent[client] ^short = "The 'Document Consumer' actor (EPR application)"
* agent[server] ^short = "The 'Document Responder' actor (EPR API)"


Instance:   ChAuditEventIti67ConsumerExample
InstanceOf: ChAuditEventIti67Consumer
Usage:      #example
* insert ChAuditEventIti67ExampleRules
* insert ChExampleAuditEventClientRules


Instance:   ChAuditEventIti67ResponderExample
InstanceOf: ChAuditEventIti67Responder
Usage:      #example
* insert ChAuditEventIti67ExampleRules
* insert ChExampleAuditEventServerRules


RuleSet: ChAuditEventIti67ExampleRules
* insert ChExampleAuditEventBaseRules(client, server)
* insert ChExampleAuditEventHcpRules
* insert ChExampleAuditEventEntityPatientRules
* type = $auditEventType#rest
* subtype[anySearch] = $restfulInteraction#search "search"
* subtype[iti67] = $eventTypeCode#ITI-67 "Find Document References"
* agent[server].network.address = "https://example.org/fhir/"
* entity[query]
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#24 "Query"
  * query = "aHR0cDovL2V4YW1wbGUuY29tL2ZoaXIvRG9jdW1lbnRSZWZlcmVuY2U/cGF0aWVudC5pZGVudGlmaWVyPXVybjpvaWQ6Mi4xNi43NTYuNS4zMC4xLjEyNy4zLjEwLjN8NzYxMzM3NjEwNDExMzUzNjUwJnN0YXR1cz1jdXJyZW50"


// ---------------------------------------------------------------------------------------------------------------------
// Audit events [ITI-68]
Profile:     ChAuditEventIti68Consumer
Parent:      AuditRetrieveDocumentConsumer
Title:       "CH Audit Event for [ITI-68] Document Consumer"
Description: "This profile is used to define the CH Audit Event for the [ITI-68] transaction and the actor 'Document
Consumer'."
* insert ChAuditEventIti68Rules


Profile:     ChAuditEventIti68Responder
Parent:      AuditRetrieveDocumentResponder
Title:       "CH Audit Event for [ITI-68] Document Responder"
Description: "This profile is used to define the CH Audit Event for the [ITI-68] transaction and the actor 'Document
Responder'."
* insert ChAuditEventIti68Rules


RuleSet: ChAuditEventIti68Rules
* insert ChAuditEventExtendedRules
* agent[client] ^short = "The 'Document Consumer' actor (EPR application)"
* agent[server] ^short = "The 'Document Responder' actor (EPR API)"
* entity[data]
  * ^short = "The document that was accessed"
  * what.reference 1..1
    * ^short = "The URL accessed by the Document Consumer"
  * securityLabel from http://fhir.ch/ig/ch-term/ValueSet/DocumentEntry.confidentialityCode
  * securityLabel ^short = "The confidentiality code of the document, if known"


Instance:   ChAuditEventIti68ConsumerExample
InstanceOf: ChAuditEventIti68Consumer
Usage:      #example
* insert ChAuditEventIti68ExampleRules
* insert ChExampleAuditEventClientRules


Instance:   ChAuditEventIti68ResponderExample
InstanceOf: ChAuditEventIti68Responder
Usage:      #example
* insert ChAuditEventIti68ExampleRules
* insert ChExampleAuditEventServerRules


RuleSet: ChAuditEventIti68ExampleRules
// Copy of ChExampleAuditEventBaseRules, with agent codes fixed
* recorded = "2024-10-28T09:43:56Z"
* outcome = #0
* agent[server]
  * type = DCM#110153 "Source Role ID"
  * who.display = "Community A"
  * requestor = false
  * network
    * address = "https://example.org/blah/blah.pdf"
    * type = #5
* agent[client]
  * type = DCM#110152 "Destination Role ID"
  * who.display = "My e-Health App"
  * requestor = false
  * network
    * address = "192.168.1.1"
    * type = #2
* entity[traceparent]
  * what
    * identifier
      * value = "00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00"
  * type = $auditEntityType#4 "Other"
  * role = $objectRole#26 "Processing Element"
// End of copy of ChExampleAuditEventBaseRules
* insert ChExampleAuditEventHcpRules
* insert ChExampleAuditEventEntityPatientRules
* type = $auditEventType#rest
* subtype[anyRead] = $restfulInteraction#read "read"
* subtype[iti68] = $eventTypeCode#ITI-68 "Retrieve Document"
* entity[data]
  * what.reference = "https://example.org/blah/blah.pdf"
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#3 "Report"


// ---------------------------------------------------------------------------------------------------------------------
// Audit events [CH:MHD-1]
Invariant: val-audit-source
Description: "The Audit Source is this agent too."
Expression: "$this.who = %resource.source.observer"
Severity: #error


Profile:     ChAuditEventChMhd1Source
Parent:      AuditEvent
Id:          ch-mhd-updatedocumentmetadata-audit-source
Title:       "CH Audit Event for [CH:MHD-1] Document Source"
Description: "This profile is used to define the CH Audit Event for the [CH:MHD-1] transaction and the actor 'Document
Source'."
* modifierExtension 0..0
* type = DCM#110106 "Export"
* action = #U
* subtype ^slicing.discriminator.type = #value
* subtype ^slicing.discriminator.path = "$this"
* subtype ^slicing.rules = #open // allow other codes
* subtype 1..
* subtype contains chmhd1 1..1
* subtype[chmhd1] = urn:e-health-suisse:event-type-code#CH-MHD-1 "Update Document Metadata"
// * severity in R5
* recorded 1..1 // already required
* outcome 1..1
* outcomeDesc MS // encouraged
// source is already required, see invariant val-audit-source use
* agent ^slicing.discriminator.type = #value
* agent ^slicing.discriminator.path = "type"
* agent ^slicing.rules = #open
* agent ^slicing.description = "source, recipient, and possibly the user who participated"
* agent contains
	documentSource 1..1 and
	documentResponder 1..1
	// may be many including app identity, user identity, etc
* agent[documentSource].type = DCM#110153 "Source Role ID"
* agent[documentSource].who 1..1
* agent[documentSource] obeys val-audit-source
* agent[documentSource].network 1..1
* agent[documentResponder].type = DCM#110152 "Destination Role ID"
* agent[documentResponder].who 1..1
* agent[documentResponder].network 1..1
* agent[documentSource] ^short = "Document Source"
* agent[documentResponder] ^short = "Document Responder"
* entity ^slicing.discriminator.type = #value
* entity ^slicing.discriminator.path = "type"
* entity ^slicing.rules = #closed
* entity ^slicing.description = "patient and submission set involved"
* entity contains
	patient 1..1 and
	documentReference 1..1
* entity[patient].type = $auditEntityType#1 "Person"
* entity[patient].role = $objectRole#1 "Patient"
* entity[patient].what 1..1
* entity[patient].what only Reference(Patient)
* entity[documentReference].type = $auditEntityType#2 "System Object"
* entity[documentReference].role = $objectRole#20 "Job"
* entity[documentReference].what 1..1
* entity[documentReference].what only Reference(DocumentReference)
* entity[documentReference].what.reference 1..1
* entity[patient] ^short = "Patient"
* entity[documentReference] ^short = "DocumentReference"
* insert ChAuditEventExtendedRules
* agent[documentSource] ^short = "The 'Document Source' actor (EPR application)"
* agent[documentResponder] ^short = "The 'Document Recipient' actor (EPR API)"


Profile:     ChAuditEventChMhd1Responder
Parent:      AuditEvent
Id:          ch-mhd-updatedocumentmetadata-audit-responder
Title:       "CH Audit Event for [CH:MHD-1] Document Responder"
Description: "This profile is used to define the CH Audit Event for the [CH:MHD-1] transaction and the actor 'Document
Responder'."
* modifierExtension 0..0
* type = DCM#110107 "Import"
* action = #U
* subtype ^slicing.discriminator.type = #value
* subtype ^slicing.discriminator.path = "$this"
* subtype ^slicing.rules = #open // allow other codes
* subtype 1..
* subtype contains chmhd1 1..1
* subtype[chmhd1] = urn:e-health-suisse:event-type-code#CH-MHD-1 "Update Document Metadata"
// * severity in R5
* recorded 1..1 // already required
* outcome 1..1
* outcomeDesc MS // encouraged
// source is already required, see invariant val-audit-source use
* agent ^slicing.discriminator.type = #value
* agent ^slicing.discriminator.path = "type"
* agent ^slicing.rules = #open
* agent ^slicing.description = "source, recipient, and possibly the user who participated"
* agent contains
	documentSource 1..1 and
	documentResponder 1..1
	// may be many including app identity, user identity, etc
* agent[documentSource].type = DCM#110153 "Source Role ID"
* agent[documentSource].who 1..1
* agent[documentSource].network 1..1
* agent[documentResponder].type = DCM#110152 "Destination Role ID"
* agent[documentResponder].who 1..1
* agent[documentResponder] obeys val-audit-source
* agent[documentResponder].network 1..1
* agent[documentSource] ^short = "Document Source"
* agent[documentResponder] ^short = "Document Responder"
* entity ^slicing.discriminator.type = #value
* entity ^slicing.discriminator.path = "type"
* entity ^slicing.rules = #closed
* entity ^slicing.description = "patient and submission set involved"
* entity contains
	patient 1..1 and
	documentReference 1..1
* entity[patient].type = $auditEntityType#1 "Person"
* entity[patient].role = $objectRole#1 "Patient"
* entity[patient].what 1..1
* entity[patient].what only Reference(Patient)
* entity[documentReference].type = $auditEntityType#2 "System Object"
* entity[documentReference].role = $objectRole#20 "Job"
* entity[documentReference].what 1..1
* entity[documentReference].what only Reference(DocumentReference)
* entity[documentReference].what.reference 1..1
* entity[patient] ^short = "Patient"
* entity[documentReference] ^short = "DocumentReference"
* insert ChAuditEventExtendedRules
* agent[documentSource] ^short = "The 'Document Source' actor (EPR application)"
* agent[documentResponder] ^short = "The 'Document Responder' actor (EPR API)"


Instance:   ChAuditEventChMhd1SourceExample
InstanceOf: ChAuditEventChMhd1Source
Usage:      #example
* insert ChAuditEventChMhd1ExampleRules
* insert ChExampleAuditEventClientRules
* type = DCM#110106 "Export"


Instance:   ChAuditEventChMhd1ResponderExample
InstanceOf: ChAuditEventChMhd1Responder
Usage:      #example
* insert ChAuditEventChMhd1ExampleRules
* insert ChExampleAuditEventServerRules
* type = DCM#110107 "Import"


RuleSet: ChAuditEventChMhd1ExampleRules
* insert ChExampleAuditEventBaseRules(documentSource, documentResponder)
* insert ChExampleAuditEventHcpRules
* insert ChExampleAuditEventEntityPatientRules
* subtype[chmhd1] = urn:e-health-suisse:event-type-code#CH-MHD-1 "Update Document Metadata"
* agent[documentResponder].network.address = "https://example.org/fhir/"
* entity[documentReference]
  * what.reference = "https://example.org/fhir/DocumentReference/1c8d1f74-1686-4188-9c35-0c5727c771cc"
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#20 "Job"
