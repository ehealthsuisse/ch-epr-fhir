Profile:        AuditUpdateLimitedDocumentMetadataRecipient
Parent:         AuditEvent
Id:             ch-mhd-updatelimiteddocumentmetadata-audit-recipient
Title:          "Audit Event for Update Limited Document Metadata Transaction at Recipient"
Description:    "Defines constraints on the AuditEvent Resource to record when a Update Limited Document Metadata Transaction happens at the Recipient.
- Import event
- shall have source of itself
- shall have a document source agent
- shall have a document recipient agent
- may have user, app, organization agent(s)
- shall have a patient entity
- shall have a documentreference identity entity"
* modifierExtension 0..0
* type = DCM#110107 "Import"
* action = #C
* subtype ^slicing.discriminator.type = #value
* subtype ^slicing.discriminator.path = "$this"
* subtype ^slicing.rules = #open // allow other codes
* subtype 1..
* subtype contains chmhd1 1..1
* subtype[chmhd1] = urn:e-health-suisse:event-type-code#CH-MHD-1 "Update Limited Document Metadata"
// * severity in R5
* recorded 1..1 // already required
* outcome 1..1
* outcomeDesc MS // encouraged
// source is already required, see invariant val-audit-source use
* agent 2..*
* agent ^slicing.discriminator.type = #pattern
* agent ^slicing.discriminator.path = "type"
* agent ^slicing.rules = #open
* agent ^slicing.description = "source, recipient, and possibly the user who participated"
* agent contains 
	documentSource 1..1 and
	documentRecipient 1..1 
	// may be many including app identity, user identity, etc
* agent[documentSource].type = DCM#110153 "Source Role ID"
* agent[documentSource].who 1..1
* agent[documentSource].network 1..1
* agent[documentRecipient].type = DCM#110152 "Destination Role ID"
* agent[documentRecipient].who 1..1
* agent[documentRecipient] obeys val-audit-source
* agent[documentRecipient].network 1..1
* agent[documentSource] ^short = "Document Source"
* agent[documentRecipient] ^short = "Document Recipient"
* entity 2..2
* entity ^slicing.discriminator.type = #pattern
* entity ^slicing.discriminator.path = "type"
* entity ^slicing.rules = #closed
* entity ^slicing.description = "patient and submission set involved"
* entity contains
	patient 1..1 and
	documentReference 1..1
* entity[patient].type = http://terminology.hl7.org/CodeSystem/audit-entity-type#1 "Person"
* entity[patient].role = http://terminology.hl7.org/CodeSystem/object-role#1 "Patient"
* entity[patient].what 1..1
* entity[patient].what only Reference(Patient)
* entity[documentReference].type = http://terminology.hl7.org/CodeSystem/audit-entity-type#2 "System Object"
* entity[documentReference].role = http://terminology.hl7.org/CodeSystem/object-role#20 "Job"
* entity[documentReference].what 1..1
* entity[documentReference].what only Reference(DocumentReference) 
* entity[patient] ^short = "Patient"
* entity[documentReference] ^short = "DocumentReference"

Invariant: val-audit-source
Description: "The Audit Source is this agent too."
Expression: "$this.who = %resource.source.observer"
Severity: #error

Profile:        AuditUpdateLimitedDocumentMetadataSource
Parent:         AuditEvent
Id:             ch-mhd-updatelimiteddocumentmetadata-audit-source
Title:          "Audit Event for Update Limited DocumentMetadata Transaction at Source"
Description:    "Defines constraints on the AuditEvent Resource to record when a UpdateLimitedDocumentMetadata Transaction happens at the Source.
- Export event
- shall have source of itself
- shall have a document source agent
- shall have a document recipient agent
- may have user, app, organization agent(s)
- shall have a patient entity
- shall have a submission set identity entity"
* modifierExtension 0..0
* type = DCM#110106 "Export"
* action = #R
* subtype ^slicing.discriminator.type = #value
* subtype ^slicing.discriminator.path = "$this"
* subtype ^slicing.rules = #open // allow other codes
* subtype 1..
* subtype contains chmhd1 1..1
* subtype[chmhd1] = urn:e-health-suisse:event-type-code#CH-MHD-1 "Update Limited Document Metadata"
// * severity in R5
* recorded 1..1 // already required
* outcome 1..1
* outcomeDesc MS // encouraged
// source is already required, see invariant val-audit-source use
* agent 2..*
* agent ^slicing.discriminator.type = #pattern
* agent ^slicing.discriminator.path = "type"
* agent ^slicing.rules = #open
* agent ^slicing.description = "source, recipient, and possibly the user who participated"
* agent contains 
	documentSource 1..1 and
	documentRecipient 1..1 
	// may be many including app identity, user identity, etc
* agent[documentSource].type = DCM#110153 "Source Role ID"
* agent[documentSource].who 1..1
* agent[documentSource] obeys val-audit-source
* agent[documentSource].network 1..1
* agent[documentRecipient].type = DCM#110152 "Destination Role ID"
* agent[documentRecipient].who 1..1
* agent[documentRecipient].network 1..1
* agent[documentSource] ^short = "Document Source"
* agent[documentRecipient] ^short = "Document Recipient"
* entity 2..2
* entity ^slicing.discriminator.type = #pattern
* entity ^slicing.discriminator.path = "type"
* entity ^slicing.rules = #closed
* entity ^slicing.description = "patient and submission set involved"
* entity contains
	patient 1..1 and
	documentReference 1..1
* entity[patient].type = http://terminology.hl7.org/CodeSystem/audit-entity-type#1 "Person"
* entity[patient].role = http://terminology.hl7.org/CodeSystem/object-role#1 "Patient"
* entity[patient].what 1..1
* entity[patient].what only Reference(Patient)
* entity[documentReference].type = http://terminology.hl7.org/CodeSystem/audit-entity-type#2 "System Object"
* entity[documentReference].role = http://terminology.hl7.org/CodeSystem/object-role#20 "Job"
* entity[documentReference].what 1..1
* entity[documentReference].what only Reference(DocumentReference) 
* entity[patient] ^short = "Patient"
* entity[documentReference] ^short = "DocumentReference"

Instance: MhdOperationOutcomeErrorXdsMetadataIdentifier
InstanceOf: OperationOutcome
Title: "MHD OperationOutcome DocumentReference udpate error identifiers"
Description: "Error OperationOutcome that the updated DocumentReference has not same values for the identifiers"
Usage: #example
* issue[0].severity = #error
* issue[=].code = #processing
* issue[=].details.text = "XDSMetadataIdentifierError"

Instance: MhdOperationOutcomeErrorXDSPatientIDReconciliationError
InstanceOf: OperationOutcome
Title: "MHD OperationOutcome DocumentReference udpate error patient id reconciliation"
Description: "Error OperationOutcome that the updated DocumentReference references not the same patient"
Usage: #example
* issue[0].severity = #error
* issue[=].code = #processing
* issue[=].details.text = "XDSPatientIDReconciliationError"

Instance: MhdOperationOutcomeErrorUnmodifiableMetadataError
InstanceOf: OperationOutcome
Title: "MHD OperationOutcome DocumentReference udpate error unmodifiable metadata"
Description: "Error OperationOutcome that the updated DocumentReference changed unmodifiable metadata"
Usage: #example
* issue[0].severity = #error
* issue[=].code = #processing
* issue[=].details.text = "UnmodifiableMetadataError"

Extension: ChMhdHomeCommunityId
Id: ch-mhd-home-community-id
Title: "CH MHD Extension to provide the homeCommunityId"
Description: "This CH MHD extension enables to proivde homeCommunityId in an OperationOutcome"
* ^context[+].type = #element
* ^context[=].expression = "OperationOutcome.issue.details"
* . ^short = "CH ELM Extension: HIV Code"
* value[x] 1..
* value[x] only Identifier
* valueIdentifier ^short = "Value of the homeCommunityId"