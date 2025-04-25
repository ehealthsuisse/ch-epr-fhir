Profile: OidIdentifier
Parent: Identifier
Id: OidIdentifier
Title: "Oid Identifier"
Description: "Identifier with an oid"
* ^url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/OidIdentifier"
* system 1..
* system = "urn:ietf:rfc:3986" (exactly)
* value 1..
* value obeys oid-start

Invariant:   oid-start
Description: "This value must start with `urn:oid:`"
Expression:  "value.startsWith('urn:oid:')"
Severity:    #error

Profile: LdapIdentifier
Parent: Identifier
Id: LdapIdentifier
Title: "LDAP Identifier"
Description: "Identifier with an LDAP DN"
* ^url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/LdapIdentifier"
* system 1..
* system = "urn:ietf:rfc:4514" (exactly)
* value 1..


Profile: DicomStudyInstanceUidIdentifier
Parent: Identifier
Id: DicomStudyInstanceUidIdentifier
Title: "DICOM Study Instance UID"
Description: "Identifier [representation](https://www.hl7.org/fhir/imagingstudy.html#notes) of DICOM Study Instance UID "
* ^url = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/DicomStudyInstanceUidIdentifier"
* system 1..
* system = "urn:dicom:uid" (exactly)
* value 1..
* value obeys oid-start