// Server Actor
Instance: CH.mCSD.CareServicesSelectiveSupplier
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-fhir/CapabilityStatement/CH.mCSD.CareServicesSelectiveSupplier"
* name = "CH_mCSD_Care_Services_Selective_Supplier"
* title = "mCSD Care Services Selective Supplier (server)"
* status = #active
* experimental = false
* date = "2023-05-09"
* description = "CapabilityStatement for Server Actor in the IHE IT Infrastructure Technical Framework Supplement IHE mCSD."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #server
* rest.documentation = "IHE ITI mCSD ITI-90 endpoint"
* rest.resource[+].type = #Organization
* rest.resource[=].profile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.Organization"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].versioning = #no-version
* rest.resource[=].searchInclude = "Organization.endpoint"
* rest.resource[=].searchRevInclude[0] = "Location:organization"
* rest.resource[=].searchRevInclude[+] = "OrganizationAffiliation:participating-organization"
* rest.resource[=].searchRevInclude[+] = "OrganizationAffiliation:primary-organization"
* rest.resource[=].searchParam[0].name = "active"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "name"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "name:contains"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "name:exact"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "partof"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "type"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[+].type = #Practitioner
* rest.resource[=].profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.Practitioner"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].versioning = #no-version
* rest.resource[=].searchParam[0].name = "active"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "name"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "name:contains"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "name:exact"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "given"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "given:contains"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "given:exact"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "family"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "family:contains"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "family:exact"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[+].type = #PractitionerRole
* rest.resource[=].profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.PractitionerRole"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].versioning = #no-version
* rest.resource[=].searchInclude = "PractitionerRole:practitioner"
* rest.resource[=].searchParam[0].name = "active"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "location"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "organization"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "role"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "service"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "specialty"
* rest.resource[=].searchParam[=].type = #token
* rest.searchParam[0].name = "_id"
* rest.searchParam[=].type = #token
* rest.searchParam[+].name = "_lastUpdated"
* rest.searchParam[=].type = #token
* rest.searchParam[=].documentation = "The values for this shall support these prefixes: ge and le"


// Client Actor
Instance: CH.mCSD.CareServicesSelectiveConsumer
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-fhir/CapabilityStatement/CH.mCSD.CareServicesSelectiveConsumer"
* name = "CH_mCSD_Care_Services_Selective_Consumer"
* title = "mCSD Care Services Selective Consumer (client)"
* status = #active
* experimental = false
* date = "2023-05-09"
* description = "CapabilityStatement for Client Actor in the IHE IT Infrastructure Technical Framework Supplement IHE mCSD."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #client
* rest.documentation = "IHE ITI mCSD ITI-90 endpoint"
* rest.resource[+].type = #Organization
* rest.resource[=].profile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.Organization"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].versioning = #no-version
* rest.resource[=].searchInclude = "Organization.endpoint"
* rest.resource[=].searchRevInclude[0] = "Location:organization"
* rest.resource[=].searchRevInclude[+] = "OrganizationAffiliation:participating-organization"
* rest.resource[=].searchRevInclude[+] = "OrganizationAffiliation:primary-organization"
* rest.resource[=].searchParam[0].name = "active"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "name"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "name:contains"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "name:exact"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "partof"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "type"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[+].type = #Practitioner
* rest.resource[=].profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.Practitioner"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].versioning = #no-version
* rest.resource[=].searchParam[0].name = "active"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "name"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "name:contains"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "name:exact"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "given"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "given:contains"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "given:exact"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "family"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "family:contains"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[+].name = "family:exact"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[+].type = #PractitionerRole
* rest.resource[=].profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.PractitionerRole"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].versioning = #no-version
* rest.resource[=].searchInclude = "PractitionerRole:practitioner"
* rest.resource[=].searchParam[0].name = "active"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "location"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "organization"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "role"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "service"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "specialty"
* rest.resource[=].searchParam[=].type = #token
* rest.searchParam[0].name = "_id"
* rest.searchParam[=].type = #token
* rest.searchParam[+].name = "_lastUpdated"
* rest.searchParam[=].type = #token
* rest.searchParam[=].documentation = "The values for this shall support these prefixes: ge and le"
