Profile: CHPDQmProviderOrganization
Parent: Organization
Id: ch-pdqm-provider-organization
Title: "CH PDQm Provider Organization"
Description: "Organization"
* obeys ch-epr-fhir-org-1
* . ^short = "CH PDQm Provider Organization"
* identifier 1.. MS
* identifier ^short = "The value shall be expressed as an ISO OID"

Invariant: ch-epr-fhir-org-1
Description: "The organization SHALL have at least one of telecom, address, or contact person to be present."
* severity = #error
* expression = "(telecom.count() + address.count() + contact.name.count()) > 0"

Profile: CHPDQmPatient
Parent: $ch-core-patient
Id: ch-pdqm-patient
Title: "CH PDQm Patient"
Description: "The patient demographics and identifier information which can be provided in the PDQm response according to the EPR. If the patient is already registered in a community, the MPI-PID SHALL be provided as an identifier. The EPR-SPID as an identifier MAY be added. The birthname can be added with the  ISO 21090 qualifier extension."
* extension[PatReligion] 0..0
* identifier MS
* identifier[EPR-SPID] 1..1 MS
* identifier[LocalPid] 0..* MS
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
* contact 0..0
* managingOrganization only Reference(CHPDQmProviderOrganization)
* managingOrganization MS
* managingOrganization ^short = "Provider organization of the patient"

// https://github.com/IHE/ITI.PDQm/blob/main/input/fsh/PDQmMatch.fsh
Instance: CHPDQmMatch
InstanceOf: OperationDefinition
Title: "CH PDQm $Match"
Usage: #definition
Description: """
This operation implements the [Patient Demographics Match \[ITI-119\]](iti-119.html) transaction.
It is fully compatible with the [$match Operation on Patient](http://hl7.org/fhir/R4/patient-operation-match.html).
The only changes are to constrain the input parameters to use the [PDQm Patient Profile for $match Input](StructureDefinition-CHPDQmMatchInput.html) profile
and to constring the output parameters to use the [PDQm Patient Profile](StructureDefinition-ch-pdqm-patient.html) profile.
"""
* base = "http://hl7.org/fhir/OperationDefinition/Patient-match"
* name = "Find_Patient_Matches_PDQm"
* status = #draft
* kind = #operation
* affectsState = false
* resource = #Patient
* system = false
* type = true
* instance = false
* code = #match
* inputProfile = Canonical(CHPDQmMatchParametersIn)
* outputProfile = Canonical(CHPDQmMatchParametersOut)
* parameter[+]
  * name = #resource
  * use = #in
  * min = 1
  * max = "1"
  * documentation = "Use this to provide an entire set of patient details for the MPI to match against (e.g. POST a patient record to Patient/$match)."
  * type = #Patient
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
  * documentation = "A bundle contain a set of Patient records that represent possible matches, optionally it MAY also contain an OperationOutcome with further information about the search results (such as warnings or information messages, such as a count of records that were close but eliminated) If the operation was unsuccessful, then an OperationOutcome MAY be returned along with a BadRequest status Code (e.g. security issue, or insufficient properties in patient fragment - check against profile).\n\nNote: as this is the only out parameter, it is a resource, and it has the name 'return', the result of this operation is returned directly as a resource"
  * type = #Bundle

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

// https://github.com/IHE/ITI.PDQm/blob/main/input/fsh/PDQmMatch.fsh
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
// * entry[OperationOutcome].resource only ch-pdqm-moreattributesrequested

// https://github.com/IHE/ITI.PDQm/blob/main/input/fsh/PDQmMatch.fsh
Profile: CHPDQmMatchInput
Parent: https://profiles.ihe.net/ITI/PDQm/StructureDefinition/IHE.PDQm.MatchInputPatient
Title: "CH PDQm Patient Profile for $match Input"
Description: """
The PDQm Patient Profile for $match Input SHALL be provided as input to the ITI-119 transaction.
- While it is not REQUIRED that the input to $match be a valid FHIR instance, it is RECOMMENDED to supply as many elements as possible to facilitate matching.
- modifierExtension and implicitRules SHALL not be specified.
- The ChEprFhirBirthName profile is available to hold the mother's maiden name
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
* telecom ..0                                 // PatientTelecom, forbidden

CodeSystem: ChEhealthCodesystemPqdMoreAttriburesRequested
Id: 2.16.756.5.30.1.127.3.10.17
Title: "CH Codesystem PDQ More Attributes Requested"
Description: "Codes for indicating which additional attributes are requested to lower the results number."
* ^url = "urn:oid:2.16.756.5.30.1.127.3.10.17"
* ^status = #active
* ^experimental = false
* ^publisher = "eHealth Suisse"
* ^contact.name = "eHealth Suisse"
* ^contact.telecom.system = #url
* ^contact.telecom.value = "https://www.e-health-suisse.ch/"
* ^jurisdiction = urn:iso:std:iso:3166#CH
* ^copyright = "CC0-1.0"
* ^caseSensitive = true
* ^content = #complete
* #BirthNameRequested "BirthNameRequested"

CodeSystem: IheXcpdMoreAttriburesRequested
Id: 1.3.6.1.4.1.19376.1.2.27.1
Title: "IHE XCPD Codesystem more attributes requested"
Description: "Codes for indicating which additional attributes are requested to lower the results number."
* ^url = "urn:oid:1.3.6.1.4.1.19376.1.2.27.1"
* ^status = #active
* ^experimental = false
* ^publisher = "IHE International"
* ^contact.name = "IHE IT Infrastructure Technical Committee"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "iti@ihe.net"
* ^jurisdiction = $m49.htm#001
* ^copyright = "CC0-1.0"
* ^caseSensitive = true
* ^content = #complete
* #LivingSubjectAdministrativeGenderRequested "LivingSubjectAdministrativeGenderRequested"
* #PatientAddressRequested "PatientAddressRequested"
* #LivingSubjectBirthPlaceNameRequested "LivingSubjectBirthPlaceNameRequested"

ValueSet: ChPdqmMoreAttriburesRequested
Id: ChPdqmMoreAttriburesRequested
Title: "CH PDQm ValueSet More Attributes Requested"
Description: "Coded Values for indicating which additional attributes are requested to lower the results number."
* ^status = #active
* ^experimental = false
* IheXcpdMoreAttriburesRequested#LivingSubjectAdministrativeGenderRequested
* IheXcpdMoreAttriburesRequested#PatientAddressRequested 
* IheXcpdMoreAttriburesRequested#LivingSubjectBirthPlaceNameRequested
* ChEhealthCodesystemPqdMoreAttriburesRequested#BirthNameRequested

Profile: ChPdqmResponseMoreAttributesRequested
Parent: OperationOutcome
Id: ch-pdqm-moreattributesrequested
Title: "CH PDQm OperationOutcome More Attributes Requested"   // need to be put it ig.xml
Description: "A profile on the OperationOutcome for indicating which additional attributes are requested to lower the results number."   // need to be put it ig.xml
* issue.severity = #warning 
* issue.code = #incomplete
* issue.details from ChPdqmMoreAttriburesRequested (required)

Instance: PDQmResponseMoreAttributesRequested
InstanceOf: ch-pdqm-moreattributesrequested
Title: "PDQm OperationOutcome More Attributes Requested Example"
Description: "An example on the OperationOutcome for indicating which additional attributes are requested to lower the results number."
Usage: #example
* issue[0].severity = #warning
* issue[=].code = #incomplete
* issue[=].details.coding[0] = urn:oid:1.3.6.1.4.1.19376.1.2.27.1#LivingSubjectAdministrativeGenderRequested "LivingSubjectAdministrativeGenderRequested"
* issue[+].severity = #warning
* issue[=].code = #incomplete
* issue[=].details.coding[0] = urn:oid:1.3.6.1.4.1.19376.1.2.27.1#LivingSubjectBirthPlaceNameRequested "LivingSubjectBirthPlaceNameRequested"
* issue[+].severity = #warning
* issue[=].code = #incomplete
* issue[=].details.coding[0] = 2.16.756.5.30.1.127.3.10.17#BirthNameRequested "BirthNameRequested"

Instance: FranzMuster
InstanceOf: ch-pdqm-patient
Usage: #inline
* identifier[EPR-SPID][+].system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* identifier[EPR-SPID][=].value = "761337610411353650"
* identifier[LocalPid][+].system = "urn:oid:2.999.5.6.7"
* identifier[LocalPid][=].value = "value of MPI-PID"
* identifier[LocalPid][+].type = $v2-0203#MR
* identifier[LocalPid][=].system = "urn:oid:2.16.756.888888.3.1"
* identifier[LocalPid][=].value = "8734"
* name.family = "Muster"
* name.given = "Franz"
* gender = #male
* birthDate = "1995-01-27"
* managingOrganization.identifier.system = "urn:oid:2.51.1.3"
* managingOrganization.identifier.value = "7601000201041"

Instance: PDQm-QueryResponse
InstanceOf: CHPDQmMatchParametersOut
Title: "PDQm Match response message"               // need to be put it ig.xml
Description: "CH PDQm Match response message example result for Franz Muster, 27.1.1995"           // need to be put it ig.xml
Usage: #example
* type = #searchset
* total = 1
* link.relation = "self"
* link.url = "https://example.org/fhir/Patient/$match"
* entry[Patient][+].fullUrl = "https://example.org/fhir/Patient/FranzMuster"
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
* link.url = "https://example.org/fhir/Patient/$match"
* entry[OperationOutcome].fullUrl = "urn:uuid:13c56fd3-f2f1-4174-ae56-c91f027ffddf"
* entry[OperationOutcome].resource = PDQmResponseMoreAttributesRequested
* entry[OperationOutcome].search.mode = #outcome


// ---------------------------------------------------------------------------------------------------------------------
// Audit events
Profile:     ChAuditEventIti119Consumer
Parent:      AuditPdqmMatchConsumer
Title:       "CH Audit Event for [ITI-119] Patient Demographics Consumer"
Description: "This profile is used to define the CH Audit Event for the [ITI-119] transaction and the actor 'Patient
              Demographics Consumer'."
* insert ChAuditEventExtendedRules
* agent[client] ^short = "The 'Patient Demographics Consumer' actor (EPR application)"
* agent[server] ^short = "The 'Patient Demographics Supplier' actor (EPR API)"
* entity[patient].what.identifier 1..1
  * value 1..1
  * system 1..1


Profile:     ChAuditEventIti119Supplier
Parent:      AuditPdqmMatchSupplier
Title:       "CH Audit Event for [ITI-119] Patient Demographics Supplier"
Description: "This profile is used to define the CH Audit Event for the [ITI-119] transaction and the actor 'Patient
Demographics Supplier'."
* insert ChAuditEventExtendedRules
* agent[client] ^short = "The 'Patient Demographics Consumer' actor (EPR application)"
* agent[server] ^short = "The 'Patient Demographics Supplier' actor (EPR API)"
* entity[patient].what.identifier 1..1
  * value 1..1
  * system 1..1


Instance:   ChAuditEventIti119ConsumerExample
InstanceOf: ChAuditEventIti119Consumer
Usage:      #example
* insert ChAuditEventIti119ExampleRules
* insert ChExampleAuditEventClientRules
* insert ChExampleAuditEventEntityPatientRules


Instance:   ChAuditEventIti119SupplierExample
InstanceOf: ChAuditEventIti119Supplier
Usage:      #example
* insert ChAuditEventIti119ExampleRules
* insert ChExampleAuditEventServerRules
* insert ChExampleAuditEventEntityPatientRules


RuleSet: ChAuditEventIti119ExampleRules
* insert ChExampleAuditEventBaseRules(client, server)
* insert ChExampleAuditEventHcpRules
* type = $auditEventType#rest
* subtype[anySearch] = $restfulInteraction#search "search"
* subtype[iti119] = $eventTypeCode#ITI-119 "Patient Demographics Match"
* agent[server].network.address = "https://example.org/fhir/"
* entity[query]
  * type = $auditEntityType#2
  * role = $objectRole#24
  * query = "ewogICJyZXNvdXJjZVR5cGUiIDogIlBhcmFtZXRlcnMiLAogICJwYXJhbWV0ZXIiIDogWwogICAgewogICAgICAibmFtZSIgOiAicmVzb3VyY2UiLAogICAgICAicmVzb3VyY2UiIDogewogICAgICAgICJyZXNvdXJjZVR5cGUiIDogIlBhdGllbnQiLAogICAgICAgICJuYW1lIiA6IFsKICAgICAgICAgIHsKICAgICAgICAgICAgImZhbWlseSIgOiAiTXVzdGVyIiwKICAgICAgICAgIH0KICAgICAgICBdLAogICAgICAgICJiaXJ0aERhdGUiIDogIjE5OTUtMDEtMjciCiAgICAgIH0KICAgIH0KICBdCn0="
