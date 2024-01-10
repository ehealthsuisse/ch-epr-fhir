Profile: CHmCSDPractitioner
Parent: http://fhir.ch/ig/ch-core/StructureDefinition/ch-core-practitioner-epr
Id: CH.mCSD.Practitioner
Title: "CH mCSD Practitioner"
Description: "CH mCSD profile on Practitioner"
* obeys ch-mcsd-practitioner-ihe-conformance
* qualification 1.. // hcProfession is required


Invariant: ch-mcsd-practitioner-ihe-conformance
Description: "The Practitioner needs to conform to IHE.mCSD.Practitioner"
Expression: "conformsTo('https://profiles.ihe.net/ITI/mCSD/StructureDefinition/IHE.mCSD.Practitioner')"
Severity: #error


Mapping:  CHmCSDPractitionerToHCProfessional
Source:   CHmCSDPractitioner
Target:   "https://www.bag.admin.ch/epra"
Title:    "LDAP schema"
* -> "HCProfessional"
* identifier -> "HCProfessional.uid"
* identifier -> "HCProfessional.hcIdentifier"
* qualification.code -> "HCProfessional.hcProfession"
* active -> "HCProfessional.hpdProviderStatus" // Information is lost: Active, Inactive, Retired, Deceased to boolean
* name.text -> "HCProfessional.displayName"
* name.prefix -> "HCProfessional.title"
* name.given -> "HCProfessional.givenName"
* name.family -> "HCProfessional.sn"
* name.text -> "HCProfessional.cn"
* communication.coding.code -> "HCProfessional.hpdProviderLanguageSupported"
* gender -> "HCProfessional.gender"
* telecom -> "HCProfessional.hpdMedicalRecordsDeliveryEmailAddress"
* telecom -> "HCProfessional.mail"
* meta.lastUpdated -> "HCProfessional.modifyTimestamp"
* address -> "HCProfessional.physicalDeliveryOfficeName"
* address -> "HCProfessional.hpdProviderMailingAddress"
* address -> "HCProfessional.hpdProviderBillingAddress"
* address -> "HCProfessional.hpdProviderPracticeAddress"
* telecom -> "HCProfessional.telephoneNumber" // [system='phone']
* telecom -> "HCProfessional.mobile"
* telecom -> "HCProfessional.pager"
* telecom -> "HCProfessional.facsimileTelephoneNumber" // [system='fax']
* qualification.code -> "HCProfessional.hcSpecialisation"
* address -> "HCProfessional.hpdProviderLegalAddress"


Instance: CHmCSDPractitionerDrPeterPan
InstanceOf: CHmCSDPractitioner
Title: "CH mCSD Practitioner Dr. Peter Pan"
Description: "An example of CHmCSDPractitioner that contains the same information as Dr. Peter Pan in the Swiss examples
(uid=CommunityA:00000003002,OU=HCProfessional,DC=HPD,O=BAG,C=ch)"
* id = "DrPeterPan"
* identifier[+].system = "urn:oid:2.51.1.3"
* identifier[=].value = "7601000102737"
* identifier[+].value = "uid=CommunityA:00000003002,OU=HCProfessional,DC=HPD,O=BAG,C=ch"
* active = true
* name.text = "Peter Pan"
* name.family = "Pan"
* name.given = "Peter" // Wrong (Pan) in the example
* name.prefix = "Dr."
* telecom[+].system = #email
* telecom[=].value = "peter.pan@email.com"
* telecom[+].system = #fax
* telecom[=].value = "+41 32 001 00 05"
* telecom[+].system = #phone
* telecom[=].value = "+41 79 001 00 06"
* telecom[=].use = #mobile
* telecom[+].system = #phone
* telecom[=].value = "+41 32 001 00 04"
* telecom[+].system = #pager
* telecom[=].value = "+41 79 001 00 07"
* gender = #male
* qualification[+].code = $sct#309343006 "Physician"
* qualification[+].code = $medreg#1051 "General internal medicine"
* communication[+].coding = $bcp47#de
* communication[+].coding = $bcp47#fr
* communication[+].coding = $bcp47#en
* communication[+].coding = $bcp47#it
