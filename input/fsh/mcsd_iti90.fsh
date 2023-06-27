Instance: mCSDITI90ResponseBundle
InstanceOf: Bundle
Title: "mCSD Find Matching Care Services Response Bundle"
Description: "An exemple of ITI-90 response Bundle in the profile CH mCSD"
* type = #searchset
* id = "FindMatchingCareServicesResponse"
// Let's put all our examples
* entry[+].resource = CHmCSDPractitionerDrPeterPan
* entry[+].resource = CHmCSDOrganizationSpitalX
* entry[+].resource = CHmCSDOrganizationSpitalXDept3
* entry[+].resource = CHmCSDOrganizationPraxisP
* entry[+].resource = ChmCSDPractitionerRolePeterPanSpitalXDept3
* entry[+].resource = ChmCSDPractitionerRolePeterPanPraxisP
