CodeSystem: HcIdentifierStatusCodes
Title: "HcIdentifierStatusCodes"
Description: "Status Codes for the hcIdentifier attribute"
* ^status = #active
* ^experimental = false
* #active
* #inactive
* #revoked
* #suspended

ValueSet: HcIdentifierStatusCodesVS
Title: "HcIdentifierStatusCodesVS"
Description: "ValueSet of status Codes for the hcIdentifier attribute"
* ^experimental = false
* ^status = #active
* include codes from system HcIdentifierStatusCodes

CodeSystem: HcProfessionalInactivityReasonCodes
Title: "HcProfessionalInactivityReasonCodes"
Description: "Codes to represent HPD HCProfessional status codes 'retired' and 'deceased'"
* ^status = #active
* ^experimental = false
* #retired
* #deceased

ValueSet: HcProfessionalInactivityReasonCodesVS
Title: "HcProfessionalInactivityReasonCodesVS"
Description: "ValueSet of codes to represent HPD HCProfessional status codes 'retired' and 'deceased'"
* ^experimental = false
* ^status = #active
* include codes from system HcProfessionalInactivityReasonCodes

CodeSystem: HpdProviderPostalAddressStatusCodes
Title: "HpdProviderPostalAddressStatusCodes"
Description: "Postal address Status codes"
* ^status = #active
* ^experimental = false
* #primary
* #secondary

ValueSet: HpdProviderPostalAddressStatusCodesVS
Title: "HpdProviderPostalAddressStatusCodesVS"
Description: "ValueSet of postal address status codes"
* ^experimental = false
* ^status = #active
* include codes from system HpdProviderPostalAddressStatusCodes
