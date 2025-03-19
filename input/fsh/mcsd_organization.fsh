Profile: CHmCSDOrganization
Parent: http://fhir.ch/ig/ch-core/StructureDefinition/ch-core-organization-epr
Id: CH.mCSD.Organization
Title: "CH mCSD Organization"
Description: "CH mCSD profile on Organization"
* obeys ch-mcsd-organization-ihe-conformance
* identifier contains OID 1..1 and HpdUid 1..1
* identifier[OID] only OidIdentifier
* identifier[OID] ^short = "The OID of the organization in the community"
* identifier[HpdUid] only HpdUidIdentifier
* identifier[HpdUid] ^short = "UID (unique identifier) of the practitioner stored in an HPD"
* identifier.extension contains HcIdentifierStatusExtension named status 0..1   // if not present, assume status "active"
* name.extension contains HcOrganizationRegisteredNamesExtension named registeredName 0..*
* extension contains HpdProviderCreationTimeExtension named creationTime 1..1 and
        HcOrganizationCommunicationLanguageExtension named languagesSupported 0..* and
        HcOrganizationSpecialisationExtension named specialisation 0..* and
        HcOrganizationOwnerOfExtension named ownerOf 0..*
* telecom[email] 0..1 
* partOf.extension contains HcOrganizationMemberOfExtension named memberOf 1..1


Invariant: ch-mcsd-organization-ihe-conformance
Description: "The Organization needs to conform to IHE.mCSD.Organization"
Expression: "conformsTo('https://profiles.ihe.net/ITI/mCSD/StructureDefinition/IHE.mCSD.Organization')"
Severity: #error


Mapping:  CHmCSDOrganizationToHCProfessional
Source:   CHmCSDOrganization
Target:   "https://www.bag.admin.ch/epra"
Title:    "HPD schema (DSMLv2/LDAP)"
* -> "HCRegulatedOrganization"
* identifier -> "HCRegulatedOrganization.uid"
* identifier -> "HCRegulatedOrganization.hcIdentifier"
* name -> "HCRegulatedOrganization.hcRegisteredName"
* name.extension[registeredName] -> "HCRegulatedOrganization.hcRegisteredName"
* alias -> "HCRegulatedOrganization.O"
* type -> "HCRegulatedOrganization.businessCategory"
* active -> "HCRegulatedOrganization.hpdProviderStatus"
* contact.address -> "HCRegulatedOrganization.hpdProviderPracticeAddress"
* contact.address -> "HCRegulatedOrganization.hpdProviderBillingAddress"
* contact.address -> "HCRegulatedOrganization.hpdProviderMailingAddress"
* extension[languagesSupported] -> "HCRegulatedOrganization.hpdProviderLanguageSupported"
* type -> "HCRegulatedOrganization.HcSpecialisation"
* telecom -> "HCRegulatedOrganization.telephoneNumber"
* telecom -> "HCRegulatedOrganization.facsimileTelephoneNumber"
* partOf -> "HCRegulatedOrganization.memberOf"
* partOf.extension[memberOf] -> "Relationship.cn"
* extension[creationTime] -> "HCRegulatedOrganization.createTimestamp"
* meta.lastUpdated -> "HCRegulatedOrganization.modifyTimestamp"
* address -> "HCRegulatedOrganization.hpdProviderLegalAddress"
* contact.telecom -> "HCRegulatedOrganization.hpdMedicalRecordsDeliveryEmailAddress"
* extension[ownerOf] -> "Relationship.cn"


Instance: ChmCSDOrganizationCommunityA
InstanceOf: CHmCSDOrganization
Title: "CH mCSD Organization Community A"
Description: "An example of CHmCSDOrganization that contains the same information as Community A in the Swiss examples
(uid=CommunityA,OU=CHCommunity,DC=CPI,O=BAG,C=ch)"
* id = "CommunityA"
* identifier[HpdUid].system = "urn:ietf:rfc:4514"
* identifier[HpdUid].value = "CommunityA"
* identifier[OID].system = "urn:ietf:rfc:3986"
* identifier[OID].value = "urn:oid:2.16.10.89"
* active = true
* type[+].coding = http://terminology.hl7.org/CodeSystem/organization-type#cg "Community Group"
* name = "Community A"
* extension[creationTime].valueDateTime = "2025-03-17T16:37:20+01:00"


Instance: CHmCSDOrganizationSpitalX
InstanceOf: CHmCSDOrganization
Title: "CH mCSD Organization Spital X"
Description: "An example of CHmCSDOrganization that contains the same information as Spital X in the Swiss examples
(uid=CommunityA:00000001000,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch)"
* id = "SpitalX"
* identifier[HpdUid].system = "urn:ietf:rfc:4514"
* identifier[HpdUid].value = "CommunityA:00000001000"
* identifier[OID].system = "urn:ietf:rfc:3986"
* identifier[OID].value = "urn:oid:2.16.10.89.201"
* active = true
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
* extension[languagesSupported][+].valueCodeableConcept.coding = $bcp47#de
* extension[languagesSupported][+].valueCodeableConcept.coding = $bcp47#fr
* extension[languagesSupported][+].valueCodeableConcept.coding = $bcp47#en
* extension[languagesSupported][+].valueCodeableConcept.coding = $bcp47#it
* extension[specialisation][+].valueCodeableConcept.coding = $sct#394802001 "General medicine"
* extension[creationTime].valueDateTime = "2025-03-17T16:37:20+01:00"
* extension[ownerOf][+].valueIdentifier.value = "CommunityA:SpitalXRelationship"


Instance: CHmCSDOrganizationSpitalXDept3
InstanceOf: CHmCSDOrganization
Title: "CH mCSD Organization Spital X Dept. 3"
Description: "An example of CHmCSDOrganization that contains the same information as Spital X, Dept. 3 in the Swiss
examples (uid=CommunityA:00000001004,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch)"
* id = "SpitalXDept3"
* identifier[HpdUid].system = "urn:ietf:rfc:4514"
* identifier[HpdUid].value = "CommunityA:00000001004"
* identifier[OID].system = "urn:ietf:rfc:3986"
* identifier[OID].value = "urn:oid:2.16.10.89.203"
* active = true
* extension[specialisation][+].valueCodeableConcept.coding = $sct#225728007 "Accident and Emergency department"
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
* partOf.extension[memberOf].valueIdentifier.value = "CommunityA:SpitalXRelationship"
* extension[creationTime].valueDateTime = "2025-03-17T16:37:20+01:00"
* extension[ownerOf][+].valueIdentifier.value = "CommunityA:SpitalXDept3Relationship"


Instance: CHmCSDOrganizationPraxisP
InstanceOf: CHmCSDOrganization
Title: "CH mCSD Organization Praxis P"
Description: "An example of CHmCSDOrganization that contains the same information as Praxis P in the Swiss
examples (uid=CommunityA:00000001001,OU=HCRegulatedOrganization,DC=HPD,O=BAG,C=ch)"
* id = "PraxisP"
* identifier[HpdUid].system = "urn:ietf:rfc:4514"
* identifier[HpdUid].value = "CommunityA:00000001001"
* identifier[OID].system = "urn:ietf:rfc:3986"
* identifier[OID].value = "urn:oid:2.16.10.89.210"
* active = true
* type[+].coding = $sct#35971002 "Ambulatory care site"
* extension[specialisation][+].valueCodeableConcept.coding = $sct#394802001 "General medicine"
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
* extension[creationTime].valueDateTime = "2025-03-17T16:37:20+01:00"
* extension[ownerOf][+].valueIdentifier.value = "CommunityA:PraxisPRelationship"
