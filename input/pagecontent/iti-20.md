### Scope

This section describes the national extension for the Swiss EPR of the Send Audit Resource Request Message – RESTful interaction [ITI-20] transaction defined in the RESTful ATNA profile which is currently prepared as IHE Trial Implementation with the working title” Add RESTful ATNA (Query and Feed)”. The Audit Record Repository SHALL support the ATX: FHIR Feed Option.

### Actor Roles

**Actor:** Any actor or any other application that is grouped with the Secure Node or Secure Application.  
**Role:** Create an audit record and transmit this record to the Audit Record Repository.  
**Actor:** Audit Record Repository  
**Role:** Receive an audit record from the Audit Record Creator and store this for audit purposes.  

### Referenced Standards

[Add RESTful ATNA (Query and Feed), Rev. 3.2 – Trial Implementation, August 28, 2020](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf)  
The Trial Implementation is based on Release 4 of the [HL7® FHIR®](https://www.hl7.org/fhir/index.html) standard.

### Messages

<div>{% include RESTATNA_ActorDiagram_ITI-20.svg %}</div>
<div><figcaption>Interaction diagram for FHIR Feed Interaction [ITI-65]</figcaption></div>  

### Trigger Events

This message is sent when an actor that is grouped with Secure Node or Secure Application or an
Audit Record Forwarder needs to post a single or multiple AuditEvent Resource to the Audit Record
Repository.

### Message Semantics
### Expected Actions

Same message semantics and expected actions apply as described in the ITI-20 transaction.

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Audit Record Repository using IUA profile with basic access token. 