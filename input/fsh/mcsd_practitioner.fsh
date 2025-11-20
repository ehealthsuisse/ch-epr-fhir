Profile: CHmCSDPractitioner
Parent: http://fhir.ch/ig/ch-core/StructureDefinition/ch-core-practitioner-epr
Id: CH.mCSD.Practitioner
Title: "CH mCSD Practitioner"
Description: "CH mCSD profile on Practitioner"
* obeys ch-mcsd-practitioner-ihe-conformance
* qualification 1.. // hcProfession is required
* identifier contains LDAP 0..1
* identifier[LDAP] only LdapIdentifier
* identifier[LDAP] ^short = "LDAP DN (Distinguished Name), if the practitioner is stored in an HPD"
* identifier[LDAP] ^patternIdentifier.system = "urn:ietf:rfc:4514"


Invariant: ch-mcsd-practitioner-ihe-conformance
Description: "The Practitioner needs to conform to IHE.mCSD.Practitioner"
Expression: "conformsTo('https://profiles.ihe.net/ITI/mCSD/StructureDefinition/IHE.mCSD.Practitioner')"
Severity: #error


Profile: CHmCSDFeedPractitioner
Parent: CHmCSDPractitioner
Id: CH.mCSD.Feed.Practitioner
Title: "CH mCSD Feed Practitioner"
Description: "CH mCSD profile on Practitioner Feed"
* gender from CHmCSDPractitionerGenderVS (required)
* gender ^short = "male | female"


ValueSet: CHmCSDPractitionerGenderVS
Id: ch-mcsd-practitioner-gender-vs
Title: "CH mCSD Practitioner Administrative Gender Value Set"
Description: """Value set for the administrative gender of a CH mCSD Practitioner. Only 'male' and 'female' values are
allowed in the HPD context."""
* ^experimental = false
* include http://hl7.org/fhir/administrative-gender#male
* include http://hl7.org/fhir/administrative-gender#female


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
* identifier[GLN].system = "urn:oid:2.51.1.3"
* identifier[GLN].value = "7601000102737"
* identifier[LDAP].system = "urn:ietf:rfc:4514"
* identifier[LDAP].value = "uid=CommunityA:00000003002,OU=HCProfessional,DC=HPD,O=BAG,C=ch"
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
