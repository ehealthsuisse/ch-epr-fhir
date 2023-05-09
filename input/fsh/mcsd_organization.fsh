Profile: CHmCSDOrganization
Parent: Organization
Id: CH.mCSD.Organization
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
* id = "SpitalX"
* identifier[+].value = "uid=CommunityA:00000001000,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch"
* identifier[+].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:oid:2.16.10.89.201"
* active = true
* type[+].coding = $sct#394802001 "General medicine"
* type[+].coding = $sct#22232009 "Hospital"
* name = "Spital X"
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
// TODO: from example, 'description', 'name' and 'distinguishedName' are not present in EPD_ZAD_HPD_Attributes.xlsx


Instance: CHmCSDOrganizationSpitalXDept3
InstanceOf: CHmCSDOrganization
Title: "CH mCSD Organization Spital X Dept. 3"
Description: "An exemple of CHmCSDOrganization that contains the same information as Spital X, Dept. 3 in the Swiss
examples (uid=CommunityA:00000001004,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch)"
* id = "SpitalXDept3"
* identifier[+].value = "uid=CommunityA:00000001004,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch"
* identifier[+].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:oid:2.16.10.89.203"
* active = true
* type[+].coding = $sct#394576009 "Accident & emergency"
* type[+].coding = $sct#22232009 "Hospital"
* name = "Dept. 3"
* telecom[+].system = #fax
* telecom[=].value = "+41 71 111 22 27"
* telecom[+].system = #phone
* telecom[=].value = "+41 71 111 22 19"
* address[+].use = #work
* address[=].line[+] = "Spital X - Medicina d'urgenza e di salvataggio"
* address[=].line[+] = "95 Rorschacher Strasse"
* address[=].city = "St. Gallen"
* address[=].state = "SG"
* address[=].postalCode = "9007"
* address[=].country = "CH"
* partOf = Reference(CHmCSDOrganizationSpitalX)


Instance: CHmCSDOrganizationPraxisP
InstanceOf: CHmCSDOrganization
Title: "CH mCSD Organization Praxis P"
Description: "An exemple of CHmCSDOrganization that contains the same information as Praxis P in the Swiss
examples (uid=CommunityA:00000001001,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch)"
* id = "PraxisP"
* identifier[+].value = "uid=CommunityA:00000001001,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch"
* identifier[+].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:oid:2.16.10.89.210"
* active = true
* type[+].coding = $sct#35971002 "Ambulatory care site"
* type[+].coding = $sct#394802001 "General medicine"
* name = "Praxis P"
* telecom[+].system = #fax
* telecom[=].value = "+41 71 271 22 99"
* telecom[+].system = #phone
* telecom[=].value = "+41 71 271 22 33"
* address[+].use = #work
* address[=].line[+] = "Praxis P"
* address[=].line[+] = "47 Langgasse"
* address[=].city = "St. Gallen"
* address[=].state = "SG"
* address[=].postalCode = "9000"
* address[=].country = "CH"
