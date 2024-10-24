This section describes the national extension for the Swiss EPR to the [Mobile Patient Demographics Query
[ITI-78]](https://profiles.ihe.net/ITI/PDQm/ITI-78.html) transaction defined in the IUA profile published in the 
IHE IT Infrastructure Technical Framework Trial Implementation “Patient Demographics Query for mobile”.

### Scope
The Mobile Patient Demographics Query is used by an app in the Swiss EPR to query with demographics parameters for
a patient participating in the Swiss EPR.

### Actor Roles
**Actor:** Patient Demographics Consumer   
**Role:** Requests a list of patients matching the supplied set of demographics criteria (example: ID or Name) from the Patient Demographics Supplier. The Patient Demographics Consumer populates its attributes with demographic information received from the Patient Demographics Supplier.   
**Actor:** Patient Demographics Supplier   
**Role:** Returns demographic information for all patients matching the demographics criteria provided by the Patient Demographics Consumer   

### Referenced Standards

1. [Patient Demographics Query for mobile (PDQm) {{site.data.fhir.ver.ihepdqmfhir | split: "/" | last}}]({{site.data.fhir.ver.ihepdqmfhir}})
2. This PDQm Profile is based on Release 4 of the emerging [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include PDQm_ActorDiagram_ITI-78.svg %}</div>

#### Query Patient Resource message

##### Message Semantics

The semantics of the _Query Patient Resource_ message is the same as defined in
[2:3.78.4.1.2](https://profiles.ihe.net/ITI/PDQm/ITI-78.html#2378412-message-semantics), with the following restrictions:

- The `telecom` search parameter SHALL NOT be used.

##### Expected Actions

The _Patient Demographics Supplier_ shall follow the expected actions as defined in
[2:3.78.4.1.3](https://profiles.ihe.net/ITI/PDQm/ITI-78.html#2378413-expected-actions), with the following restrictions:

- If there are more than 5 matches, the result should return zero matches with an OperationOutcome requesting more
  query parameters.

The patient data (see [Patient example](Patient-FranzMusterNeedsAbsoluteUrl.html)) SHALL conform to the [PDQm Patient profile](StructureDefinition-ch-pdqm-patient.html).
The _Patient Demographics Supplier_ SHALL reference the _PDQm Patient_ profile or a derived constrained profile as a
`supportedProfile` in the CapabilityStatement.

##### Message Example

Query for a patient with family name Muster and birthdate 1995-01-27.

```http
GET [base]/Patient?family=Muster&birthdate=1995-01-27
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00
```
[Example response to above query](Bundle-PDQm-QueryResponse.json.html)

Query for a patient with family name M returning too many results:

```http
GET [base]/Patient?family=M
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00
```
[Example response to above query](Bundle-PDQm-QueryResponseTooManyResults.json.html)

#### Query Patient Resource Response message

#### Retrieve Patient Resource message

The Retrieve Patient Resource is conducted by executing an HTTP GET against the Patient Demographics Supplier’s 
Patient Resource URL, providing the resource id of the patient being retrieved. The target is formatted as:

```http
GET [base]/Patient/[resourceId]
```

#### Retrieve Patient Resource Response message

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Patient Demographics Consumer** is
[PDQm Consumer](CapabilityStatement-CH.PDQm.Consumer.html).

The CapabilityStatement resource for the **Patient Demographics Supplier** is
[PDQm Supplier](CapabilityStatement-CH.PDQm.Supplier.html).

### Security Consideration

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with
server certificates.

The transaction SHALL use client authentication and authorization using basic authorization token as defined
in the [IUA profile](https://profiles.ihe.net/ITI/IUA). The authorization token SHALL be conveyed as
defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72)
transaction.

The Patient Demographics Supplier actor SHALL enforce a `traceparent` header to enable inspection of cross community
transactions as defined in section [Trace Context header](tracecontext.html).

#### Security Audit Considerations

##### Patient Demographics Consumer Audit

The **Patient Demographics Consumer** shall record a
[Patient Demographics Consumer AuditEvent](https://profiles.ihe.net/ITI/PDQm/StructureDefinition-IHE.PDQm.Query.Audit.Consumer.html).
[Audit Example for a PDQm Query transaction from consumer perspective](https://profiles.ihe.net/ITI/PDQm/AuditEvent-ex-auditPdqmQuery-consumer.html).

##### Patient Demographics Supplier Audit

The **Patient Demographics Supplier** shall record a
[Patient Demographics Supplier AuditEvent](https://profiles.ihe.net/ITI/PDQm/StructureDefinition-IHE.PDQm.Query.Audit.Supplier.html).
[Audit Example for a PDQm Query transaction from supplier perspective](https://profiles.ihe.net/ITI/PDQm/AuditEvent-ex-auditPdqmQuery-supplier.html).
