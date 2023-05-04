Profile: CHmCSDPractitionerRole
Parent: PractitionerRole
Id: ch-mcsd-practitionerrole
Title: "CH mCSD PractitionerRole"
Description: "PractitionerRole"
* obeys ch-mcsd-practitionerrole-ihe-conformance
* practitioner only Reference(CHmCSDPractitioner)
* organization only Reference(CHmCSDOrganization)
* code 1.. // From mCSD
// TODO: code is required. Bind to a value set?


Invariant: ch-mcsd-practitionerrole-ihe-conformance
Description: "The Practitioner needs to conform to IHE.mCSD.PractitionerRole"
Expression: "conformsTo('https://profiles.ihe.net/ITI/mCSD/StructureDefinition/IHE.mCSD.PractitionerRole')"
Severity: #error


Mapping:  CHmCSDPractitionerRoleToHCProfessional
Source:   CHmCSDPractitionerRole
Target:   "https://www.bag.admin.ch/epra"
Title:    "LDAP schema"
* -> "Relationship"
* identifier -> "Relationship.cn"
* organization -> "Relationship.owner"
* practitioner -> "Relationship.member"
// objectClass: no need to map, LDAP only


Instance: ChmCSDPractitionerRolePeterPanSpitalXDept3
InstanceOf: CHmCSDPractitionerRole
Title: "CH mCSD PractitionerRole Dr. Peter Pan at Spital X Dept. 3"
Description: "An exemple of CHmCSDOrganization that contains the same information as Spital X, Dept. 3 in the Swiss
examples (CN=CommunityA:00000001004,OU=Relationship,DC=HPD,O=BAG,C=ch)"
* id = "PeterPanSpitalXDept3"
* identifier[+].value = "CN=CommunityA:00000001004,OU=Relationship,DC=HPD,O=BAG,C=ch"
* practitioner = Reference(CHmCSDPractitionerDrPeterPan)
* organization = Reference(CHmCSDOrganizationSpitalXDept3)
* code = $sct#309343006 "Physician"
