Profile: ChAuditEventBasicToken
Parent: AuditEvent
Title: "CH Audit Event with a Basic Auth Token"
Description: "This is the profile for Swiss Audit Events when a transaction is secured with a Basic Authorization Token"
* source
  * site 1..1
  * site ^short = "The OID of the audit source"
* entity ^slicing.discriminator.type = #pattern
* entity ^slicing.discriminator.path = "type"
* entity ^slicing.rules = #open
* entity contains traceparent 1..1
* entity[traceparent]
  * ^short = "The 'traceparent' header value of the transaction"
  * what 1..1
    * identifier 1..1
      * value 1..1
      * value ^short = "The 'traceparent' header value"
  * type = http://terminology.hl7.org/CodeSystem/audit-entity-type#4 "Other"
  * role = http://terminology.hl7.org/CodeSystem/object-role#26 "Processing Element"


Profile: ChAuditEventExtendedToken
Parent: AuditEvent
Title: "CH Audit Event with an Extended Auth Token"
Description: "This is the profile for Swiss Audit Events when a transaction is secured with an Extended Authorization Token"
* agent ^slicing.discriminator.type = #pattern
* agent ^slicing.discriminator.path = "type"
* agent ^slicing.rules = #open
* agent contains mainUser 1..1
             and delegatedUser 0..1
// TODO: The purpose of use is not a Swiss requirement, but it should be specified here
* agent[mainUser]
  * ^short = "The main user"
  // TODO: need to find a good 'type'. BALP uses multiple codes for this slice.
  //       https://github.com/search?q=repo%3AIHE%2FITI.BasicAudit%20agent%5Buser%5D&type=code
  * type = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#RESP "responsible party"
  * role 1..1
  * altId 1..1
  // Here, we could have mapped to 'name' instead of 'who.display', but BALP requires a value in 'who'
  * name 1..1
* agent[delegatedUser]
  * ^short = "The person who acted on behalf of the main user"
  // TODO: need to find a good 'type'.
  * type = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#PPRF "primary performer"
  * role 1..1
  * altId 1..1
  * name 1..1
* source
  * site 1..1
  * site ^short = "The OID of the audit source"
* entity ^slicing.discriminator.type = #pattern
* entity ^slicing.discriminator.path = "type"
* entity ^slicing.rules = #open
* entity contains data 0..1 and traceparent 1..1
* entity[data]
  * ^short = "The document that was accessed"
  * type = http://terminology.hl7.org/CodeSystem/audit-entity-type#2 "System Object"
  * securityLabel from http://fhir.ch/ig/ch-term/ValueSet/DocumentEntry.confidentialityCode
  * securityLabel ^short = "The confidentiality code of the document, if known"
* entity[traceparent]
  * ^short = "The 'traceparent' header value of the transaction"
  * what 1..1
    * identifier 1..1
      * value 1..1
      * value ^short = "The 'traceparent' header value"
  * type = http://terminology.hl7.org/CodeSystem/audit-entity-type#4 "Other"
  * role = http://terminology.hl7.org/CodeSystem/object-role#26 "Processing Element"


Mapping: ChXuaToAuditEventMapping
Source:  ChAuditEventExtendedToken
Target:  "https://www.bag.admin.ch/epra"
Title:   "CH XUA Assertion"
* agent[mainUser]
  * role        -> "AttributeStatement/Attribute[@Name=\"urn:oasis:names:tc:xacml:2.0:subject:role\"]/AttributeValue/Role"
  * altId       -> "Subject/NameID"
  * name        -> "AttributeStatement/Attribute[@Name=\"urn:oasis:names:tc:xspa:1.0:subject:subject-id\"]/AttributeValue"
* agent[delegatedUser]
  * altId       -> "Subject/SubjectConfirmation/NameID"
  * name        -> "Subject/SubjectConfirmation/SubjectConfirmationData/AttributeStatement/Attribute[@Name=\"urn:oasis:names:tc:xspa:1.0:subject:subject-id\"]/AttributeValue"


Mapping: ChJwtToAuditEventMapping
Source:  ChAuditEventExtendedToken
Target:  "https://www.bag.admin.ch/epra"
Title:   "CH JWT Extended Token"
* agent[mainUser]
  * role        -> "extensions.ihe_iua.subject_role"
  * altId       -> "extensions.ch_epr.user_id"
  * name        -> "extensions.ihe_iua.subject_name"
* agent[delegatedUser]
  * altId       -> "extensions.ch_delegation.principal_id"
  * name        -> "extensions.ch_delegation.principal"
