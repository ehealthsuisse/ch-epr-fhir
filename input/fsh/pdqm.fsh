Profile: CHPDQmPatient
Parent: $ch-core-patient
Id: ch-pdqm-patient
Title: "CH PDQm Patient"
Description: "The patient demographics and identifier information provided in a PDQm response."
* extension[religion] 0..0
* identifier[EPR-SPID] 1..1 MS
* name MS
* name ^slicing.discriminator.type = #profile
* name ^slicing.discriminator.path = "$this"
* name ^slicing.rules = #open
* name contains
    HumanName 1..* MS and
    BirthName 0..1 MS
* name[HumanName] only $ch-epr-fhir-humanname
* name[HumanName] ^short = "A name associated with the patient"
* name[BirthName] only $ch-epr-fhir-birthname
* name[BirthName] ^short = "The birthname of the patient"
* name[BirthName] ^comment = "The birthname is added with the ISO 21090 qualifier https://www.hl7.org/fhir/extension-iso21090-en-qualifier.html BR"
* contact[nameOfParent] 0..* MS
* contact[nameOfParent].gender MS

Mapping: CHPDQmPatientEch0213
Source: CHPDQmPatient
Target: "http://www.ech.ch/xmlns/eCH-0213/1"
Title: "Mapping to CH-0213"
Description: """
Element mapping of the eCH-0213 personFromUPIType payload

Limitations of the mappings:
placeOfBirth = unknown (generalPlaceType has an explicit unknown branch), no current mapping
nationalityStatus 0 (unknown) / 1 (no nationality) no current mapping
recordTimestamp no current mapping
"""
* -> "personFromUPIType"
* identifier -> "pids UPIType (AHVN13) resp. EPR-SPID"
* name.given -> "firstName" "single token, officialFirstName; do not split"
* name.family -> "officialName"
* name[BirthName] -> "originalName"
* gender -> "sex" "via ch-term ConceptMap sex-ech11-to-fhir: 1~male, 2~female, 3~other"
* birthDate -> "dateOfBirth" "datePartiallyKnownType precision maps onto FHIR date"
* deceasedDateTime -> "dateOfDeath"
* contact[nameOfParent] -> "mothersName / fathersName"
* contact[nameOfParent].name -> "nameOfParentType (firstName and/or officialName)"
* contact[nameOfParent].gender -> "nameOfParentType"
* extension[placeOfBirth] -> "placeOfBirth" "swissTown -> city + historyMunicipalityId; foreignCountry -> country (ISO-3166) + town"
* extension[citizenship] -> "nationalityData" "ISO-3166 per ch-pat-3; only nationalityStatus 2 maps"

// https://github.com/IHE/ITI.PDQm/blob/main/input/fsh/PDQmMatch.fsh
Instance: CHPDQmMatch
InstanceOf: OperationDefinition
Title: "CH PDQm $Match"
Usage: #definition
Description: """
This operation implements the [Patient Demographics Match \[ITI-119\]](iti-119.html) transaction.
It is fully compatible with the [$match Operation on Patient](http://hl7.org/fhir/R4/patient-operation-match.html).
The only changes are to constrain the input parameters to use the [PDQm Patient Profile for $match Input](StructureDefinition-CHPDQmMatchInput.html) profile
and to constrain the output parameters to use the [PDQm Patient Profile](StructureDefinition-ch-pdqm-patient.html) profile.
"""
* base = "http://hl7.org/fhir/OperationDefinition/Patient-match"
* name = "Find_Patient_Matches_PDQm"
* status = #active
* kind = #operation
* affectsState = false
* resource = #Patient
* system = false
* type = true
* instance = false
* code = #match
* parameter[+]
  * name = #resource
  * use = #in
  * min = 1
  * max = "1"
  * documentation = "Use this to provide an entire set of patient details for the MPI to match against (e.g. POST a patient record to Patient/$match)."
  * type = #Patient
  * targetProfile[+] = Canonical(ch-pdqm-patient)
* parameter[+]
  * name = #onlyCertainMatches
  * use = #in
  * min = 0
  * max = "1"
  * documentation = "If there are multiple potential matches, then the match SHOULD not return the results with this flag set to true. When false, the server MAY return multiple results with each result graded accordingly."
  * type = #boolean
* parameter[+]
  * name = #count
  * use = #in
  * min = 0
  * max = "1"
  * documentation = "The maximum number of records to return. If no value is provided, the server decides how many matches to return. Note that clients SHOULD be careful when using this, as it MAY prevent probable - and valid - matches from being returned."
  * type = #integer
* parameter[+]
  * name = #return
  * use = #out
  * min = 1
  * max = "1"
  * documentation = "A bundle contain a set of Patient records that represent possible matches, optionally it MAY also contain an OperationOutcome with further information about the search results (such as warnings or information messages, such as a count of records that were close but eliminated) If the operation was unsuccessful, then an OperationOutcome MAY be returned along with a BadRequest status Code (e.g. security issue, or insufficient properties in patient fragment - check against profile). Note: as this is the only out parameter, it is a resource, and it has the name 'return', the result of this operation is returned directly as a resource"
  * type = #Bundle
  * targetProfile[+] = Canonical(CHPDQmMatchParametersOut)

// https://github.com/IHE/ITI.PDQm/blob/main/input/fsh/PDQmMatch.fsh
Profile: CHPDQmMatchParametersIn
Parent: https://profiles.ihe.net/ITI/PDQm/StructureDefinition/IHE.PDQm.MatchParametersIn
Title: "CH PDQm Match Input Parameters Profile"
Description: """
The PDQm Match Input Parameters Profile describes the Parameters Resource that is to be posted to the $match endpoint when invoking ITI-119.
This profile is consistent with the exceptions of the [Patient-match operation in FHIR core](http://hl7.org/fhir/R4/patient-operation-match.html),
except the input resource SHALL be an instance of the [PDQm Patient Profile for $match Input](StructureDefinition-CHPDQmMatchInput.html).

Note that the only REQUIRED parameter is the Patient Resource. When only the Patient is supplied, it can be POSTed directly to the $match endpoint
without being wrapped in a Parameters Resource, as long as it conforms to the [PDQm Patient Profile for $match Input](StructureDefinition-CHPDQmMatchInput.html).
"""
* parameter[resource].resource only CHPDQmMatchInput

Profile: CHPDQmMatchParametersOut
Parent: Bundle
Id: ch-pdqm-matchparametersout
Title: "CH PDQm Match Output Bundle Profile"
Description: "A profile on the Query Patient Resource Response message for ITI-119"
* type = #searchset (exactly)
* total 1..
* entry ^slicing.discriminator.type = #type
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry.fullUrl 1..
* entry contains Patient 0..5 and OperationOutcome 0..*
* entry[Patient] ^short = "Patient"
* entry[Patient].resource 1..
* entry[Patient].resource only ch-pdqm-patient
* entry[Patient].search 1..
* entry[Patient].search.mode 1..
* entry[Patient].search.mode = #match
* entry[Patient].search.score 1..
* entry[Patient].search.extension contains http://hl7.org/fhir/StructureDefinition/match-grade named MatchGrade 1..1
* entry[OperationOutcome] ^short = "OperationOutcome"
* entry[OperationOutcome].resource 1..
* entry[OperationOutcome].resource only OperationOutcome
// * entry[OperationOutcome].resource ^type.code = "OperationOutcome"
// * entry[OperationOutcome].resource ^type.profile = Canonical(OperationOutcome)
// * entry[OperationOutcome].resource only ch-pdqm-toomanyresults

Profile: CHPDQmMatchInput
Parent: https://profiles.ihe.net/ITI/PDQm/StructureDefinition/IHE.PDQm.MatchInputPatient
Title: "CH PDQm Patient Profile for $match Input"
Description: """
The PDQm Patient Profile for $match Input SHALL be provided as input to the ITI-119 transaction.
- While it is not REQUIRED that the input to $match be a valid FHIR instance, it is RECOMMENDED to supply as many elements as possible to facilitate matching.
- modifierExtension and implicitRules SHALL not be specified.
- The ChEprFhirBirthName profile is available to hold the mother's maiden name
- The AHVN13 of the patient MAY be provided as an identifier to identify a patient by the minimal demographics and the social security number
"""
* name ^slicing.discriminator.type = #profile
* name ^slicing.discriminator.path = "$this"
* name ^slicing.rules = #open
* name contains HumanName 0..* and BirthName 0..1
* name[HumanName] only $ch-epr-fhir-humanname
* name[HumanName] ^short = "A name associated with the patient"
* name[BirthName] only $ch-epr-fhir-birthname
* name[BirthName] ^short = "The birthname of the patient"
* name[BirthName] ^comment = "The birthname is added with the ISO 21090 qualifier https://www.hl7.org/fhir/extension-iso21090-en-qualifier.html BR"
* name[HumanName] MS                          // LivingSubjectName
* name[BirthName] MS                          // MothersMaidenName
* gender MS                                   // LivingSubjectAdministrativeGender
* birthDate MS                                // LivingSubjectBirthTime
* address MS                                  // PatientAddress
* identifier MS                               // LivingSubjectId
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains AHVN13 0..1 MS
* identifier[AHVN13].system 1..1
* identifier[AHVN13].system = "urn:oid:2.16.756.5.32" (exactly)
* identifier[AHVN13].value 1..1
* identifier[AHVN13] ^short = "AHVN13 / NAVS13 of the patient (13 digits starting with 756, no separators)"
* telecom ..0                                 // PatientTelecom, forbidden

Profile: ChPdqmResponseTooManyResults
Parent: OperationOutcome
Id: ch-pdqm-toomanyresults
Title: "CH PDQm OperationOutcome Too Many Results"   // need to be put it ig.xml
Description: "A profile on the OperationOutcome to indicate that the search is not complete (too many results)."   // need to be put it ig.xml
* issue.severity = #warning 
* issue.code = #incomplete

Instance: PDQmResponseTooManyResults
InstanceOf: ch-pdqm-toomanyresults
Title: "PDQm OperationOutcome Too Many Results Example"
Description: "An example on the OperationOutcome for indicating that the search is not complete (too many results)."
Usage: #example
* issue[0].severity = #warning
* issue[=].code = #incomplete
* issue[=].details.text = "Too many matches; please provide more specific criteria."

Instance: FranzMusterMatchInputAhvn13
InstanceOf: CHPDQmMatchInput
Usage: #inline
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Franz Muster, 27.1.1995, AHVN13 7561234567897</div>"
* identifier[AHVN13].system = "urn:oid:2.16.756.5.32"
* identifier[AHVN13].value = "7561234567897"
* name.family = "Muster"
* name.given = "Franz"
* gender = #male
* birthDate = "1995-01-27"

Instance: PDQm-MatchRequestAhvn13
InstanceOf: CHPDQmMatchParametersIn
Title: "PDQm Match request message with AHVN13"
Description: "CH PDQm Match request message example identifying Franz Muster, 27.1.1995 by the minimal demographics and the AHVN13 to retrieve the EPR-SPID"
Usage: #example
* parameter[resource].name = "resource"
* parameter[resource].resource = FranzMusterMatchInputAhvn13

Instance: FranzMuster
InstanceOf: ch-pdqm-patient
Usage: #inline
* identifier[EPR-SPID][+].system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* identifier[EPR-SPID][=].value = "761337610411353650"
* name.family = "Muster"
* name.given = "Franz"
* gender = #male
* birthDate = "1995-01-27"

Instance: PDQm-QueryResponse
InstanceOf: CHPDQmMatchParametersOut
Title: "PDQm Match response message"               // need to be put it ig.xml
Description: "CH PDQm Match response message example result for Franz Muster, 27.1.1995"           // need to be put it ig.xml
Usage: #example
* type = #searchset
* total = 1
* link.relation = "self"
* link.url = "http://example.com/Patient/$match"
* entry[Patient][+].fullUrl = "http://example.com/Patient/FranzMuster"
* entry[Patient][=].resource = FranzMuster
* entry[Patient][=].search.mode = #match
* entry[Patient][=].search.score = 1
* entry[Patient][=].search.extension[+].url = "http://hl7.org/fhir/StructureDefinition/match-grade"
* entry[Patient][=].search.extension[=].valueCode = #certain

Instance: PDQm-QueryResponseTooManyResults
InstanceOf: CHPDQmMatchParametersOut
Title: "PDQm Match response message too many results"    // need to be put it ig.xml
Description: "CH PDQm Match response message with too many results indication" // need to be put it ig.xml
Usage: #example
* type = #searchset
* total = 0
* link.relation = "self"
* link.url = "http://example.com/Patient/$match"
* entry[OperationOutcome].fullUrl = "urn:uuid:13c56fd3-f2f1-4174-ae56-c91f027ffddf"
* entry[OperationOutcome].resource = PDQmResponseTooManyResults
* entry[OperationOutcome].search.mode = #outcome


// ---------------------------------------------------------------------------------------------------------------------
// Audit events
Profile:     ChAuditEventIti119Consumer
Parent:      AuditPdqmMatchConsumer
Title:       "CH Audit Event for [ITI-119] Patient Demographics Consumer"
Description: "This profile is used to define the CH Audit Event for the [ITI-119] transaction and the actor 'Patient
              Demographics Consumer'."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Patient Demographics Consumer' actor (Health App)"
* agent[server] ^short = "The 'Patient Demographics Supplier' actor (Health Dossier API)"

Profile:     ChAuditEventIti119Supplier
Parent:      AuditPdqmMatchSupplier
Title:       "CH Audit Event for [ITI-119] Patient Demographics Supplier"
Description: "This profile is used to define the CH Audit Event for the [ITI-119] transaction and the actor 'Patient
Demographics Supplier'."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Patient Demographics Consumer' actor (Health App)"
* agent[server] ^short = "The 'Patient Demographics Supplier' actor (Health Dossier API)"
* entity[patient].what.identifier 1..1
  * value 1..1
  * system 1..1


Instance:   ChAuditEventIti119ConsumerExample
InstanceOf: ChAuditEventIti119Consumer
Usage:      #example
* insert ChAuditEventIti119ExampleRules
* insert ChExampleAuditEventClientRules

Instance:   ChAuditEventIti119SupplierExample
InstanceOf: ChAuditEventIti119Supplier
Usage:      #example
* insert ChAuditEventIti119ExampleRules
* insert ChExampleAuditEventServerRules(MPI)
* insert ChExampleAuditEventEntityPatientRules


RuleSet: ChAuditEventIti119ExampleRules
* insert ChExampleAuditEventBaseRules(client, server, MPI)
* insert ChExampleAuditEventHcpRules
* type = $auditEventType#rest
* subtype[anySearch] = $restfulInteraction#search "search"
* subtype[iti119] = $eventTypeCode#ITI-119 "Patient Demographics Match"
* agent[server].network.address = "http://example.com"
* entity[query]
  * type = $auditEntityType#2
  * role = $objectRole#24
  * query = "ewogICJyZXNvdXJjZVR5cGUiIDogIlBhcmFtZXRlcnMiLAogICJwYXJhbWV0ZXIiIDogWwogICAgewogICAgICAibmFtZSIgOiAicmVzb3VyY2UiLAogICAgICAicmVzb3VyY2UiIDogewogICAgICAgICJyZXNvdXJjZVR5cGUiIDogIlBhdGllbnQiLAogICAgICAgICJuYW1lIiA6IFsKICAgICAgICAgIHsKICAgICAgICAgICAgImZhbWlseSIgOiAiTXVzdGVyIiwKICAgICAgICAgIH0KICAgICAgICBdLAogICAgICAgICJiaXJ0aERhdGUiIDogIjE5OTUtMDEtMjciCiAgICAgIH0KICAgIH0KICBdCn0="
