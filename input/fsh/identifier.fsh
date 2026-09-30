Profile: OidIdentifier
Parent: Identifier
Id: OidIdentifier
Title: "Oid Identifier"
Description: "Identifier with an oid"
* ^url = "http://fhir.ch/ig/ch-health-dossier/StructureDefinition/OidIdentifier"
* system 1..
* system = "urn:ietf:rfc:3986" (exactly)
* value 1..
* value obeys oid-start

Invariant:   oid-start
Description: "This value must start with `urn:oid:`"
Expression:  "value.startsWith('urn:oid:')"
Severity:    #error


Profile: DicomStudyInstanceUidIdentifier
Parent: Identifier
Id: DicomStudyInstanceUidIdentifier
Title: "DICOM Study Instance UID"
Description: "Identifier [representation](https://www.hl7.org/fhir/imagingstudy.html#notes) of DICOM Study Instance UID "
* ^url = "http://fhir.ch/ig/ch-health-dossier/StructureDefinition/DicomStudyInstanceUidIdentifier"
* system 1..
* system = "urn:dicom:uid" (exactly)
* value 1..
* value obeys oid-start