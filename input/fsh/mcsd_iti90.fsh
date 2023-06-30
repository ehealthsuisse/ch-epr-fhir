Instance: mCSDITI90ResponseBundle
InstanceOf: Bundle
Title: "mCSD Find Matching Care Services Response Bundle"
Description: "An exemple of ITI-90 response Bundle in the profile CH mCSD"
* type = #searchset
* id = "FindMatchingCareServicesResponse"
// Let's put all our examples
* entry[0].fullUrl = "http://test.fhir.ch/r4/Practitioner/DrPeterPan"
* entry[=].resource = CHmCSDPractitionerDrPeterPan
* entry[+].fullUrl = "http://test.fhir.ch/r4/Organization/SpitalX"
* entry[=].resource = CHmCSDOrganizationSpitalX
* entry[+].fullUrl = "http://test.fhir.ch/r4/Organization/SpitalXDept3"
* entry[=].resource = CHmCSDOrganizationSpitalXDept3
* entry[+].fullUrl = "http://test.fhir.ch/r4/Organization/PraxisP"
* entry[=].resource = CHmCSDOrganizationPraxisP
* entry[+].fullUrl = "http://test.fhir.ch/r4/PractitionerRole/PeterPanSpitalXDept3"
* entry[=].resource = ChmCSDPractitionerRolePeterPanSpitalXDept3
* entry[+].fullUrl = "http://test.fhir.ch/r4/PractitionerRole/PeterPanSpitalX"
* entry[=].resource = ChmCSDPractitionerRolePeterPanPraxisP
