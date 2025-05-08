ValueSet: RestrictedHTTPVerbVS
Id: restricted-http-verb-vs
Title: "Restricted HTTP Verb Value Set"
Description: "Value set for allowed HTTP verbs, excluding GET operations."
* ^experimental = false
* http://hl7.org/fhir/http-verb#POST "POST"
* http://hl7.org/fhir/http-verb#PUT "PUT"
* http://hl7.org/fhir/http-verb#DELETE "DELETE"

Profile:        ChmCSDProcessCareServices
// Parent:         MCSDProcessCareServices we cannot inherit from the IHE profile because multiple inheritance is not supported (our Practitioner is derived from the CHmCSDPractitioner and is only indirectly conforming to IHE mCSD Practitioner)
Parent:         Bundle
Title:          "Process"
Description:    "A profile on the Bundle transaction for ITI-130 Process Care Services Resources Request Message"
* type = #transaction
* entry.request 1..1 MS
* entry.request.method from RestrictedHTTPVerbVS (required)
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.description = "Slicing based on the profile conformance of the entry"
* entry and entry.resource MS
* entry contains 
    MCSDPractitioner 0..* and
    MCSDPractitionerRole 0..* and
    MCSDOrganization 0..* 
* entry[MCSDPractitioner].resource only CHmCSDPractitioner
* entry[MCSDPractitioner] ^short = "Practitioner"
* entry[MCSDPractitionerRole].resource only CHmCSDPractitionerRole 
* entry[MCSDPractitionerRole] ^short = "PractitionerRole"
* entry[MCSDOrganization].resource only CHmCSDOrganization
* entry[MCSDOrganization] ^short = "Organization"
