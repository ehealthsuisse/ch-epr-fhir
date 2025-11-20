// Server Actor for ITI-90
Instance: CH.mCSD.Directory
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-fhir/CapabilityStatement/CH.mCSD.Directory"
* name = "CH_mCSD_Directory"
* title = "mCSD Directory (server)"
* status = #active
* experimental = false
* date = "2024-03-18"
* description = "CapabilityStatement for Server Actor in the IHE IT Infrastructure Technical Framework Supplement IHE mCSD."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest
  * mode = #server
  * documentation = "IHE ITI mCSD ITI-90 & ITI-130 endpoints"
  * interaction[+].code = #transaction
  * resource[+]
    * type = #Organization
    * profile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.Organization"
    * interaction[+].code = #create
    * interaction[+].code = #update
    * interaction[+].code = #delete
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * versioning = #no-version
    * searchInclude = "Organization.endpoint"
    * searchRevInclude[0] = "Location:organization"
    * searchRevInclude[+] = "OrganizationAffiliation:participating-organization"
    * searchRevInclude[+] = "OrganizationAffiliation:primary-organization"
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "identifier"
      * type = #token
    * searchParam[+]
      * name = "name"
      * type = #string
    * searchParam[+]
      * name = "name:contains"
      * type = #string
    * searchParam[+]
      * name = "name:exact"
      * type = #string
    * searchParam[+]
      * name = "partof"
      * type = #reference
    * searchParam[+]
      * name = "type"
      * type = #token
  * resource[+]
    * type = #Practitioner
    * profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.Practitioner"
    * interaction[+].code = #create
    * interaction[+].code = #update
    * interaction[+].code = #delete
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * versioning = #no-version
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "identifier"
      * type = #token
    * searchParam[+]
      * name = "name"
      * type = #string
    * searchParam[+]
      * name = "name:contains"
      * type = #string
    * searchParam[+]
      * name = "name:exact"
      * type = #string
    * searchParam[+]
      * name = "given"
      * type = #string
    * searchParam[+]
      * name = "given:contains"
      * type = #string
    * searchParam[+]
      * name = "given:exact"
      * type = #string
    * searchParam[+]
      * name = "family"
      * type = #string
    * searchParam[+]
      * name = "family:contains"
      * type = #string
    * searchParam[+]
      * name = "family:exact"
      * type = #string
  * resource[+]
    * type = #PractitionerRole
    * profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.PractitionerRole"
    * interaction[+].code = #create
    * interaction[+].code = #update
    * interaction[+].code = #delete
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * versioning = #no-version
    * searchInclude = "PractitionerRole:practitioner"
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "location"
      * type = #reference
    * searchParam[+]
      * name = "organization"
      * type = #reference
    * searchParam[+]
      * name = "role"
      * type = #token
    * searchParam[+]
      * name = "service"
      * type = #reference
    * searchParam[+]
      * name = "specialty"
      * type = #token
  // Global search parameters
  * searchParam[+]
    * name = "_id"
    * type = #token
  * searchParam[+]
    * name = "_lastUpdated"
    * type = #token
    * documentation = "The values for this shall support these prefixes: ge and le"


// Client Actor for ITI-90
Instance: CH.mCSD.QueryClient
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-fhir/CapabilityStatement/CH.mCSD.QueryClient"
* name = "CH_mCSD_Query_Client"
* title = "mCSD Query Client (client)"
* status = #active
* experimental = false
* date = "2024-03-18"
* description = "CapabilityStatement for Client Actor in the IHE IT Infrastructure Technical Framework Supplement IHE mCSD."
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest
  * mode = #client
  * documentation = "IHE ITI mCSD ITI-90 endpoint"
  * resource[+]
    * type = #Organization
    * profile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.Organization"
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * versioning = #no-version
    * searchInclude = "Organization.endpoint"
    * searchRevInclude[+] = "Location:organization"
    * searchRevInclude[+] = "OrganizationAffiliation:participating-organization"
    * searchRevInclude[+] = "OrganizationAffiliation:primary-organization"
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "identifier"
      * type = #token
    * searchParam[+]
      * name = "name"
      * type = #string
    * searchParam[+]
      * name = "name:contains"
      * type = #string
    * searchParam[+]
      * name = "name:exact"
      * type = #string
    * searchParam[+]
      * name = "partof"
      * type = #reference
    * searchParam[+]
      * name = "type"
      * type = #token
  * resource[+]
    * type = #Practitioner
    * profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.Practitioner"
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * versioning = #no-version
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "identifier"
      * type = #token
    * searchParam[+]
      * name = "name"
      * type = #string
    * searchParam[+]
      * name = "name:contains"
      * type = #string
    * searchParam[+]
      * name = "name:exact"
      * type = #string
    * searchParam[+]
      * name = "given"
      * type = #string
    * searchParam[+]
      * name = "given:contains"
      * type = #string
    * searchParam[+]
      * name = "given:exact"
      * type = #string
    * searchParam[+]
      * name = "family"
      * type = #string
    * searchParam[+]
      * name = "family:contains"
      * type = #string
    * searchParam[+]
      * name = "family:exact"
      * type = #string
  * resource[+]
    * type = #PractitionerRole
    * profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.PractitionerRole"
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * versioning = #no-version
    * searchInclude = "PractitionerRole:practitioner"
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "location"
      * type = #reference
    * searchParam[+]
      * name = "organization"
      * type = #reference
    * searchParam[+]
      * name = "role"
      * type = #token
    * searchParam[+]
      * name = "service"
      * type = #reference
    * searchParam[+]
      * name = "specialty"
      * type = #token
  // Global search parameters
  * searchParam[+]
    * name = "_id"
    * type = #token
  * searchParam[+]
    * name = "_lastUpdated"
    * type = #token
    * documentation = "The values for this shall support these prefixes: ge and le"


// Client Actor for ITI-130
Instance: CH.mCSD.DataSource
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-fhir/CapabilityStatement/CH.mCSD.DataSource"
* name = "CH_mCSD_Data_Source"
* title = "mCSD Data Source (client)"
* status = #active
* experimental = false
* date = "2024-03-18"
* description = "CapabilityStatement for Data Source Actor in the IHE IT Infrastructure Technical Framework Supplement IHE mCSD."
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest
  * mode = #client
  * documentation = "IHE ITI mCSD ITI-130 endpoint"
  * interaction[+].code = #transaction
  * resource[+]
    * type = #Organization
    * profile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.Organization"
    * interaction[+].code = #create
    * interaction[+].code = #update
    * interaction[+].code = #delete
    * versioning = #no-version
  * resource[+]
    * type = #Practitioner
    * profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.Feed.Practitioner"
    * interaction[+].code = #create
    * interaction[+].code = #update
    * interaction[+].code = #delete
    * versioning = #no-version
  * resource[+]
    * type = #PractitionerRole
    * profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/CH.mCSD.PractitionerRole"
    * interaction[+].code = #create
    * interaction[+].code = #update
    * interaction[+].code = #delete
    * versioning = #no-version