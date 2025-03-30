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

####  Expected Actions

##### Federated Cross Community Access Option

{% include iti-mhd-fxca-retrieve.html %}

All Document Responders except the one with the Federated Cross Community Access Option SHALL identify if the document retrieve 
targets another community. If this is the case, it SHALL forward the request to the target community, otherwise the request can be handled directly.

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Document Consumer** is [MHD Document Consumer](CapabilityStatement-CH.MHD.DocumentConsumer.html).

The CapabilityStatement resource for the **Document Responder** is [MHD Document Responder](CapabilityStatement-CH.MHD.DocumentResponder.html).

### Security Consideration

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with server certificates. Transactions across communities SHALL use mTLS.

The transaction SHALL use client authentication and authorization using one of the following strategies:
1. Use an extended access token defined in [IUA](iti-71.html) conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.
2. or, use mutual authentication (mTLS) on the transport layer in combination with a XUA token for authorization. The XUA token SHALL be conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.

All Document Responders except the one with the Federated Cross Community Access Option SHALL be grouped with the Authorization Decision Consumer actor of the CH:ADR profile
defined in Extension 2.1 to Annex 5 of the ordinances and perform an Authorization Decision Request [CH:ADR] for
every Retrieve Document [ITI-68] request.

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).

#### Security Audit Considerations

##### Document Consumer Audit

The **Document Consumer** shall record a
[CH Audit Event for [ITI-68] Document Consumer](StructureDefinition-ChAuditEventIti68Consumer.html)
([example](AuditEvent-ChAuditEventIti68ConsumerExample.html)).

##### Document Responder Audit

The **Document Responder** shall record a
[CH Audit Event for [ITI-68] Document Responder](StructureDefinition-ChAuditEventIti68Responder.html)
([example](AuditEvent-ChAuditEventIti68ResponderExample.html)).
