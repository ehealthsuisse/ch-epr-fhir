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

1. [Mobile access to Health Documents (MHD), Rev. 4.0.2 – Trial-Implementation,  November 8, 2021](https://profiles.ihe.net/ITI/MHD/index.html)
2. This MHD Profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include MHD_ActorDiagram_ITI-67.svg %}</div>

#### Find Document References Request Message

_Find Document Reference_ example **request**:
```http
GET [base]/DocumentReference?patient.identifier=urn:oid:2.999|11111111 HTTP/1.1
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

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Document Responder using the IUA profile with extended access token. Consequently
the _Find Document References_ [ITI-67] request must authorize using the 
[[ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction of the IUA profile.

#### Security Audit Considerations

##### Document Consumer Audit

The **Document Consumer** shall be able to record a
[Find Document References Consumer Audit Event Log](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.FindDocumentReferences.Audit.Consumer.html).
[Audit Example for a Find Document References transaction from consumer perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditFindDocumentReferences-consumer.html).

##### Document Responder Audit

The **Document Responder** shall be able to record a
[Find Document References Responder Audit Event Log](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.FindDocumentReferences.Audit.Responder.html).
[Audit Example for a Find Document Lists Transaction from responder perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditFindDocumentReferences-responder.html).
