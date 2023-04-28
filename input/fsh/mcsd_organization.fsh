Profile: CHmCSDOrganization
Parent: Organization
Id: ch-mcsd-organization
Title: "CH mCSD Organization"
Description: "Organization"
* obeys ch-mcsd-organization-ihe-conformance
* identifier 2.. // uid and hcIdentifier are required
// type can be bind to EprHealthcareFacilityTypeCode and EprDocumentPracticeSettingCode
// TODO: IHE has the purposeOfUse extension, should we add it here?
// TODO: we could map businessCategory or HcSpecialisation to purposeOfUse, it is a bit similar
// TODO: address from CH-CORE?


Invariant: ch-mcsd-organization-ihe-conformance
Description: "The Organization needs to conform to IHE.mCSD.Organization"
Expression: "conformsTo('https://profiles.ihe.net/ITI/mCSD/StructureDefinition/IHE.mCSD.Organization')"
Severity: #error


Mapping:  CHmCSDOrganizationToHCProfessional
Source:   CHmCSDOrganization
Target:   "https://www.bag.admin.ch/epra"
Title:    "LDAP schema"
* -> "HCRegulatedOrganization"
* identifier -> "HCRegulatedOrganization.uid"
* identifier -> "HCRegulatedOrganization.hcIdentifier"
// Name and alias are hard to map to O and hcRegisteredName
* name -> "HCRegulatedOrganization.O"
* alias -> "HCRegulatedOrganization.O"
* name -> "HCRegulatedOrganization.hcRegisteredName"
* alias -> "HCRegulatedOrganization.hcRegisteredName"
* type -> "HCRegulatedOrganization.businessCategory"
* active -> "HCRegulatedOrganization.hpdProviderStatus"
// ClinicalInformationContact: TODO: this references DNs
* address -> "HCRegulatedOrganization.hpdProviderPracticeAddress"
* contact.address -> "HCRegulatedOrganization.hpdProviderBillingAddress"
* contact.address -> "HCRegulatedOrganization.hpdProviderMailingAddress"
// hpdProviderLanguageSupported // TODO: extension?
* type -> "HCRegulatedOrganization.HcSpecialisation"
// HcSigningCertificate // This could be an extension
// HcOrganizationCertificates // TODO: extension?
* telecom -> "HCRegulatedOrganization.telephoneNumber"
* telecom -> "HCRegulatedOrganization.facsimileTelephoneNumber"
* partOf -> "HCRegulatedOrganization.memberOf" // TODO: review content of memberOf
// createTimestamp // TODO: extension?
* meta.lastUpdated -> "HCRegulatedOrganization.modifyTimestamp"
* contact.address -> "HCRegulatedOrganization.hpdProviderLegalAddress"
// objectClass: no need to map, LDAP only
* contact.telecom -> "HCRegulatedOrganization.hpdMedicalRecordsDeliveryEmailAddress"


Instance: CHmCSDOrganizationSpitalX
InstanceOf: CHmCSDOrganization
Title: "CH mCSD Organization Spital X"
Description: "An exemple of CHmCSDOrganization that contains the same information as Spital X in the Swiss examples
(uid=CommunityA:00000001000,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch)"
* meta.lastUpdated =
* identifier[+].use = #official
* identifier[=].value = "CommunityA:00000001000"
* identifier[+].use = #old
* identifier[=].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:oid:2.16.10.89.201" // TODO: RefData, Inactive
* active = true
* type[+].coding = $sct#394802001 "General medicine (qualifier value)"
* type[+].coding = $sct#22232009 "Hospital (environment)"
* name = "Spital X"
* alias[+] = "Spital X" // TODO: can we deduplicate the value?
* telecom[+].system = #fax
* telecom[=].value = "+41 71 111 22 99"
* telecom[+].system = #phone
* telecom[=].value = "+41 71 111 22 33"
* address[+].use = #work
* address[=].line[+] = "Spital X"
* address[=].line[+] = "95 Rorschacher Strasse"
* address[=].city = "St. Gallen"
* address[=].state = "SG"
* address[=].postalCode = "9007"
* address[=].country = "CH"
// TODO: should we distinguish between hpdProviderMailingAddress, hpdProviderLegalAddress, hpdProviderPracticeAddress
// and hpdProviderBillingAddress?
// TODO: hpdProviderLanguageSupported = de, fr, en, it
// TODO: HcOrganizationCertificates = ...
// TODO: HcSigningCertificate = ...
// TODO: from example, 'description', 'name' and 'distinguishedName' are not present in EPD_ZAD_HPD_Attributes.xlsx
