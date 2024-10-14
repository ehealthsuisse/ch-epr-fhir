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

1. [Mobile access to Health Documents (MHD), Rev. {{site.data.fhir.ver.ihemhdfhir | split: "/" | last}}]({{site.data.fhir.ver.ihemhdfhir}})
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

For the `traceparent` header handling refer to [Trace Context header](tracecontext.html).

#### Security Audit Considerations

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with
server certificates.

The transaction SHALL use client authentication and authorization using extended authorization token as defined
in the [IUA profile](https://profiles.ihe.net/ITI/IUA). The extended authorization token SHALL be conveyed as
defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72)
transaction.

The Document Responder actor SHALL be grouped with the Authorization Decision Consumer actor of the CH:ADR profile
defined in Extension 2.1 to Annex 5 of the ordinances and perform an Authorization Decision Request [CH:ADR] for
every Provide Document Bundle [ITI-65] request.

The Document Responder actor SHALL enforce a `traceparent` header to enable inspection of cross community
transactions as defined in section [Trace Context header](tracecontext.html).

##### Document Consumer Audit

The **Document Consumer** shall record a
[Retrieve Document Consumer Audit Event Log](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.RetrieveDocument.Audit.Consumer.html).
[Audit Example for a Retrieve Document transaction from consumer perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditRetrieveDocument-consumer.html).

##### Document Responder Audit

The **Document Responder** shall record a
[Retrieve Document Responder Audit Event Log](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.RetrieveDocument.Audit.Responder.html).
[Audit Example for a Find Document Lists Transaction from responder perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditRetrieveDocument-responder.html).
