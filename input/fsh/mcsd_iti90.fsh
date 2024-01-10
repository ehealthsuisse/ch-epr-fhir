Instance: mCSDITI90ResponseBundle
InstanceOf: Bundle
Title: "mCSD Find Matching Care Services Response Bundle"
Description: "An example of ITI-90 response Bundle in the profile CH mCSD"
* type = #searchset
* id = "FindMatchingCareServicesResponse"
* link[0].relation = #self
* link[0].url = "http://test.fhir.ch/r4/Practitioner?family=Pan"
// Let's put all our examples
* entry[0].fullUrl = "http://test.fhir.ch/r4/Practitioner/DrPeterPan"
* entry[=].resource = CHmCSDPractitionerDrPeterPan
* entry[=].search.mode = #match
* entry[+].fullUrl = "http://test.fhir.ch/r4/Organization/SpitalX"
* entry[=].resource = CHmCSDOrganizationSpitalX
* entry[=].search.mode = #include
* entry[+].fullUrl = "http://test.fhir.ch/r4/Organization/SpitalXDept3"
* entry[=].resource = CHmCSDOrganizationSpitalXDept3
* entry[=].search.mode = #include
* entry[+].fullUrl = "http://test.fhir.ch/r4/Organization/PraxisP"
* entry[=].resource = CHmCSDOrganizationPraxisP
* entry[=].search.mode = #include
* entry[+].fullUrl = "http://test.fhir.ch/r4/PractitionerRole/PeterPanSpitalXDept3"
* entry[=].resource = ChmCSDPractitionerRolePeterPanSpitalXDept3
* entry[=].search.mode = #include
* entry[+].fullUrl = "http://test.fhir.ch/r4/PractitionerRole/PeterPanPraxisP"
* entry[=].resource = ChmCSDPractitionerRolePeterPanPraxisP
* entry[=].search.mode = #include
