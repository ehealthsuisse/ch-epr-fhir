// All profiles and rules for the CH Audit Events, used by other profiles

Profile:     ChAuditEventBasicToken
Parent:      AuditEvent
Title:       "CH Audit Event with a Basic Auth Token"
Description: "This is the profile for Swiss Audit Events when a transaction is secured with a Basic Authorization Token."
* agent ^slicing.discriminator.type = #value
* agent ^slicing.discriminator.path = "type"
* agent ^slicing.rules = #open
* agent contains mainUser 0..1 and delegatedUser 0..1
* entity ^slicing.discriminator.type = #value
* entity ^slicing.discriminator.path = "type"
* entity ^slicing.rules = #open
* insert ChAuditEventRules


Profile:     ChAuditEventExtendedToken
Parent:      ChAuditEventBasicToken
Title:       "CH Audit Event with an Extended Auth Token"
Description: "This is the profile for Swiss Audit Events when a transaction is secured with an Extended Authorization
Token."
* agent[mainUser] 1..1
  * purposeOfUse 1..1
* entity contains patient 1..1
* entity[patient] 1..1
  * what.identifier 1..1
    * value 1..1
    * system 1..1


// All rules that apply to the AuditEvents with both Basic and Extended Tokens
// You have to define the slices in the profile before applying this one
RuleSet: ChAuditEventRules
* agent[mainUser]
  * ^short = "The main user (patient, representative, healthcare professional, or administrator)"
  * type = $v3ParticipationType#RESP "responsible party"
  * role 1..1
  * altId 1..1
  * name 1..1
  * purposeOfUse 0..1
  * purposeOfUse from http://fhir.ch/ig/ch-term/ValueSet/EprPurposeOfUse
* agent[delegatedUser]
  * ^short = "The person who acted on behalf of the main user (an assistant or technical user)"
  * type = $v3ParticipationType#PPRF "primary performer"
  * role 1..1
  * altId 1..1
  * name 1..1
* source
  * site 1..1
  * site ^short = "The OID of the audit source"
* entity contains traceparent 0..1
* entity[traceparent]
  * ^short = "The 'traceparent' header value of the transaction"
  * what 1..1
    * identifier 1..1
      * value 1..1
      * value ^short = "The 'traceparent' header value"
  * type = $auditEntityType#4 "Other"
  * role = $objectRole#26 "Processing Element"


RuleSet: ChAuditEventBasicRules
* agent contains mainUser 0..1 and delegatedUser 0..1
* insert ChAuditEventRules


RuleSet: ChAuditEventExtendedRules
* agent contains mainUser 1..1 and delegatedUser 0..1
* insert ChAuditEventRules
* agent[mainUser].purposeOfUse 1..1
* entity[patient] 1..1
  * what.identifier 1..1
    * value 1..1
    * system 1..1


// Reference mapping from the XUA assertion to the CH Audit Event
Mapping: ChXuaToAuditEventMapping
Source:  ChAuditEventBasicToken
Target:  "https://www.bag.admin.ch/epra"
Title:   "CH XUA Assertion"
* agent[mainUser]
  * role         -> "AttributeStatement/Attribute[@Name=\"urn:oasis:names:tc:xacml:2.0:subject:role\"]/AttributeValue/Role"
  * altId        -> "Subject/NameID"
  * name         -> "AttributeStatement/Attribute[@Name=\"urn:oasis:names:tc:xspa:1.0:subject:subject-id\"]/AttributeValue"
  * purposeOfUse -> "AttributeStatement/Attribute[@Name=\"urn:oasis:names:tc:xspa:1.0:subject:purposeofuse\"]/AttributeValue/PurposeOfUse"
* agent[delegatedUser]
  * altId        -> "Subject/SubjectConfirmation/NameID"
  * name         -> "Subject/SubjectConfirmation/SubjectConfirmationData/AttributeStatement/Attribute[@Name=\"urn:oasis:names:tc:xspa:1.0:subject:subject-id\"]/AttributeValue"


// Reference mapping from the IUA Extended Token to the CH Audit Event
Mapping: ChJwtToAuditEventMapping
Source:  ChAuditEventBasicToken
Target:  "https://www.bag.admin.ch/epra"
Title:   "CH JWT Basic/Extended Token"
* agent[mainUser]
  * role         -> "extensions.ihe_iua.subject_role"
  * altId        -> "extensions.ch_epr.user_id"
  * name         -> "extensions.ihe_iua.subject_name"
  * purposeOfUse -> "extensions.ihe_iua.purpose_of_use"
* agent[delegatedUser]
  * altId        -> "extensions.ch_delegation.principal_id"
  * name         -> "extensions.ch_delegation.principal"


// Rule Sets for examples

// Base rules for all examples
// Also update the copy of this rule set in ChAuditEventmCSD1ExampleRules (mcsd_auditevent.fsh)
// Also update the copy of this rule set in ChAuditEventIti68ExampleRules (mhd_auditevent.fsh)
RuleSet: ChExampleAuditEventBaseRules(sourceSlice, destinationSlice)
* recorded = "2024-10-28T09:43:56Z"
* outcome = #0
* agent[{sourceSlice}]
  * type = DCM#110153 "Source Role ID"
  * who.display = "My e-Health App"
  * requestor = false
  * network
    * address = "192.168.1.1"
    * type = #2
* agent[{destinationSlice}]
  * type = DCM#110152 "Destination Role ID"
  * who.display = "Community A"
  * requestor = false
  * network.type = #5 // The address needs to be define in each example (transaction specific)
* entity[traceparent]
  * what.identifier.value = "00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00"
  * type = $auditEntityType#4 "Other"
  * role = $objectRole#26 "Processing Element"


// Rules for audit on the client side
RuleSet: ChExampleAuditEventClientRules
* source
  * site = "2.16.756.1.2.3"
  * observer.display = "My e-Health App"


// Rules for audit on the community (server) side
RuleSet: ChExampleAuditEventServerRules
* source
  * site = "2.16.756.4.5.6"
  * observer.display = "Community A"


// Rules for an extended token for an healthcare professional
RuleSet: ChExampleAuditEventHcpRules
* agent[mainUser]
  * role = $ehealthRole#HCP
  * altId = "2000000090092"
  * name = "Martina Musterarzt"
  * requestor = true
  * purposeOfUse = $purposeOfUse#NORM "Normal Access"


// Rules for an entity representing a patient
RuleSet: ChExampleAuditEventEntityPatientRules
* entity[patient]
  * what.identifier
    * value = "761337610411353650"
    * system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
  * type = $auditEntityType#1 "Person"
  * role = $objectRole#1 "Patient"
