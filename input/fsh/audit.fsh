Instance: ExampleAuditFindDocumentReferencesConsumer
InstanceOf: IHE.MHD.FindDocumentReferences.Audit.Consumer
Title: "Audit Example of ITI-67 at Consumer"
Description: "Audit Example for a Find Document References [ITI-67] from the Consumer perspective"
Usage: #example
* type
  * system = "http://terminology.hl7.org/CodeSystem/audit-event-type"
  * code = #rest
  * display = "Restful Operation"
* subtype[iti67]
  * system = "urn:ihe:event-type-code"
  * code = #ITI-67
  * display = "Find Document References"
* subtype[anySearch]
  * system = "http://hl7.org/fhir/restful-interaction"
  * code = #search
  * display = "search"
* action = #E
* recorded = "2024-10-16T12:01:30+00:00"
* outcome = #0
* agent[client]
  * type
    * coding
      * system = "http://dicom.nema.org/resources/ontology/DCM"
      * code = #110153
      * display = "Source Role ID"
  * who
    * display = "My Primary System @ Institution"
  * requestor = false
  * network
    * address = "10.0.0.1"
    * type = #2
* agent[server]
  * type
    * coding
      * system = "http://dicom.nema.org/resources/ontology/DCM"
      * code = #110152
      * display = "Destination Role ID"
  * who
    * display = "http://example.com/fhir"
  * requestor = false
  * network
    * address = "example.com"
    * type = #1
* agent[user]
  * type
    * coding
      * system = "http://terminology.hl7.org/CodeSystem/v3-ParticipationType"
      * code = #IRCP
      * display = "information recipient"
  * role
    * coding
      * system = "urn:oid:2.16.756.5.30.1.127.3.10.6"
      * code = #HCP
      * display = "Healthcare professional"
    * text = "Healthcare professional"
  * who
    * display = "Martina Musterarzt"
  * altId = "2000000090092"
  * requestor = true
* source
  * site = "2.999.1.2"
  * observer
    * display = "My Primary System @ Institution"
  * type
    * system = "http://terminology.hl7.org/CodeSystem/security-source-type"
    * code = #1
    * display = "User Device"
* entity[query]
  * type
    * system = "http://terminology.hl7.org/CodeSystem/audit-entity-type"
    * code = #2
    * display = "System Object"
  * role
    * system = "http://terminology.hl7.org/CodeSystem/object-role"
    * code = #24
    * display = "Query"
  * description = "GET http://example.org/fhir/DocumentReference?patient.identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|761337610411353650&status=current"
  * query = "R0VUIGh0dHA6Ly9leGFtcGxlLm9yZy9maGlyL0RvY3VtZW50UmVmZXJlbmNlP3BhdGllbnQuaWRlbnRpZmllcj11cm46b2lkOjIuMTYuNzU2LjUuMzAuMS4xMjcuMy4xMC4zfDc2MTMzNzYxMDQxMTM1MzY1MCZzdGF0dXM9Y3VycmVudA=="
* entity[patient]
  * what
    * identifier
      * system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
      * value = "761337610411353650"
  * type
    * system = "http://terminology.hl7.org/CodeSystem/audit-entity-type"
    * code = #1
    * display = "Person"
  * role
    * system = "http://terminology.hl7.org/CodeSystem/object-role"
    * code = #1
    * display = "Patient"
* entity[2]
  * what
    * identifier
      * value = "00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00"
  * type
    * system = "http://terminology.hl7.org/CodeSystem/audit-entity-type"
    * code = #4
    * display = "Other"
  * role
    * system = "http://terminology.hl7.org/CodeSystem/object-role"
    * code = #26
    * display = "Processing Element"