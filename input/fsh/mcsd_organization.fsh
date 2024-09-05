Profile: CHmCSDOrganization
Parent: http://fhir.ch/ig/ch-core/StructureDefinition/ch-core-organization-epr
Id: CH.mCSD.Organization
Title: "CH mCSD Organization"
Description: "CH mCSD profile on Organization"
* obeys ch-mcsd-organization-ihe-conformance
* identifier 1..
* identifier contains OID 0..1 and LDAP 0..1
* identifier[OID] only OidIdentifier
* identifier[OID] ^short = "The OID of the organization in the community"
* identifier[OID] ^patternIdentifier.system = "urn:ietf:rfc:3986"
* identifier[LDAP] only LdapIdentifier
* identifier[LDAP] ^short = "LDAP DN (Distinguished Name), if the organization is stored in an HPD"
* identifier[LDAP] ^patternIdentifier.system = "urn:ietf:rfc:4514"



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
* name -> "HCRegulatedOrganization.O"
* alias -> "HCRegulatedOrganization.O"
* name -> "HCRegulatedOrganization.hcRegisteredName"
* alias -> "HCRegulatedOrganization.hcRegisteredName"
* type -> "HCRegulatedOrganization.businessCategory"
* active -> "HCRegulatedOrganization.hpdProviderStatus"
* address -> "HCRegulatedOrganization.hpdProviderPracticeAddress"
* contact.address -> "HCRegulatedOrganization.hpdProviderBillingAddress"
* contact.address -> "HCRegulatedOrganization.hpdProviderMailingAddress"
* type -> "HCRegulatedOrganization.HcSpecialisation"
* telecom -> "HCRegulatedOrganization.telephoneNumber"
* telecom -> "HCRegulatedOrganization.facsimileTelephoneNumber"
* partOf -> "HCRegulatedOrganization.memberOf"
* meta.lastUpdated -> "HCRegulatedOrganization.modifyTimestamp"
* contact.address -> "HCRegulatedOrganization.hpdProviderLegalAddress"
* contact.telecom -> "HCRegulatedOrganization.hpdMedicalRecordsDeliveryEmailAddress"


Instance: ChmCSDOrganizationCommunityA
InstanceOf: CHmCSDOrganization
Title: "CH mCSD Organization Community A"
Description: "An example of CHmCSDOrganization that contains the same information as Community A in the Swiss examples
(uid=CommunityA,OU=CHCommunity,DC=CPI,O=BAG,C=ch)"
* id = "CommunityA"
* identifier[LDAP].system = "urn:ietf:rfc:4514"
* identifier[LDAP].value = "uid=CommunityA,OU=CHCommunity,DC=CPI,O=BAG,C=ch"
* identifier[OID].system = "urn:ietf:rfc:3986"
* identifier[OID].value = "urn:oid:2.16.10.89"
* active = true
* type[+].coding = http://terminology.hl7.org/CodeSystem/organization-type#cg "Community Group"
* name = "Community A"


Instance: CHmCSDOrganizationSpitalX
InstanceOf: CHmCSDOrganization
Title: "CH mCSD Organization Spital X"
Description: "An example of CHmCSDOrganization that contains the same information as Spital X in the Swiss examples
(uid=CommunityA:00000001000,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch)"
* id = "SpitalX"
* identifier[LDAP].system = "urn:ietf:rfc:4514"
* identifier[LDAP].value = "uid=CommunityA:00000001000,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch"
* identifier[OID].system = "urn:ietf:rfc:3986"
* identifier[OID].value = "urn:oid:2.16.10.89.201"
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


Instance: CHmCSDOrganizationSpitalXDept3
InstanceOf: CHmCSDOrganization
Title: "CH mCSD Organization Spital X Dept. 3"
Description: "An example of CHmCSDOrganization that contains the same information as Spital X, Dept. 3 in the Swiss
examples (uid=CommunityA:00000001004,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch)"
* id = "SpitalXDept3"
* identifier[LDAP].system = "urn:ietf:rfc:4514"
* identifier[LDAP].value = "uid=CommunityA:00000001004,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch"
* identifier[OID].system = "urn:ietf:rfc:3986"
* identifier[OID].value = "urn:oid:2.16.10.89.203"
* active = true
* type[+].coding = $sct#225728007 "Accident and Emergency department"
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
Description: "An example of CHmCSDOrganization that contains the same information as Praxis P in the Swiss
examples (uid=CommunityA:00000001001,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch)"
* id = "PraxisP"
* identifier[LDAP].system = "urn:ietf:rfc:4514"
* identifier[LDAP].value = "uid=CommunityA:00000001001,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch"
* identifier[OID].system = "urn:ietf:rfc:3986"
* identifier[OID].value = "urn:oid:2.16.10.89.210"
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
