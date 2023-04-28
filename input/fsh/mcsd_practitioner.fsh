Profile: CHmCSDPractitioner
Parent: Practitioner
Id: ch-mcsd-practitioner
Title: "CH mCSD Practitioner"
Description: "Practitioner"
* obeys ch-mcsd-practitioner-ihe-conformance
* identifier 2.. // uid and hcIdentifier are required
// qualification can be bound to hcProfession and hcSpecialisation value sets
* qualifitcation 1.. // hcProfession is required


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
* name.given -> "HCProfessional.initials" // As given by FHIR specifications
* name.family -> "HCProfessional.sn"
* name.text -> "HCProfessional.cn"
* communication.coding.code -> "HCProfessional.hpdProviderLanguageSupported"
* gender -> "HCProfessional.gender"
* telecom -> "HCProfessional.hpdMedicalRecordsDeliveryEmailAddress"
* telecom -> "HCProfessional.mail"
// userSMIMECertificate // TODO: extension?
// hcSigningCertificate // TODO: extension?
// userCertificate // TODO: extension?
// createTimestamp // TODO: extension?
* meta.lastUpdated -> "HCProfessional.modifyTimestamp"
* address -> "HCProfessional.physicalDeliveryOfficeName" // TODO: extension?
* address -> "HCProfessional.hpdProviderMailingAddress"
* address -> "HCProfessional.hpdProviderBillingAddress"
* address -> "HCProfessional.hpdProviderPracticeAddress"
// hcPracticeLocation: TODO: this references DNs
* telecom -> "HCProfessional.telephoneNumber" // [system='phone']
* telecom -> "HCProfessional.mobile"
* telecom -> "HCProfessional.pager"
* telecom -> "HCProfessional.facsimileTelephoneNumber" // [system='fax']
* qualification.code -> "HCProfessional.hcSpecialisation"
// memberOf: contained in PractitionerRoles
* address -> "HCProfessional.hpdProviderLegalAddress"
// hcRegistrationStatus: no need to map, only value is "Unknown"
// objectClass: no need to map, LDAP only
