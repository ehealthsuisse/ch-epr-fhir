Profile: CHmCSDPractitionerRole
Parent: PractitionerRole
Id: ch-mcsd-practitionerrole
Title: "CH mCSD PractitionerRole"
Description: "PractitionerRole"
* obeys ch-mcsd-practitionerrole-ihe-conformance


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
