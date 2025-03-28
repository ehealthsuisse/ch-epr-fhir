This section describes the national extension for the Swiss EPR to the [Mobile Patient Identifier Cross-reference Query
[ITI-83]](https://profiles.ihe.net/ITI/PIXm/ITI-83.html) transaction defined in the IUA profile published in the
IHE IT Infrastructure Technical Framework Trial Implementation “Patient Identifier Cross-referencing for mobile”.

### Scope

The Mobile Patient Identifier Cross-reference Query is used by an app in the Swiss EPR to query with the
local identifier the MPI and get the corresponding MPI-PID and the EPR-SPID identifier for the patient.

### Actor Roles

**Actor:** Patient Identifier Cross-reference Consumer   
**Role:** Queries the Patient Identifier Cross-reference Manager for the MPI-PID and EPR-SPID.   
**Actor:** Patient Identifier Cross-reference Manager   
**Role:** Resolves the local ID sent with the request to the MPI-PID and EPR-SPID.   

### Referenced Standards

1. [Patient Identifier Cross-referencing for mobile (PIXm), {{site.data.fhir.ver.ihepixmfhir | split: "/" | last}}]({{site.data.fhir.ver.ihepixmfhir}})
2. This PIXm Profile is based on Release 4 of the emerging [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include PIXM_ActorDiagram_ITI-83.svg %}</div>

#### Get Corresponding Identifiers message

##### Message Semantics

The message semantics is the same as defined in [2:3.83.4.1.2](https://profiles.ihe.net/ITI/PIXm/ITI-83.html#2383412-message-semantics) with a restriction on the targetSystem query
Parameter:

```http
GET [base]/Patient/$ihe-pix?sourceIdentifier=[token]&targetSystem=[uri]{&_format=[token]}
```
<div><figcaption>$ihe-pix Message HTTP query Parameters</figcaption></div>

| Query parameter Name | Cardinality | Search Type | Description                                                                                                                                                                                                                                                                                                    | Swiss National Extension                                                                              |
|----------------------|-------------|-------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| **Input Parameters** |             |             |                                                                                                                                                                                                                                                                                                                |                                                                                                       |
| sourceIdentifier     | 1..1        | token       | The Patient identifier search parameter that will be used by the Patient Identifier Cross-reference Manager to find cross matching identifiers associated with the Patient Resource. See Section [2:3.83.4.1.2.1](https://profiles.ihe.net/ITI/PIXm/ITI-83.html#23834121-source-patient-identifier-parameter). | No further refinement.                                                                                |
| targetSystem         | **1..2**    | uri         | The Assigning Authorities for the Patient Identity Domains from which the returned identifiers shall be selected. See Section [2:3.83.4.1.2.2](https://profiles.ihe.net/ITI/PIXm/ITI-83.html#23834122-requesting-patient-identifier-domains-to-be-returned).                                                   | SHALL be the Assigning authority of the EPR-SPID and MAY be the Assigning authority of the community. |
| _format              | 0..1        | token       | The requested format of the response from the mime-type value set. See [ITI TF-2: Appendix Z.6](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html).                                                                                                                                                            | No further refinement.                                                                                |
{:class="table table-bordered"}


See the [PIXm Find patient matches](OperationDefinition-CH.PIXm.html) OperationDefinition and the 
[CH PIXm IN Parameters](StructureDefinition-ch-pixm-in-parameters.html) Profile 
(with its [example: PIXm Parameters Query Input](Parameters-ParametersPIXmInput.html)).


##### Message Example

Query for a patient with a local id of 123 by AssigningAuthority oid 1.2.3 which resides in a
community where the Assigning Authority is oid 5.6.7 and the MPI-PID and EPR-SPID are requested:

```http
GET [base]/Patient/$ihe-pix?sourceIdentifier=urn:oid:2.999.1.2.3|123&targetSystem=urn:oid:2.999.5.6.7&targetSystem=urn:oid:2.16.756.5.30.1.127.3.10.3 HTTP/1.1
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00

```

#### Response message

##### Message Semantics

<div><figcaption>$ihe-pix Message response</figcaption></div>

| Parameter                    | Cardinality | Data Type          | Description                                                                                                                                                               |
|------------------------------|------------|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **FHIR Parameters Resource** |            |                    |                                                                                                                                                                           |
| targetIdentifier             | **0..2**   | Identifier         | The identifier found. Constraints to include the assigning authority as specified in [ITI TF-2: Appendix E.3](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#page=16). |
{:class="table table-bordered"}

See [Output Parameters example](Parameters-ParametersPIXmOutput.html) (and the corresponding 
[profile](StructureDefinition-ch-pixm-out-parameters.html)) as response to the Mobile Patient Identifier 
Cross-reference Query.

For privacy reasons, the **targetId** parameter shall not be returned.

###### Target Domain not recognized

If the `targetSystem` is not restricted to the Assigning authority of the community and the EPR-SPID, then the following
failure shall be returned:

**HTTP 403** (Forbidden) is returned as the HTTP status code.

An OperationOutcome Resource is returned indicating that the Patient
Identifier Domain is not recognized in an `issue` having:

| Attribute   | Value                                                                          |
|-------------|--------------------------------------------------------------------------------|
| severity    | error                                                                          |
| code        | [code-invalid](http://hl7.org/fhir/R4/codesystem-issue-type.html#code-invalid) |
| diagnostics | “targetSystem not found”                                                       |
{:class="table table-bordered"}

See [Input Parameters example](Parameters-ParametersPIXmInput.html) (and the corresponding [profile](StructureDefinition-ch-pixm-in-parameters.html)) for the Mobile Patient Identifier Cross-reference Query.  

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Patient Identifier Cross-reference Consumer** is
[PIXm Patient Identifier Cross-Reference Consumer](CapabilityStatement-CH.PIXm.Consumer.html).

The CapabilityStatement resource for the **Patient Identifier Cross-reference Manager** is
[PIXm Patient Identifier Cross-reference Manager](CapabilityStatement-CH.PIXm.Manager.html).

### Security Consideration

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with
server certificates.

The transaction SHALL use client authentication and authorization using basic access token as defined
in the [IUA profile](https://profiles.ihe.net/ITI/IUA). The authorization token SHALL be conveyed as
defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72)
transaction.

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).

#### Security Audit Considerations

##### Patient Identifier Cross-reference Consumer Audit

The **Patient Identifier Cross-reference Consumer** shall record a
[CH Audit Event for [ITI-83] Patient Identifier Cross-reference Consumer](StructureDefinition-ChAuditEventIti83Consumer.html)
([example](AuditEvent-ChAuditEventIti83ConsumerExample.html)).

##### Patient Identifier Cross-reference Manager Audit

The **Patient Identifier Cross-reference Manager** shall record a
[CH Audit Event for [ITI-83] Patient Identifier Cross-reference Manager](StructureDefinition-ChAuditEventIti83Manager.html)
([example](AuditEvent-ChAuditEventIti83ManagerExample.html)).
