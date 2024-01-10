// Server Actor
Instance: CH.ATNA.AuditRecordRepository
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-mhealth/CapabilityStatement/CH.ATNA.AuditRecordRepository"
* name = "CH_ATNA_Audit_Record_Repository"
* title = "ATNA Audit Record Repository (server)"
* status = #active
* experimental = false
* date = "2024-01-08"
* description = "CapabilityStatement for Server Actor in the IHE IT Infrastructure Technical Framework Supplement Add RESTful ATNA."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #server
* rest.documentation = "IHE ITI ATNA ITI-20 endpoint"
* rest.resource[+].type = #AuditEvent
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].versioning = #no-version
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.FindDocumentLists.Audit.Responder"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.FindDocumentLists.Audit.Consumer"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.FindDocumentReferences.Audit.Responder"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.FindDocumentReferences.Audit.Consumer"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.ProvideBundle.Audit.Recipient"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.ProvideBundle.Audit.Source"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.RetrieveDocument.Audit.Responder"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.RetrieveDocument.Audit.Consumer"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/PIXm/StructureDefinition/IHE.PIXm.Query.Audit.Consumer"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/PIXm/StructureDefinition/IHE.PIXm.Query.Audit.Manager"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/PIXm/StructureDefinition/IHE.PIXm.Feed.Audit.Manager"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/PIXm/StructureDefinition/IHE.PIXm.Feed.Audit.Source"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/PDQm/StructureDefinition/IHE.PDQm.Query.Audit.Consumer"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/PDQm/StructureDefinition/IHE.PDQm.Query.Audit.Supplier"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/mCSD/StructureDefinition/IHE.mCSD.Audit.CareServices.Query"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/mCSD/StructureDefinition/IHE.mCSD.Audit.CareServices.Read"


// Client Actor
Instance: CH.ATNA.AuditCreator
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-mhealth/CapabilityStatement/CH.ATNA.AuditCreator"
* name = "CH_ATNA_Audit_Creator"
* title = "ATNA Audit Creator (client)"
* status = #active
* experimental = false
* date = "2024-01-08"
* description = "CapabilityStatement for Server Actor in the IHE IT Infrastructure Technical Framework Supplement Add RESTful ATNA."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #client
* rest.documentation = "IHE ITI ATNA ITI-20 endpoint"
* rest.resource[+].type = #AuditEvent
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].versioning = #no-version
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.FindDocumentLists.Audit.Responder"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.FindDocumentLists.Audit.Consumer"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.FindDocumentReferences.Audit.Responder"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.FindDocumentReferences.Audit.Consumer"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.ProvideBundle.Audit.Recipient"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.ProvideBundle.Audit.Source"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.RetrieveDocument.Audit.Responder"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.RetrieveDocument.Audit.Consumer"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/PIXm/StructureDefinition/IHE.PIXm.Query.Audit.Consumer"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/PIXm/StructureDefinition/IHE.PIXm.Query.Audit.Manager"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/PIXm/StructureDefinition/IHE.PIXm.Feed.Audit.Manager"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/PIXm/StructureDefinition/IHE.PIXm.Feed.Audit.Source"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/PDQm/StructureDefinition/IHE.PDQm.Query.Audit.Consumer"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/PDQm/StructureDefinition/IHE.PDQm.Query.Audit.Supplier"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/mCSD/StructureDefinition/IHE.mCSD.Audit.CareServices.Query"
* rest.resource[=].supportedProfile[+] = "https://profiles.ihe.net/ITI/mCSD/StructureDefinition/IHE.mCSD.Audit.CareServices.Read"
