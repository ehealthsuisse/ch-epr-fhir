Profile: PpqmConsent
Parent: Consent
Id: PpqmConsent
Title: "CH PPQm Consent"
Description: "Swiss EPR Policy Set as a Consent"

* obeys ch-epr-ppqm-template-structure

* identifier ^slicing.discriminator.type    = #pattern
* identifier ^slicing.discriminator.path    = "type.coding"
* identifier ^slicing.rules                 = #open
* identifier ^slicing.description           = "PpqmConsent Identifiers"
* identifier ^slicing.ordered               = false

* identifier contains
    policySetId 1..1 and
    templateId  1..1

* identifier[policySetId]               ^short = "UUID of the Policy Set"
* identifier[policySetId].use           0..0
* identifier[policySetId].type          1..1
* identifier[policySetId].type.coding   1..1
* identifier[policySetId].type.coding   = PpqmConsentIdentifierType#policySetId
* identifier[policySetId].system        0..0
* identifier[policySetId].value         1..1
* identifier[policySetId].value         ^short = "UUID of the policy set in URN format"
* identifier[policySetId].value         obeys ch-epr-ppqm-uuid-format
* identifier[policySetId].period        0..0
* identifier[policySetId].assigner      0..0

* identifier[templateId]                ^short = "Template ID of the policy set"
* identifier[templateId].use            0..0
* identifier[templateId].type           1..1
* identifier[templateId].type.coding    1..1
* identifier[templateId].type.coding    = PpqmConsentIdentifierType#templateId
* identifier[templateId].system         0..0
* identifier[templateId].value          1..1
* identifier[templateId].value          ^short = "Template ID of the policy set"
* identifier[templateId].value          from PpqmPolicySetTemplateId (required)
* identifier[templateId].period         0..0
* identifier[templateId].assigner       0..0


* status        = #active
* status ^short = "Fixed status value"

* scope         = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* scope ^short  = "Fixed scope value"
* scope.coding  1..1

* category          1..1
* category          = http://terminology.hl7.org/CodeSystem/v3-ActCode#INFA
* category          ^short = "Fixed category value"
* category.coding   1..1

* patient                       1..1
* patient.reference             0..0
* patient.type                  0..0
* patient.identifier            1..1
* patient.identifier            only EPRSPIDIdentifier
* patient.identifier.use        0..0
* patient.identifier.type       0..0
* patient.identifier.period     0..0
* patient.identifier.assigner   0..0
* patient.display               0..0

* dateTime      0..0

* performer     0..0

* organization  0..0

* source[x]     0..0

* policy        0..0

* policyRule                      1..1
* policyRule                      ^short = "ID of the referenced basis policy set"
* policyRule.coding               1..1
* policyRule.coding               from PpqmReferencedPolicySet (required)
* policyRule.coding.version       0..0
* policyRule.coding.code          1..1
* policyRule.coding.system        1..1
* policyRule.coding.display       0..1
* policyRule.coding.userSelected  0..0
* policyRule.text                 0..1

* verification 0..0

* provision                 1..1
* provision.type            0..0
* provision.period          0..1
* provision.period.start    0..1
* provision.period.start    ^short = "Start date of the policy set validity, yyyy-mm-dd"
* provision.period.start    obeys ch-epr-ppqm-date-format
* provision.period.end      1..1
* provision.period.end      ^short = "End date of the policy set validity, yyyy-mm-dd"
* provision.period.end      obeys ch-epr-ppqm-date-format

* provision.actor                       1..1
* provision.actor.role                  1..1
* provision.actor.role                  from http://fhir.ch/ig/ch-epr-term/ValueSet/EprRole (required)
* provision.actor.role.coding.system    1..1
* provision.actor.role.coding.system    = "urn:oid:2.16.756.5.30.1.127.3.10.6"
* provision.actor.role.coding.code      1..1
* provision.actor.role.coding.code      ^short = "EPR actor role code"

* provision.actor.reference                                     1..1
* provision.actor.reference.reference                           0..0
* provision.actor.reference.type                                0..0
* provision.actor.reference.identifier                          0..1
* provision.actor.reference.identifier                          ^short = "This element is present only in policy sets which reference a particular healthcare professional, group of healthcare professionals, patient, or representative"
* provision.actor.reference.identifier.use                      0..0
* provision.actor.reference.identifier.type                     1..1
* provision.actor.reference.identifier.type.coding              1..1
* provision.actor.reference.identifier.type.coding              from PpqmActorIdentifierType (required)
* provision.actor.reference.identifier.type.coding.system       1..1
* provision.actor.reference.identifier.type.coding.version      0..0
* provision.actor.reference.identifier.type.coding.code         1..1
* provision.actor.reference.identifier.type.coding.code         ^short = "Actor identifier type code (name qualifier)"
* provision.actor.reference.identifier.type.coding.display      0..1
* provision.actor.reference.identifier.type.coding.userSelected 0..0
* provision.actor.reference.identifier.type.text                0..0
* provision.actor.reference.identifier.value                    1..1
* provision.actor.reference.identifier.value                    ^short = "ID of an healthcare professional, group of healthcare professionals, patient, or representative"
* provision.actor.reference.identifier.period                   0..0
* provision.actor.reference.identifier.assigner                 0..0

* provision.actor.reference.display 0..1
* provision.actor.reference.display ^short = "This element is present only in policy sets which reference indefinite sets of actors"

* provision.action          0..0
* provision.securityLabel   0..0
* provision.purpose         0..*
* provision.purpose         from http://fhir.ch/ig/ch-epr-term/ValueSet/EprPurposeOfUse (required)
* provision.purpose.system  1..1
* provision.purpose.system  = "urn:oid:2.16.756.5.30.1.127.3.10.5"
* provision.purpose.code    1..1
* provision.class           0..0
* provision.code            0..0
* provision.dataPeriod      0..0
* provision.data            0..0
* provision.provision       0..0


Invariant:      ch-epr-ppqm-uuid-format
Description:    "The policy set ID must be a UUID in URN format"
Expression:     "lower().matches('^urn:uuid:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$')"
Severity:       #error

Invariant:      ch-epr-ppqm-date-format
Description:    "Timestamp must have precision of days, i.e. not contain the time part"
Expression:     "toString().matches('^[0-9]{4}-[0-9]{2}-[0-9]{2}$')"
Severity:       #error

Invariant:      ch-epr-ppqm-template-structure
Description:    "The resource shall correspond to one of official policy set templates"
Expression:     "(
                    identifier.exists(type.coding.exists((system = 'http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType') and (code = 'templateId')) and (value = '201')) and
                    (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:access-level:full') and
                    provision[0].period.empty() and
                    (provision[0].actor.role.coding.code = 'PAT') and
                    (provision[0].actor.reference.identifier.type.coding.code = 'urn:e-health-suisse:2015:epr-spid') and
                    provision[0].actor.reference.identifier.value.matches('^[0-9]{18}$') and
                    provision[0].actor.reference.display.empty() and
                    provision[0].purpose.empty() and
                    (provision[0].actor.reference.identifier[0].value = patient.identifier.value)
                ) or (
                    identifier.exists(type.coding.exists((system = 'http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType') and (code = 'templateId')) and (value = '202')) and
                    (
                        (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:access-level:normal') or
                        (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:access-level:restricted')
                    ) and
                    provision[0].period.empty() and
                    (provision[0].actor.role.coding.code = 'HCP') and
                    provision[0].actor.reference.identifier.empty() and
                    (provision[0].actor.reference.display = 'all') and
                    (provision[0].purpose.count() = 1) and
                    (provision[0].purpose.code = 'EMER')
                ) or (
                    identifier.exists(type.coding.exists((system = 'http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType') and (code = 'templateId')) and (value = '203')) and
                    (
                        (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:provide-level:normal') or
                        (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:provide-level:restricted')
                    ) and
                    provision[0].period.empty() and
                    (provision[0].actor.role.coding.code = 'HCP') and
                    provision[0].actor.reference.identifier.empty() and
                    (provision[0].actor.reference.display = 'all') and
                    (provision[0].purpose.count() = 3) and
                    (provision[0].purpose.exists(code = 'NORM')) and
                    (provision[0].purpose.exists(code = 'AUTO')) and
                    (provision[0].purpose.exists(code = 'DICOM_AUTO'))
                ) or (
                    identifier.exists(type.coding.exists((system = 'http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType') and (code = 'templateId')) and (value = '301')) and
                    (
                        (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:access-level:normal') or
                        (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:access-level:restricted') or
                        (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:access-level:delegation-and-normal') or
                        (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:access-level:delegation-and-restricted') or
                        (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:exclusion-list')
                    ) and
                    (policyRule.coding.code.contains('delegation').empty() or provision.period.end.exists()) and
                    (provision[0].actor.role.coding.code = 'HCP') and
                    (provision[0].actor.reference.identifier.type.coding.code = 'urn:gs1:gln') and
                    provision[0].actor.reference.identifier.value.matches('^[0-9]{13}$') and
                    provision[0].actor.reference.display.empty() and
                    (provision[0].purpose.count() = 1) and
                    (provision[0].purpose.code = 'NORM')
                ) or (
                    identifier.exists(type.coding.exists((system = 'http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType') and (code = 'templateId')) and (value = '302')) and
                    (
                        (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:access-level:normal') or
                        (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:access-level:restricted')
                    ) and
                    provision[0].period.end.exists() and
                    (provision[0].actor.role.coding.code = 'HCP') and
                    (provision[0].actor.reference.identifier.type.coding.code = 'urn:oasis:names:tc:xspa:1.0:subject:organization-id') and
                    provision[0].actor.reference.identifier.value.lower().matches('^urn:oid:([0-2])((\\\\.0)|(\\\\.[1-9][0-9]*))*$') and
                    provision[0].actor.reference.display.empty() and
                    (provision[0].purpose.count() = 1) and
                    (provision[0].purpose.code = 'NORM')
                ) or (
                    identifier.exists(type.coding.exists((system = 'http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType') and (code = 'templateId')) and (value = '303')) and
                    (policyRule[0].coding.code = 'urn:e-health-suisse:2015:policies:access-level:full') and
                    provision[0].period.empty() and
                    (provision[0].actor.role.coding.code = 'REP') and
                    (provision[0].actor.reference.identifier.type.coding.code = 'urn:e-health-suisse:representative-id') and
                    provision[0].actor.reference.identifier.value.matches('^\\\\S+$') and
                    provision[0].actor.reference.display.empty() and
                    provision[0].purpose.empty()
                )"
Severity:       #error



Instance: Template201Consent
InstanceOf: PpqmConsent
Title: "PPQm Consent for template 201"
Description: "CH:PPQm Consent for template 201 -- Full access for the patient"
Usage: #example
* text.status = #empty
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><p>Template 201 - Full access for the patient</p></div>"
* identifier[policySetId].value = "urn:uuid:57ab9b0d-7d97-4d85-9e4b-02bc7c939ad9"
* identifier[templateId].value = "201"
* status = #active
* scope.coding = #patient-privacy
* category.coding = #INFA
* patient.identifier.system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* patient.identifier.value = "761337610000000002"
* policyRule.coding = $URI#urn:e-health-suisse:2015:policies:access-level:full
* provision.actor.role.coding = #PAT
* provision.actor.reference.identifier.type.coding = $URI#urn:e-health-suisse:2015:epr-spid
* provision.actor.reference.identifier.value = "123456789012345678"


Instance: Template202Consent
InstanceOf: PpqmConsent
Title: "PPQm Consent for template 202"
Description: "CH:PPQm Consent for template 202 -- Access in emergency mode"
Usage: #example
* text.status = #empty
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><p>Template 202 - Access in emergency mode</p></div>"
* identifier[policySetId].value = "urn:uuid:bf6c1fb6-2eb9-49ad-b96b-1a4ac55fc7bd"
* identifier[templateId].value = "202"
* status = #active
* scope.coding = #patient-privacy
* category.coding = #INFA
* patient.identifier.system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* patient.identifier.value = "761337610000000002"
* policyRule.coding = $URI#urn:e-health-suisse:2015:policies:access-level:normal
* provision.actor.role.coding = #HCP
* provision.actor.reference.display = "all"
* provision.purpose = ChEhealthCodesystemPurposeOfUse#EMER


Instance: Template203Consent
InstanceOf: PpqmConsent
Title: "PPQm Consent for template 203"
Description: "CH:PPQm Consent for template 203 -- Default provide level"
Usage: #example
* text.status = #empty
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><p>Template 203 - Default provide level</p></div>"
* identifier[policySetId].value = "urn:uuid:710e4211-d431-430b-a849-1d689e74e4c2"
* identifier[templateId].value = "203"
* status = #active
* scope.coding = #patient-privacy
* category.coding = #INFA
* patient.identifier.system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* patient.identifier.value = "761337610000000002"
* policyRule.coding = $URI#urn:e-health-suisse:2015:policies:provide-level:restricted
* provision.actor.role.coding = #HCP
* provision.actor.reference.display = "all"
* provision.purpose[0] = ChEhealthCodesystemPurposeOfUse#NORM
* provision.purpose[1] = ChEhealthCodesystemPurposeOfUse#AUTO
* provision.purpose[2] = ChEhealthCodesystemPurposeOfUse#DICOM_AUTO


Instance: Template301Consent
InstanceOf: PpqmConsent
Title: "PPQm Consent for template 301"
Description: "CH:PPQm Consent for template 301 -- Access level for a healthcare professional"
Usage: #example
* text.status = #empty
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><p>Template 301 - Access level for a healthcare professional</p></div>"
* identifier[policySetId].value = "urn:uuid:f1e1ed8e-0582-4e47-a76e-5e8f6cc0908f"
* identifier[templateId].value = "301"
* status = #active
* scope.coding = #patient-privacy
* category.coding = #INFA
* patient.identifier.system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* patient.identifier.value = "761337610000000002"
* policyRule.coding = $URI#urn:e-health-suisse:2015:policies:access-level:delegation-and-normal
* provision.period.end = "2022-02-15"
* provision.actor.role.coding = #HCP
* provision.actor.reference.identifier.type.coding = $URI#urn:gs1:gln
* provision.actor.reference.identifier.value = "9876543210987"
* provision.purpose[0] = ChEhealthCodesystemPurposeOfUse#NORM


Instance: Template302Consent
InstanceOf: PpqmConsent
Title: "PPQm Consent for template 302"
Description: "CH:PPQm Consent for template 302 -- Access level for a group of healthcare professionals"
Usage: #example
* text.status = #empty
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><p>Template 302 -- Access level for a group of healthcare professionals</p></div>"
* identifier[policySetId].value = "urn:uuid:c23c862a-b297-43c7-875b-d933982c9756"
* identifier[templateId].value = "302"
* status = #active
* scope.coding = #patient-privacy
* category.coding = #INFA
* patient.identifier.system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* patient.identifier.value = "761337610000000002"
* policyRule.coding = $URI#urn:e-health-suisse:2015:policies:access-level:restricted
* provision.period.start = "2022-02-01"
* provision.period.end = "2022-02-15"
* provision.actor.role.coding = #HCP
* provision.actor.reference.identifier.type.coding = $URI#urn:oasis:names:tc:xspa:1.0:subject:organization-id
* provision.actor.reference.identifier.value = "urn:oid:1.2.3.4.5"
* provision.purpose[0] = ChEhealthCodesystemPurposeOfUse#NORM


Instance: Template303Consent
InstanceOf: PpqmConsent
Title: "PPQm Consent for template 303"
Description: "CH:PPQm Consent for template 303 -- Full access for a representative"
Usage: #example
* text.status = #empty
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><p>Template 303 - Full access for a representative</p></div>"
* identifier[policySetId].value = "urn:uuid:f663289d-4cc4-41d7-a01d-213e18e1f722"
* identifier[templateId].value = "303"
* status = #active
* scope.coding = #patient-privacy
* category.coding = #INFA
* patient.identifier.system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* patient.identifier.value = "761337610000000002"
* policyRule.coding = $URI#urn:e-health-suisse:2015:policies:access-level:full
* provision.actor.role.coding = #REP
* provision.actor.reference.identifier.type.coding = $URI#urn:e-health-suisse:representative-id
* provision.actor.reference.identifier.value = "representative12345"


Mapping: PpqmConsentToXacml20PolicySet
Source: PpqmConsent
Target: "http://docs.oasis-open.org/xacml/2.0"
Title: "CH:PPQ XACML 2.0 Policy Set"
Id: ppqm-consent-xacml20-mapping

* -> "PolicySet"

* identifier.value -> "/PolicySet/@PolicySetId"

* patient.identifier.system -> "/PolicySet/Target/Resources/Resource/ResourceMatch/AttributeValue/InstanceIdentifier/@root"
* patient.identifier.value  -> "/PolicySet/Target/Resources/Resource/ResourceMatch/AttributeValue/InstanceIdentifier/@extension"

* policyRule.coding.code -> "/PolicySet/PolicySetIdReference"

* provision.period.start -> "/PolicySet/Target/Environments/Environment/EnvironmentMatch[@MatchId='urn:oasis:names:tc:xacml:1.0:function:date-less-than-or-equal']/AtributeValue"
* provision.period.end   -> "/PolicySet/Target/Environments/Environment/EnvironmentMatch[@MatchId='urn:oasis:names:tc:xacml:1.0:function:date-greater-than-or-equal']/AtributeValue"

* provision.actor.role.coding.system -> "/PolicySet/Target/Subjects/Subject/SubjectMatch[SubjectAttributeDesignator/@AttributeId='urn:oasis:names:tc:xacml:2.0:subject:role']/AttributeValue/CodedValue/@codeSystem"
* provision.actor.role.coding.code   -> "/PolicySet/Target/Subjects/Subject/SubjectMatch[SubjectAttributeDesignator/@AttributeId='urn:oasis:names:tc:xacml:2.0:subject:role']/AttributeValue/CodedValue/@code"

* provision.actor.reference.identifier.type.coding.code -> "/PolicySet/Target/Subjects/Subject/SubjectMatch[SubjectAttributeDesignator/@AttributeId='urn:oasis:names:tc:xacml:1.0:subject:subject-id-qualifier']/AttributeValue" "if NOT equal to 'urn:oasis:names:tc:xspa:1.0:subject:organization-id'"
* provision.actor.reference.identifier.value            -> "/PolicySet/Target/Subjects/Subject/SubjectMatch[SubjectAttributeDesignator/@AttributeId='urn:oasis:names:tc:xacml:1.0:subject:subject-id']/AttributeValue"           "if identifier.type is NOT equal to 'urn:oasis:names:tc:xspa:1.0:subject:organization-id'"
* provision.actor.reference.identifier.value            -> "/PolicySet/Target/Subjects/Subject/SubjectMatch[SubjectAttributeDesignator/@AttributeId='urn:oasis:names:tc:xspa:1.0:subject:organization-id']/AttributeValue"       "if identifier.type is equal to 'urn:oasis:names:tc:xspa:1.0:subject:organization-id'"

* provision.purpose.system -> "/PolicySet/Target/Subjects/Subject/SubjectMatch[SubjectAttributeDesignator/@AttributeId='urn:oasis:names:tc:xspa:1.0:subject:purposeofuse']/AttributeValue/CodedValue/@codeSystem"
* provision.purpose.code   -> "/PolicySet/Target/Subjects/Subject/SubjectMatch[SubjectAttributeDesignator/@AttributeId='urn:oasis:names:tc:xspa:1.0:subject:purposeofuse']/AttributeValue/CodedValue/@code"
