Profile: OidIdentifier
Parent: Identifier
Id: OidIdentifier
Title: "Oid Identifier"
Description: "Identifer with an oid"
* ^url = "http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/OidIdentifier"
* system 1..
* system = "urn:ietf:rfc:3986" (exactly)
* value 1..
* value obeys oid-start

Invariant:   oid-start
Description: "value must start with urn:oid:"
Expression:  "value.startsWith('urn:oid:')"
Severity:    #error