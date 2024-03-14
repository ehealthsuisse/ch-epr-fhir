ValueSet: PpqmActorIdentifierType
Title: "PPQm Actor Identifier Type"
Description: "Actor Identifier Types for PPQm"
* ^experimental = false

* $URI#urn:e-health-suisse:2015:epr-spid                   "EPR-SPID"
* $URI#urn:e-health-suisse:representative-id               "Representative ID"
* $URI#urn:gs1:gln                                         "GLN"
* $URI#urn:oasis:names:tc:xspa:1.0:subject:organization-id "Organization ID"

// #####################################################################################################################

CodeSystem: PpqmConsentIdentifierType
Id: PpqmConsentIdentifierType
Title: "PPQm Consent Identifier Type"
Description: "Code system for PPQm Consent Identifier Types"
* ^caseSensitive = true
* ^experimental = false

* #policySetId     "Policy Set UUID"           "Policy Set UUID"
* #templateId      "Policy Set Template ID"    "Policy Set Template ID"

// #####################################################################################################################

ValueSet: PpqmConsentIdentifierType
Title: "PPQm Consent Identifier Type"
Description: "Value Set for PPQm Consent Identifier Types"
* ^experimental = false

* include codes from system PpqmConsentIdentifierType

// #####################################################################################################################

ValueSet: PpqmFeedRequestHttpMethod
Title: "PPQm Feed Request HTTP Method"
Description: "HTTP methods allowed in PPQm Feed requests"
* ^experimental = false

* http://hl7.org/fhir/http-verb#POST    "POST"
* http://hl7.org/fhir/http-verb#PUT     "PUT"
* http://hl7.org/fhir/http-verb#DELETE  "DELETE"

// #####################################################################################################################

CodeSystem: PpqmPolicySetTemplateId
Id: PpqmPolicySetTemplateId
Title: "PPQm Policy Set Template ID"
Description: "Code system for Policy Set Template IDs"
* ^caseSensitive = true
* ^experimental = false

* #201   "201"   "Template 201 -- Full access for the patient"
* #202   "202"   "Template 202 -- Read access in emergency mode"
* #203   "203"   "Template 203 -- Default provision level"
* #301   "301"   "Template 301 -- Read access for a healthcare professional"
* #302   "302"   "Template 302 -- Read access for a group of healthcare professionals"
* #303   "303"   "Template 303 -- Full access for a representative"

// #####################################################################################################################

ValueSet: PpqmPolicySetTemplateId
Title: "PPQm Policy Set Template ID"
Description: "IDs of policy set templates"
* ^experimental = false

* include codes from system PpqmPolicySetTemplateId

// #####################################################################################################################

ValueSet: PpqmReferencedPolicySet
Title: "PPQm Referenced Policy Set"
Description: "IDs of basis policy sets that may be referenced from templates.  Note that this value set intentionally does not contain IDs of all policy sets contained in the official stack, see [documentation](https://github.com/ehealthsuisse/ch-epr-adr-ppq/blob/main/docs/Policies.md)"
* ^experimental = false

* $URI#urn:e-health-suisse:2015:policies:access-level:full                      "Full access"                     // "Full access for a patient or a patient representative"
* $URI#urn:e-health-suisse:2015:policies:provide-level:normal                   "Write normal"                    // "Creation of new documents with confidentiality level not less than NORMAL"
* $URI#urn:e-health-suisse:2015:policies:provide-level:restricted               "Write restricted"                // "Creation of new documents with confidentiality level not less than RESTRICTED"
* $URI#urn:e-health-suisse:2015:policies:provide-level:secret                   "Write secret"                    // "Creation of new documents with confidentiality level not less than SECRET"
* $URI#urn:e-health-suisse:2015:policies:access-level:normal                    "Read normal"                     // "Read access to documents with confidentiality level NORMAL"
* $URI#urn:e-health-suisse:2015:policies:access-level:restricted                "Read restricted"                 // "Read access to documents with confidentiality level NORMAL and RESTRICTED"
* $URI#urn:e-health-suisse:2015:policies:access-level:delegation-and-normal     "Read normal with delegation"     // "Read access to documents with confidentiality level NORMAL with the possibility to delegate it"
* $URI#urn:e-health-suisse:2015:policies:access-level:delegation-and-restricted "Read restricted with delegation" // "Read access to documents with confidentiality level NORMAL and RESTRICTED with the possibility to delegate it"
* $URI#urn:e-health-suisse:2015:policies:exclusion-list                         "Exclusion list"                  // "Exclusion list, neither read nor write access is allowed"
