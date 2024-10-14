This section describes the additional requirements for the Swiss EPR of the [Find Document References
[ITI-67]](https://profiles.ihe.net/ITI/MHD/ITI-67.html) transaction defined in the MHD Profile published in the IHE ITI
Trial Implementation “Mobile Access to Health Documents”.

### Scope

The Find Document References transaction is used to find DocumentReference Resources that
satisfy a set of parameters. It is equivalent to the _FindDocuments_ and
_FindDocumentsByReferenceId_ queries from the _Registry Stored Query_ [ITI-18] transaction. The
result of the query is a FHIR Bundle containing DocumentReference Resources that match the
query parameters.

### Actor Roles

**Actor:** Document Consumer   
**Role:** Requests a list of DocumentReference Resources, matching the supplied set of criteria, from the Document Responder.   
**Actor:** Document Responder   
**Role:** Returns DocumentReference Resources that match the search criteria provided by the Document Consumer.   

### Referenced Standards

1. [Mobile access to Health Documents (MHD), Rev. {{site.data.fhir.ver.ihemhdfhir | split: "/" | last}}]({{site.data.fhir.ver.ihemhdfhir}})
2. This MHD Profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include MHD_ActorDiagram_ITI-67.svg %}</div>

#### Find Document References Request Message

The Document Consumer SHALL include the search parameter patient.identifier with the oid of the EPR-SPID.
The search parameters of type [token](https://hl7.org/fhir/R4/search.html#token) SHALL contain both the system and the code.

_Find Document Reference_ example **request**:
```http
GET [base]/DocumentReference?patient.identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|761337610411353650&status=current HTTP/1.1
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00
```

#### Find Document References Response Message

The response Bundle SHALL follow the [CH MHD Find Document References Comprehensive Response message](StructureDefinition-ch-mhd-documentreference-comprehensive-bundle.html)
Profile ([example: MHD Find DocumentReferences](Bundle-Bundle-FindDocumentReferences.html)).

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Document Consumer** is [MHD Document Consumer](CapabilityStatement-CH.MHD.DocumentConsumer.html).

The CapabilityStatement resource for the **Document Responder** is [MHD Document Responder](CapabilityStatement-CH.MHD.DocumentResponder.html).

### Security Consideration

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

#### Security Audit Considerations

##### Document Consumer Audit

The **Document Consumer** shall record a
[Find Document References Consumer Audit Event Log](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.FindDocumentReferences.Audit.Consumer.html).
[Audit Example for a Find Document References transaction from consumer perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditFindDocumentReferences-consumer.html).

##### Document Responder Audit

The **Document Responder** shall record a
[Find Document References Responder Audit Event Log](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.FindDocumentReferences.Audit.Responder.html).
[Audit Example for a Find Document Lists Transaction from responder perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditFindDocumentReferences-responder.html).
