// Server Actor
Instance: CH.ATNA.AuditRecordRepository
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-fhir/CapabilityStatement/CH.ATNA.AuditRecordRepository"
* name = "CH_ATNA_Audit_Record_Repository"
* title = "ATNA Audit Record Repository (server)"
* description = "CapabilityStatement for Server Actor in the IHE IT Infrastructure Technical Framework Supplement Add RESTful ATNA."
* rest.mode = #server
* insert CH.ATNA.AuditRules


// Client Actor
Instance: CH.ATNA.AuditCreator
InstanceOf: CapabilityStatement
Usage: #definition
* url = "http://fhir.ch/ig/ch-epr-fhir/CapabilityStatement/CH.ATNA.AuditCreator"
* name = "CH_ATNA_Audit_Creator"
* title = "ATNA Audit Creator (client)"
* description = "CapabilityStatement for Client Actor in the IHE IT Infrastructure Technical Framework Supplement Add RESTful ATNA."
* rest.mode = #client
* insert CH.ATNA.AuditRules


RuleSet: CH.ATNA.AuditRules
* status = #active
* experimental = false
* date = "2024-01-08"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest
  * documentation = "IHE ITI ATNA ITI-20 endpoint"
  * interaction[+]
    * code = #batch
    * documentation = "ITI-20 Send Audit Bundle Request Message - FHIR Feed Interaction"
  * resource[+]
    * type = #AuditEvent
    * interaction[+].code = #create
    * versioning = #no-version
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti65Recipient"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti65Source"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti67Consumer"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti67Responder"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti68Consumer"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti68Responder"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-mhd-updatedocumentmetadata-audit-responder"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-mhd-updatedocumentmetadata-audit-source"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti83Consumer"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti83Manager"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti104Source"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti104ManagerCreate"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti104ManagerUpdate"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti119Consumer"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti119Supplier"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti90Read"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti90Query"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti130Create"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti130Update"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti130Delete"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventPpq3Create"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventPpq3Update"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventPpq3Delete"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventPpq5Consumer"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventPpq5Repository"
    * supportedProfile[+] = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ChAuditEventIti81"
