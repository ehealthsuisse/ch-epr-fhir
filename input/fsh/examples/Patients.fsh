Instance: Kaenel
InstanceOf: ch-pdqm-patient
* identifier[EPR-SPID].system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* identifier[EPR-SPID].value = "761337614042587767"
* identifier[+].system = "urn:oid:2.16.756.5.30.1.190.0.0.12.3.101"
* identifier[=].value = "7f0f398a-2531-4105-ae5c-aac49575e435"
* identifier[=].type.coding[0].system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[=].type.coding[0].code = #MR
* identifier[+].system = "urn:oid:2.16.756.5.30.1.190.0.0.2.1"
* identifier[=].value = "a10a838a-21f7-4161-9e21-9957892e9a07"
* name.family = "RUEEGG-VON KAENEL"
* name.given = "JINGXIN"
* gender = #male
* birthDate = "1977-02-17"
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/patient-citizenship"
* extension[=].extension.url = "code"
* extension[=].extension.valueCodeableConcept.coding.system = "urn:iso:std:iso:3166"
* extension[=].extension.valueCodeableConcept.coding.code = #CH
* extension[=].extension.valueCodeableConcept.coding.display = "Switzerland"
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/patient-birthPlace"
* extension[=].valueAddress.city = "Paris"
* extension[=].valueAddress.country = "Frankreich"
* extension[+].url = "http://fhir.ch/ig/ch-core/StructureDefinition/ch-core-patient-ech-11-placeoforigin"
* extension[=].valueAddress.city = "Köniz"
* extension[=].valueAddress.state = "BE"
//* extension[+].url = "http://hl7.org/fhir/StructureDefinition/patient-religion"
//* extension[=].valueCodeableConcept.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ReligiousAffiliation"
//* extension[=].valueCodeableConcept.coding.code = #1077
//* extension[=].valueCodeableConcept.coding.display = "Protestant"
* telecom[0].system = #email
* telecom[=].value = "dh-testing+7560486828480@testfactory.ch"
* telecom[=].use = #home
* telecom[+].system = #phone
* telecom[=].value = "+41347324563"
* telecom[=].use = #mobile
* telecom[+].system = #phone
* telecom[=].value = "=43242355"
* telecom[=].use = #home
* address.line = "viale stazione 15"
* address.city = "Bellinzona"
* address.postalCode = "6500"
* address.country = "CH"
* maritalStatus.coding.system = "http://fhir.ch/ig/ch-core/CodeSystem/ech-11-maritalstatus"
* maritalStatus.coding.code = #6
* maritalStatus.coding.display = "in eingetragener Partnerschaft"
* communication.language.coding.system = "urn:ietf:bcp:47"
* communication.language.coding.code = #de-CH
* communication.language.text = "Deutsch (Schweiz)"
* communication.preferred = true
* active = true