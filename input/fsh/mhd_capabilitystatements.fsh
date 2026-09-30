Instance: CH.MHD.DocumentConsumer
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-health-dossier/CapabilityStatement/CH.MHD.DocumentConsumer"
* name = "CH_MHD_DocumentConsumer"
* title = "MHD Document Consumer (client)"
* status = #active
* date = "2020-07-08"
* publisher = "eHealth Suisse"
* contact.name = "eHealth Suisse"
* contact.telecom.system = #url
* contact.telecom.value = "https://www.e-health-suisse.ch"
* description = "CapabilityStatement for Actor MHD Document Consumer (client)."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #client
* rest.documentation = "MHD client requests a list of DocumentReference Resources, matching the supplied set of criteria, from the Document Responder [ITI-67]. MHD client requests a document from the Document Responder [ITI-68]."
* rest.security.cors = false
* rest.security.description = "TLS SHALL be used together with IUA extended access token"
* rest.resource[0].type = #DocumentReference
* rest.resource[=].profile = "http://fhir.ch/ig/ch-health-dossier/StructureDefinition/ch-mhd-documentreference"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].searchParam[0].name = "_id"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Logical id of this artifact"
* rest.resource[=].searchParam[+].name = "_lastUpdated"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "When the resource version last changed"
* rest.resource[=].searchParam[+].name = "author"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-author"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Who and/or what authored the document"
* rest.resource[=].searchParam[+].name = "category"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-category"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Categorization of document"
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "When this document reference was created"
* rest.resource[=].searchParam[+].name = "event"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-event"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Main clinical acts documented"
* rest.resource[=].searchParam[+].name = "facility"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-facility"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Kind of facility where patient was seen"
* rest.resource[=].searchParam[+].name = "format"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-format"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Format/content rules for the document"
* rest.resource[=].searchParam[+].name = "full-text"
* rest.resource[=].searchParam[=].definition = "https://profiles.ihe.net/ITI/MHD/SearchParameter/DocumentReference-Full-Text-Search"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].documentation = "Searches the textual content of the document (Full-Text Search Option)"
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "The identifier for this DocumentReference"
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Who/what is the subject of the document"
* rest.resource[=].searchParam[+].name = "period"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-period"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "Time of service that is being documented"
* rest.resource[=].searchParam[+].name = "related"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-related"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Related Resource"
* rest.resource[=].searchParam[+].name = "security-label"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-security-label"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Document security-tags"
* rest.resource[=].searchParam[+].name = "setting"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-setting"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Additional details about where the content was created (e.g. clinical specialty)"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "current | superseded | entered-in-error"
* rest.resource[=].searchParam[+].name = "type"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-type"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Kind of document (LOINC if possible)"
* rest.resource[+].type = #Binary
* rest.resource[=].interaction.code = #read
* rest.interaction.code = #search-system

Instance: CH.MHD.DocumentResponder
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-health-dossier/CapabilityStatement/CH.MHD.DocumentResponder"
* name = "CH_MHD_DocumentResponder"
* title = "MHD Document Responder (server)"
* status = #active
* date = "2020-07-08"
* publisher = "eHealth Suisse"
* contact.name = "eHealth Suisse"
* contact.telecom.system = #url
* contact.telecom.value = "https://www.e-health-suisse.ch"
* description = "CapabilityStatement for Actor MHD Document Responder (server)."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #server
* rest.documentation = "MHD server returns DocumentReference Resources that match the search criteria provided by the Document Consumer [ITI-67]. MHD supports update of DocumentReference Resources by the Document Source [CH:MHD-1] and the purge of documents by the Document Source [CH:MHD-2]. MHD server serves the document to the Document Consumer [ITI-68]."
* rest.security.cors = false
* rest.security.description = "TLS SHALL be used together with IUA extended access token"
* rest.resource[0].type = #DocumentReference
* rest.resource[=].profile = "http://fhir.ch/ig/ch-health-dossier/StructureDefinition/ch-mhd-documentreference"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].operation[0].name = "purge"
* rest.resource[=].operation[=].definition = "http://fhir.ch/ig/ch-health-dossier/OperationDefinition/CHMhdPurge"
* rest.resource[=].operation[=].documentation = "Purge Document [CH:MHD-2]"
* rest.resource[=].searchParam[0].name = "_id"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Logical id of this artifact"
* rest.resource[=].searchParam[+].name = "_lastUpdated"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "When the resource version last changed"
* rest.resource[=].searchParam[+].name = "author"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-author"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Who and/or what authored the document"
* rest.resource[=].searchParam[+].name = "category"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-category"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Categorization of document"
* rest.resource[=].searchParam[+].name = "event"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-event"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Main clinical acts documented"
* rest.resource[=].searchParam[+].name = "facility"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-facility"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Kind of facility where patient was seen"
* rest.resource[=].searchParam[+].name = "format"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-format"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Format/content rules for the document"
* rest.resource[=].searchParam[+].name = "full-text"
* rest.resource[=].searchParam[=].definition = "https://profiles.ihe.net/ITI/MHD/SearchParameter/DocumentReference-Full-Text-Search"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].documentation = "Searches the textual content of the document (Full-Text Search Option)"
* rest.resource[=].searchParam[+].name = "creation"
* rest.resource[=].searchParam[=].definition = "https://profiles.ihe.net/ITI/MHD/SearchParameter/DocumentReference-Creation"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "When this document was created"
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "When this document reference was created"
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "The identifier for this DocumentReference"
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Who/what is the subject of the document"
* rest.resource[=].searchParam[+].name = "period"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-period"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "Time of service that is being documented"
* rest.resource[=].searchParam[+].name = "related"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-related"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Related Resource"
* rest.resource[=].searchParam[+].name = "security-label"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-security-label"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Document security-tags"
* rest.resource[=].searchParam[+].name = "setting"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-setting"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Additional details about where the content was created (e.g. clinical specialty)"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "current | superseded | entered-in-error"
* rest.resource[=].searchParam[+].name = "type"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-type"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Kind of document (LOINC if possible)"
* rest.resource[+].type = #Binary
* rest.resource[=].interaction.code = #read
* rest.interaction.code = #search-system


Instance: CH.MHD.DocumentRecipient
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-health-dossier/CapabilityStatement/CH.MHD.DocumentRecipient"
* name = "CH_MHD_DocumentRecipient"
* title = "MHD Document Recipient (server)"
* status = #active
* date = "2020-07-08"
* publisher = "eHealth Suisse"
* contact.name = "eHealth Suisse"
* contact.telecom.system = #url
* contact.telecom.value = "https://www.e-health-suisse.ch"
* description = "CapabilityStatement for Actor MHD Document Recipient (server)."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #server
* rest.documentation = "MHD server accepts the document and metadata sent from the Document Source [ITI-65]."
* rest.security.cors = false
* rest.security.description = "TLS SHALL be used together with IUA extended access token"
* rest.interaction.code = #transaction
* rest.interaction.documentation = "http://fhir.ch/ig/ch-health-dossier/StructureDefinition/ch-mhd-providedocumentbundle"

Instance: CH.MHD.DocumentSource
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-health-dossier/CapabilityStatement/CH.MHD.DocumentSource"
* name = "CH_MHD_DocumentSource"
* title = "MHD Document Source (client)"
* status = #active
* date = "2020-07-07"
* publisher = "eHealth Suisse"
* contact.name = "eHealth Suisse"
* contact.telecom.system = #url
* contact.telecom.value = "https://www.e-health-suisse.ch"
* description = "CapabilityStatement for Actor MHD Document Source (client)."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #client
* rest.documentation = "MHD client sends documents and metadata to the Document Recipient [ITI-65]. MHD client updates document metadata [CH:MHD-1] and purges documents [CH:MHD-2] at the Document Responder."
* rest.security.cors = false
* rest.security.description = "TLS SHALL be used together with IUA extended access token"
* rest.interaction.code = #transaction
* rest.interaction.documentation = "http://fhir.ch/ig/ch-health-dossier/StructureDefinition/ch-mhd-providedocumentbundle"
* rest.resource[0].type = #DocumentReference
* rest.resource[=].profile = "http://fhir.ch/ig/ch-health-dossier/StructureDefinition/ch-mhd-documentreference"
* rest.resource[=].interaction[0].code = #update
* rest.resource[=].interaction[=].documentation = "Update Document Metadata [CH:MHD-1]"
* rest.resource[=].operation[0].name = "purge"
* rest.resource[=].operation[=].definition = "http://fhir.ch/ig/ch-health-dossier/OperationDefinition/CHMhdPurge"
* rest.resource[=].operation[=].documentation = "Purge Document [CH:MHD-2]"
