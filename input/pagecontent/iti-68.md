This section describes the additional requirements for the Swiss EPR of the [Retrieve Document
[ITI-68]](https://profiles.ihe.net/ITI/MHD/ITI-68.html) transaction defined in the MHD Profile published in the IHE ITI
Trial Implementation “Mobile Access to Health Documents”.

### Scope

The Retrieve Document [ITI-68] transaction is used by the Document Consumer to retrieve a
document from the Document Responder. 

### Actor Roles

**Actor:** Document Consumer   
**Role:** Requests a document from the Document Responder.   
**Actor:** Document Responder   
**Role:** Serves the document to the Document Consumer.   

### Referenced Standards

1. [Mobile access to Health Documents (MHD), Rev. 4.0.2 – Trial-Implementation,  November 8, 2021](https://profiles.ihe.net/ITI/MHD/index.html) 
2. This MHD Profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include MHD_ActorDiagram_ITI-68.svg %}</div>

#### Retrieve Document Request Message

#### Retrieve Document Response Message

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Document Consumer** is [MHD Document Consumer](CapabilityStatement-CH.MHD.DocumentConsumer.html).

The CapabilityStatement resource for the **Document Responder** is [MHD Document Responder](CapabilityStatement-CH.MHD.DocumentResponder.html).

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Document Responder using the IUA profile with extended access token. Consequently
the _Retrieve Document_ [ITI-68] request must authorize using the [[ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72)
transaction of the IUA profile.

The `traceparent` header is required, as described in [Trace Context header](tracecontext.html).

#### Security Audit Considerations

##### Document Consumer Audit

The **Document Consumer** shall be able to record a
[Retrieve Document Consumer Audit Event Log](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.RetrieveDocument.Audit.Consumer.html).
[Audit Example for a Retrieve Document transaction from consumer perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditRetrieveDocument-consumer.html).

##### Document Responder Audit

The **Document Responder** shall be able to record a
[Retrieve Document Responder Audit Event Log](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.RetrieveDocument.Audit.Responder.html).
[Audit Example for a Find Document Lists Transaction from responder perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditRetrieveDocument-responder.html).
