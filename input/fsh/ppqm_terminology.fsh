ValueSet: PpqmActorIdentifierType
Title: "CH PPQm Actor Identifier Type"
Description: "Actor Identifier Types for CH:PPQm"
* ^experimental = false

* $URI#urn:e-health-suisse:2015:epr-spid                   "EPR-SPID"
* $URI#urn:e-health-suisse:representative-id               "Representative ID"
* $URI#urn:gs1:gln                                         "GLN"
* $URI#urn:oasis:names:tc:xspa:1.0:subject:organization-id "Organization ID"


CodeSystem: PpqmConsentIdentifierType
Id: PpqmConsentIdentifierType
Title: "CH PPQm Consent Identifier Type"
Description: "Code system for CH:PPQm Consent Identifier Types"
* ^caseSensitive = true
* ^experimental = false

* #policySetId     "Policy Set UUID"           "Policy Set UUID"
* #templateId      "Policy Set Template ID"    "Policy Set Template ID"


ValueSet: PpqmConsentIdentifierType
Title: "CH PPQm Consent Identifier Type"
Description: "Value Set for CH:PPQm Consent Identifier Types"
* ^experimental = false

* include codes from system PpqmConsentIdentifierType


ValueSet: PpqmFeedRequestHttpMethod
Title: "CH PPQm Feed Request HTTP Method"
Description: "HTTP methods allowed in CH:PPQm Feed requests"
* ^experimental = false

* http://hl7.org/fhir/http-verb#POST    "POST"
* http://hl7.org/fhir/http-verb#PUT     "PUT"
* http://hl7.org/fhir/http-verb#DELETE  "DELETE"


CodeSystem: PpqmPolicySetTemplateId
Id: PpqmPolicySetTemplateId
Title: "CH PPQm Policy Set Template ID"
Description: "Code system for Policy Set Template IDs"
* ^caseSensitive = true
* ^experimental = false

* #201   "201"   "Template 201 -- Full access for the patient"
* #202   "202"   "Template 202 -- Read access in emergency mode"
* #203   "203"   "Template 203 -- Default provision level"
* #301   "301"   "Template 301 -- Read access for a healthcare professional without delegation"
* #302   "302"   "Template 302 -- Read access for a group of healthcare professionals"
* #303   "303"   "Template 303 -- Full access for a representative"
* #304   "304"   "Template 304 -- Read access for a healthcare professional with delegation"


ValueSet: PpqmPolicySetTemplateId
Title: "CH PPQm Policy Set Template ID"
Description: "IDs of policy set templates"
* ^experimental = false

* include codes from system PpqmPolicySetTemplateId


ValueSet: PpqmReferencedPolicySetFullAccess
Title: "CH PPQm Referenced Policy Set for Patients (201) and Representative (303) templates"
Description: "IDs of basis policy sets that may be referenced from templates 201 and 303"
* ^experimental = false
* $URI#urn:e-health-suisse:2015:policies:access-level:full                      "Full access"                     // "Full access for a patient or a patient representative"


ValueSet: PpqmReferencedPolicySetGroupEmergency
Title: "CH PPQm Referenced Policy Set for Emergency Access (202) and HCP Group (302) templates"
Description: "IDs of basis policy sets that may be referenced from templates 202 and 302"
* ^experimental = false
* $URI#urn:e-health-suisse:2015:policies:access-level:normal                    "Read normal"                     // "Read access to documents with confidentiality level NORMAL"
* $URI#urn:e-health-suisse:2015:policies:access-level:restricted                "Read restricted"                 // "Read access to documents with confidentiality level NORMAL and RESTRICTED"


ValueSet: PpqmReferencedPolicySetDefaultProvide
Title: "CH PPQm Referenced Policy Set for Default Provide (203) template"
Description: "IDs of basis policy sets that may be referenced from template 203"
* ^experimental = false
* $URI#urn:e-health-suisse:2015:policies:provide-level:normal                   "Write normal"                    // "Creation of new documents with confidentiality level not less than NORMAL"
* $URI#urn:e-health-suisse:2015:policies:provide-level:restricted               "Write restricted"                // "Creation of new documents with confidentiality level not less than RESTRICTED"
* $URI#urn:e-health-suisse:2015:policies:provide-level:secret                   "Write secret"                    // "Creation of new documents with confidentiality level not less than SECRET"


ValueSet: PpqmReferencedPolicySetHcpWithoutDelegation
Title: "CH PPQm Referenced Policy Set for Healthcare Professionals without Delegation (301) template"
Description: "IDs of basis policy sets that may be referenced from template 301"
* ^experimental = false
* $URI#urn:e-health-suisse:2015:policies:access-level:normal                    "Read normal"                     // "Read access to documents with confidentiality level NORMAL"
* $URI#urn:e-health-suisse:2015:policies:access-level:restricted                "Read restricted"                 // "Read access to documents with confidentiality level NORMAL and RESTRICTED"
* $URI#urn:e-health-suisse:2015:policies:exclusion-list                         "Exclusion list"                  // "Exclusion list, neither read nor write access is allowed"


ValueSet: PpqmReferencedPolicySetHcpWithDelegation
Title: "CH PPQm Referenced Policy Set for Healthcare Professionals with Delegation (304) template"
Description: "IDs of basis policy sets that may be referenced from template 304"
* ^experimental = false
* $URI#urn:e-health-suisse:2015:policies:access-level:delegation-and-normal     "Read normal with delegation"     // "Read access to documents with confidentiality level NORMAL with the possibility to delegate it"
* $URI#urn:e-health-suisse:2015:policies:access-level:delegation-and-restricted "Read restricted with delegation" // "Read access to documents with confidentiality level NORMAL and RESTRICTED with the possibility to delegate it"
