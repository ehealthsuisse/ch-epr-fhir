Profile: CHmCSDPractitionerRole
Parent: PractitionerRole
Id: CH.mCSD.PractitionerRole
Title: "CH mCSD PractitionerRole"
Description: "PractitionerRole"
* obeys ch-mcsd-practitionerrole-ihe-conformance
* practitioner only Reference(CHmCSDPractitioner)
* practitioner 1.. // From HPD
* organization only Reference(CHmCSDOrganization)
* organization 1.. // From HPD
* code 1.. // From mCSD
// TODO: code is required. Bind to a value set? Or change specs?


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
Description: "An exemple of CHmCSDPractitionerRole that contains the same information as Dr. Peter Pan - Spital X, Dept. 3
Relationship in the Swiss examples (CN=CommunityA:00000001004,OU=Relationship,DC=HPD,O=BAG,C=ch)"
* id = "PeterPanSpitalXDept3"
* identifier[+].value = "CN=CommunityA:00000001004,OU=Relationship,DC=HPD,O=BAG,C=ch"
* practitioner = Reference(CHmCSDPractitionerDrPeterPan)
* organization = Reference(CHmCSDOrganizationSpitalXDept3)
* code = $sct#309343006 "Physician"


Instance: ChmCSDPractitionerRolePeterPanPraxisP
InstanceOf: CHmCSDPractitionerRole
Title: "CH mCSD PractitionerRole Dr. Peter Pan at Praxis P"
Description: "An exemple of CHmCSDPractitionerRole that contains the same information as Dr. Peter Pan - Praxis P
Relationship in the Swiss examples (CN=CommunityA:00000001001,OU=Relationship,DC=HPD,O=BAG,C=ch)"
* id = "PeterPanPraxisP"
* identifier[+].value = "CN=CommunityA:00000001001,OU=Relationship,DC=HPD,O=BAG,C=ch"
* practitioner = Reference(CHmCSDPractitionerDrPeterPan)
* organization = Reference(CHmCSDOrganizationPraxisP)
* code = $sct#309343006 "Physician"
