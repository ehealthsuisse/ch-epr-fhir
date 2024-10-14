### Scope

This section describes the national extension for the Swiss EPR of the [Send Audit Resource Request Message – 
RESTful interaction [ITI-20]](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf) transaction defined in the RESTful ATNA profile which is currently prepared as IHE 
Trial Implementation with the working title ”Add RESTful ATNA (Query and Feed)”. The Audit Record Repository SHALL support the ATX: FHIR Feed Option.

### Actor Roles

**Actor:** Any actor or any other application that is grouped with the Secure Node or Secure Application (Audit Creator).  
**Role:** Create an audit record and transmit this record to the Audit Record Repository.   
**Actor:** Audit Record Repository  
**Role:** Receive an audit record from the Audit Record Creator and store this for audit purposes.

### Referenced Standards

1. [Add RESTful ATNA (Query and Feed), Rev. 3.3](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf)  
2. This RESTful ATNA profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

The “Send Audit Resource Request Message – FHIR Feed Interaction” is used for auditing the FHIR Audit Event Resource using the RESTful protocol. 

<div>{% include RESTATNA_ActorDiagram_ITI-20.svg %}</div>

#### Send Audit Resource Request Message – FHIR Feed Interaction

##### Trigger Events

This message is sent when an actor that is grouped with Secure Node or Secure Application or an
Audit Record Forwarder needs to post a single or multiple AuditEvent Resource to the Audit Record
Repository.

##### Message Semantics

[Audit Example for a Provide Bundle Transaction from source perspective](AuditEvent-ex-auditProvideBundle-source.html)

##### Expected Actions

Same message semantics and expected actions apply as described in the ITI-20 transaction.

#### Send Audit Resource Response

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Audit Creator** is
[ATNA Audit Creator](CapabilityStatement-CH.ATNA.AuditCreator.html).

The CapabilityStatement resource for the **Audit Record Repository** is
[ATNA Audit Record Repository](CapabilityStatement-CH.ATNA.AuditRecordRepository.html).

### Security Consideration

TLS SHALL be used.

For the `traceparent` header handling refer to [Trace Context header](tracecontext.html).
