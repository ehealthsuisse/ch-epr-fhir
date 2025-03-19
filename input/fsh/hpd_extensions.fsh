Extension: HcIdentifierStatusExtension
Id: HcIdentifierStatusExtension
Title: "HcIdentifierStatusExtension"
Description: "Extension for hcIdentifier status"
Context: Practitioner.identifier, Organization.identifier
* ^status = #active
* ^experimental = false
* value[x] only code
* value[x] from HcIdentifierStatusCodesVS (required)

Extension: HcProfessionalInactivityReasonExtension
Id: HcProfessionalInactivityReasonExtension
Title: "HcProfessionalInactivityReasonExtension"
Description: "Extension for specifying the reason of a Practitioner's inactivity"
Context: Practitioner.active
* ^status = #active
* ^experimental = false
* value[x] only code
* value[x] from HcProfessionalInactivityReasonCodesVS (required)

Extension: HcProfessionalInitialsExtension
Id: HcProfessionalInitialsExtension
Title: "HcProfessionalInitialsExtension"
Description: "Extension for specifying a Practitioner's initials"
Context: Practitioner.name
* ^status = #active
* ^experimental = false
* value[x] only string

Extension: HpdProviderCreationTimeExtension
Id: HpdProviderCreationTimeExtension
Title: "HpdProviderCreationTimeExtension"
Description: "Extension for specifying a provider's creation time"
Context: Practitioner, Organization
* ^status = #active
* ^experimental = false
* value[x] only dateTime

Extension: HcProfessionalPhysicalDeliveryOfficeNameExtension
Id: HcProfessionalPhysicalDeliveryOfficeNameExtension
Title: "HcProfessionalPhysicalDeliveryOfficeNameExtension"
Description: "Extension for specifying a Practitioner's physical delivery office name"
Context: Practitioner
* ^status = #active
* ^experimental = false
* value[x] only string

Extension: HcProfessionalAssistantToExtension
Id: HcProfessionalAssistantToExtension
Title: "HcProfessionalAssistantToExtension"
Description: "Extension for specifying whom a given Practitioner may assist"
Context: Practitioner
* ^status = #active
* ^experimental = false
* value[x] only Reference(Practitioner)

Extension: HcProfessionalMedicalRecordsDeliveryEmailAddressExtension
Id: HcProfessionalMedicalRecordsDeliveryEmailAddressExtension
Title: "HcProfessionalMedicalRecordsDeliveryEmailAddressExtension"
Description: "Extension for specifying a Medical Records Delivery Email Address of a Practitioner"
Context: Practitioner
* ^status = #active
* ^experimental = false
* value[x] only string

Extension: HpdProviderPostalAddressStatusExtension
Id: HpdProviderPostalAddressStatusExtension
Title: "HpdProviderPostalAddressStatusExtension"
Description: "Extension for specifying the status of a postal address"
Context: Practitioner.address, Organization.contact.address
* ^status = #active
* ^experimental = false
* value[x] only code
* value[x] from HpdProviderPostalAddressStatusCodesVS (required)

Extension: HcOrganizationRegisteredNamesExtension
Id: HcOrganizationRegisteredNamesExtension
Title: "HcOrganizationRegisteredNamesExtension"
Description: "Extension for specifying multiple official names of an Organization"
Context: Organization.name
* ^status = #active
* ^experimental = false
* value[x] only string

Extension: HcOrganizationCommunicationLanguageExtension
Id: HcOrganizationCommunicationLanguageExtension
Title: "HcOrganizationCommunicationLanguageExtension"
Description: "Human languages spoken and understood in an Organization"
Context: Organization
* ^status = #active
* ^experimental = false
* value[x] only CodeableConcept
* value[x] from CommonLanguages (preferred)

Extension: HcOrganizationSpecialisationExtension
Id: HcOrganizationSpecialisationExtension
Title: "HcOrganizationSpecialisationExtension"
Description: "Specialization(s) of an Organization"
Context: Organization
* ^status = #active
* ^experimental = false
* value[x] only CodeableConcept
* value[x] from http://fhir.ch/ig/ch-term/ValueSet/DocumentEntry.practiceSettingCode (required)

Extension: HcOrganizationMemberOfExtension
Id: HcOrganizationMemberOfExtension
Title: "HcOrganizationMemberOfExtension"
Description: "CN of the HPD Relationship where the given Organization is a member"
Context: Organization.partOf
* ^status = #active
* ^experimental = false
* value[x] only HpdUidIdentifier

Extension: HcOrganizationOwnerOfExtension
Id: HcOrganizationOwnerOfExtension
Title: "HcOrganizationOwnerOfExtension"
Description: "CN of the HPD Relationship where the given Organization is an owner"
Context: Organization
* ^status = #active
* ^experimental = false
* value[x] only HpdUidIdentifier

