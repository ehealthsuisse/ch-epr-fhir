This section documents additional requirements in the Swiss EPR context on the Mobile Patient Identifier
Cross-reference Query.

### Scope
The Mobile Patient Identifier Cross-reference Query is used by an app in the Swiss EPR to query with the
local identifier the MPI and get the corresponding MPI-PID and the EPR-SPID identifier for the patient.

### Actor Roles
**Actor:** Patient Identifier Cross-reference Consumer   
**Role:** Queries the Patient Identifier Cross-reference Manager for the MPI-PID and EPR-SPID.   
**Actor:** Patient Identifier Cross-reference Manager   
**Role:** Resolves the local ID sent with the request to the MPI-PID and EPR-SPID.   

### Referenced Standards
[Patient Identifier Cross-referencing for mobile (PIXm), Rev. 3.0.0 – Trial-Implementation, November 8, 2021](https://profiles.ihe.net/ITI/PIXm/index.html)  
This PIXm Profile is based on Release 4 of the emerging [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include PIXM_ActorDiagram_ITI-83.svg %}</div>

### Trigger Events
A mobile app wants to access (read or write) documents, which requires the MPI-PID of the patient.

### Message Semantics
The message semantics is the same as defined in [2:3.83.4.1.2](https://profiles.ihe.net/ITI/PIXm/ITI-83.html#2383412-message-semantics) with a restriction on the targetSystem query
Parameter:

```
GET [base]/Patient/$ihe-pix?sourceIdentifier=[token]{&targetSystem=[uri]}{&_format=[token]}
```
<div><figcaption>$ihe-pix Message HTTP query Parameters</figcaption></div>  

{:class="table table-bordered"}
| Query parameter Name | Cardinalty | Search Type | Description | Swiss National Extension |
| --- | --- | --- | --- | --- |
| **Input Parameters** |||||
| sourceIdentifier | 1..1 | token | The Patient identifier search parameter that will be used by the Patient Identifier Cross-reference Manager to find cross matching identifiers associated with the Patient Resource. See Section [2:3.83.4.1.2.1](https://profiles.ihe.net/ITI/PIXm/ITI-83.html#23834121-source-patient-identifier-parameter). | No further refinement. |
| targetSystem | **1..2** | uri | The Assigning Authorities for the Patient Identity Domains from which the returned identifiers shall be selected. See Section [2:3.83.4.1.2.2](https://profiles.ihe.net/ITI/PIXm/ITI-83.html#23834122-requesting-patient-identifier-domains-to-be-returned). | SHALL be Restricted to the Assigning authority of the community and/or the EPR-SPID. |
| _format | 0..1 | token | The requested format of the response from the mime-type value set. See [ITI TF-2: Appendix Z.6](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html). | No further refinement. |

<div><figcaption>$ihe-pix Message response</figcaption></div>  

{:class="table table-bordered"}
| Parameter | Cardinality | Data Type | Description |
| --- | --- | --- | --- |
| **FHIR Parameters Resource** ||||
| targetIdentifier | **0..2** | Identifier | The identifier found. Constraints to include the assigning authority as specified in [ITI TF-2: Appendix E.3](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#page=16). |
| targetId | **0..1** | Reference(Patient) | The URL of the Patient Resource |

If the targetSystem is not restricted to the Assigning authority of the community and/or the EPR-SPID the
error Target Domain not recognized ([2:3.83.4.2.2.4](https://profiles.ihe.net/ITI/PIXm/ITI-83.html#23834224-target-domain-not-recognized)) SHALL be returned.

See the corresponding [OperationDefinition](OperationDefinition-CH.PIXm.html).

### Message Example
Query for a patient with a local id of 123 by AssigningAuthority oid 1.2.3 which resides in a
community where the Assigning Authority is oid 5.6.7 and the MPI-PID and EPR-SPID are requested:

```
GET [base]/Patient/$ihe-pix?sourceIdentifier=urn:oid:2.999.1.2.3|123&targetSystem=urn:oid:2.999.5.6.7&targetSystem=urn:oid:2.16.756.5.30.1.127.3.10.3
```
[Example response to above query](Parameters-ParametersPIXmOutput.json.html)

Alternative:  
See [Input Parameters example](Parameters-ParametersPIXmInput.html) (and the corresponding [profile](StructureDefinition-ch-pixm-in-parameters.html)) for the Mobile Patient Identifier Cross-reference Query.   
See [Output Parameters example](Parameters-ParametersPIXmOutput.html) (and the corresponding [profile](StructureDefinition-ch-pixm-out-parameters.html)) as response to the Mobile Patient Identifier Cross-reference Query.

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Patient Identifier Cross-reference Manager using the IUA profile with basic access token. Consequently
the Mobile Patient Identifier Cross-reference Query [ITI-83] request must authorize using the Incorporate
Access Token [ITI-72] transaction of the IUA profile.
