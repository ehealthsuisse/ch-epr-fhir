This section describes the additional requirements for the Swiss EPR of the [Find Document Lists
[ITI-66]](https://profiles.ihe.net/ITI/MHD/ITI-66.html) transaction defined in the MHD Profile published in the IHE ITI
Trial Implementation “Mobile Access to Health Documents”. The SubmissionSet.Author.AuthorRole mapping to 
DocumentManifest has to be supported.

### Scope

The Find Document Lists [ITI-66] transaction is used to find List Resources
that satisfy a set of parameters. It is equivalent to the FindSubmissionSets query in the Registry
Stored Query [ITI-18](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html) transaction, as documented in [ITI TF-2: 3.18.4.1.2.3.7.2](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html#3.18.4.1.2.3.7.2).
The result of the query is a Bundle containing List Resources that match the query parameters.

### Actor Roles

**Actor:** Document Consumer   
**Role:** Requests List Resources, matching the supplied set of criteria, from the Document Responder   
**Actor:** Document Responder   
**Role:** Returns List Resources that match the search criteria provided by the Document Consumer   

### Referenced Standards

1. [Mobile access to Health Documents (MHD), Rev. 4.2.1 – Trial-Implementation,  August 2, 2023](https://profiles.ihe.net/ITI/MHD/index.html)   
2. This MHD Profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include MHD_ActorDiagram_ITI-66.svg %}</div>

#### Find Document Lists Request Message

The Document Consumer SHALL include the search parameter patient.identifier with the oid of the EPR-SPID.

_Find Document List_ example **request**:
```http
GET [base]/List?patient.identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|761337610411353650&&status=current HTTP/1.1
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00
```


#### Find Document Lists Response Message

The response Bundle SHALL follow the [CH MHD SubmissionSet Comprehensive Bundle](StructureDefinition-ch-mhd-submissionset-comprehensive-bundle.html)
Profile ([example: MHD Find DocumentSubmissionSet (List)](Bundle-Bundle-FindSubmissionSets.html)).

The **Document Responder** does not need to support the FindFolders Query from the XDS on FHIR Option.

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Document Consumer** is [MHD Document Consumer](CapabilityStatement-CH.MHD.DocumentConsumer.html).

The CapabilityStatement resource for the **Document Responder** is [MHD Document Responder](CapabilityStatement-CH.MHD.DocumentResponder.html).

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the Document 
Responder using the IUA profile with extended access token. Consequently the _Find Document Lists_ [ITI-66] request 
must authorize using the [[ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction of the IUA profile.

The `traceparent` header is required, as described in [Trace Context header](tracecontext.html).

#### Security Audit Considerations

##### Document Consumer Audit

The **Document Consumer** shall be able to record a
[Find Document Lists Consumer Audit Event Log](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.FindDocumentLists.Audit.Consumer.html).
[Audit Example for a Find Document Lists Transaction from Consumer perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditFindDocumentLists-consumer.html).

##### Document Responder Audit

The **Document Responder** shall be able to record a
[Find Document Lists Responder Audit Event Log](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.FindDocumentLists.Audit.Responder.html).
[Audit Example for a Find Document Lists Transaction from Responder perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditFindDocumentLists-responder.html).
