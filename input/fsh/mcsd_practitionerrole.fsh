Profile: CHmCSDPractitionerRole
Parent: http://fhir.ch/ig/ch-core/StructureDefinition/ch-core-practitionerrole-epr
Id: CH.mCSD.PractitionerRole
Title: "CH mCSD PractitionerRole"
Description: "CH mCSD profile on PractitionerRole"
* obeys ch-mcsd-practitionerrole-ihe-conformance
* practitioner only Reference(CHmCSDPractitioner)
* practitioner 1.. // From HPD
* organization only Reference(CHmCSDOrganization)
* organization 1.. // From HPD
* code 1.. // From mCSD
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "$this"
* identifier ^slicing.rules = #open
* identifier contains memberOf 0..1
* identifier[memberOf] only HpdUidIdentifier
* identifier[memberOf] ^short = "CN of the HPD Relationship where the referenced Practitioner is a member"
* code from HCProfessionalHcProfession (required)
* specialty from HCProfessionalHcSpecialisation (required)


Invariant: ch-mcsd-practitionerrole-ihe-conformance
Description: "The Practitioner needs to conform to IHE.mCSD.PractitionerRole"
Expression: "conformsTo('https://profiles.ihe.net/ITI/mCSD/StructureDefinition/IHE.mCSD.PractitionerRole')"
Severity: #error


Mapping:  CHmCSDPractitionerRoleToRelationship
Source:   CHmCSDPractitionerRole
Target:   "https://www.bag.admin.ch/epra"
Title:    "HPD schema (DSMLv2/LDAP)"
* -> "Relationship"
* identifier[memberOf] -> "Relationship.cn"
* organization -> "Relationship.owner"
* practitioner -> "Relationship.member"
* code -> "HCProfessional.hcProfession"
* specialty -> "HCProfessional.hcSpecialisation"


Instance: ChmCSDPractitionerRolePeterPanSpitalXDept3
InstanceOf: CHmCSDPractitionerRole
Title: "CH mCSD PractitionerRole Dr. Peter Pan at Spital X Dept. 3"
Description: "An example of CHmCSDPractitionerRole that contains the same information as Dr. Peter Pan - Spital X, Dept. 3
Relationship in the Swiss examples (CN=CommunityA:00000001004,OU=Relationship,DC=HPD,O=BAG,C=ch)"
* id = "PeterPanSpitalXDept3"
* identifier[memberOf].value = "CommunityA:SpitalXDept3Relationship"
* active = true
* practitioner = Reference(CHmCSDPractitionerDrPeterPan)
* organization = Reference(CHmCSDOrganizationSpitalXDept3)
* code = $sct#309343006 "Physician"
* specialty = $medreg#1051 "General internal medicine"


Instance: ChmCSDPractitionerRolePeterPanPraxisP
InstanceOf: CHmCSDPractitionerRole
Title: "CH mCSD PractitionerRole Dr. Peter Pan at Praxis P"
Description: "An example of CHmCSDPractitionerRole that contains the same information as Dr. Peter Pan - Praxis P
Relationship in the Swiss examples (CN=CommunityA:00000001001,OU=Relationship,DC=HPD,O=BAG,C=ch)"
* id = "PeterPanPraxisP"
* identifier[memberOf].value = "CommunityA:PraxisPRelationship"
* active = true
* practitioner = Reference(CHmCSDPractitionerDrPeterPan)
* organization = Reference(CHmCSDOrganizationPraxisP)
* code = $sct#309343006 "Physician"
* specialty = $medreg#1051 "General internal medicine"
