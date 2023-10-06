This section documents additional requirements in the Swiss EPR context on the Mobile Patient Demographics Query.

### Scope
The Mobile Patient Demographics Query is used by an app in the Swiss EPR to query with demographics parameters for
a patient pariticipating in the Swiss EPR.

### Actor Roles
**Actor:** Patient Demographics Consumer   
**Role:** Requests a list of patients matching the supplied set of demographics criteria (example: ID or Name) from the Patient Demographics Supplier. The Patient Demographics Consumer populates its attributes with demographic information received from the Patient Demographics Supplier.   
**Actor:** Patient Demographics Supplier   
**Role:** Returns demographic information for all patients matching the demographics criteria provided by the Patient Demographics Consumer   

### Referenced Standards
[IHE Patient Demographics Query for Mobile Rev. 3.0.0: Trial Implementation) based on FHIR R4. Patient Identifier Cross-referencing for mobile (PIXm), Rev. 3.0.0 – Trial-Implementation, Februar 28, 2022](https://profiles.ihe.net/ITI/PDQm/index.html)  
This PDQm Profile is based on Release 4 of the emerging [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include PDQm_ActorDiagram_ITI-78.svg %}</div>

### Trigger Events
A mobile app wants to query patients, which participate in the Swiss EPR.

### Message Semantics
The message semantics is the same as defined in [2:3.78.4.1.2](https://profiles.ihe.net/ITI/PDQm/ITI-78.html#2378412-message-semantics) with a restriction if there are more than 5 matches. If there are more than 5 matches, the result should return zero matches.

### Message Example
Query for a patient with name Muster and birthdate 1995-01-27. 

```
GET [base]/Patient?name=Muster&birthdate=1995-01-27
Accept: application/fhir+json; fhirVersion=4.0
```
[Example response to above query](Bundle-PDQm-Response.json.html)

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Patient Identifier Cross-reference Manager using the IUA profile with basic access token. Consequently
the Mobile Patient Identifier Cross-reference Query [ITI-83] request must authorize using the Incorporate
Access Token [ITI-72] transaction of the IUA profile.
