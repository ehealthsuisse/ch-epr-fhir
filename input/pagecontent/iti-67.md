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

####  Expected Actions

The Document Responder SHALL process the query to discover the DocumentReference entries that match the search parameters given.

The Document Responder SHALL support search page count requests from the Document Consumer of up to 100 resources.

The Document Responder SHALL set the `DocumentReference.content.attachment.url` value to the URL used in ITI-68 
transactions to retrieve that document's content.

##### Federated Cross Community Access Option

If the Document Responder supports the Federated Cross Community Access Option the Document Responder SHALL delegate the queries
to the different connected communities and aggregate and sort the results including the results of his own community.

The Document Responder SHALL freeze the result set from the federated cross community queries and allow paged access by the Document Consumer. 
Subsequent query to an individual result by the Document Consumer SHALL return the current resource, not the frozen one. 

{% include iti-mhd-fxca-query.html %}

#### Find Document References Response Message

The response Bundle SHALL follow the [CH MHD Find Document References Comprehensive Response message](StructureDefinition-ch-mhd-documentreference-comprehensive-bundle.html)
Profile ([example: MHD Find DocumentReferences](Bundle-Bundle-FindDocumentReferences.html)).

##### Federated Cross Community Access Option

If a Document Responder does not respond, an OperationOutcome with a severity warning SHALL be added to the aggregated results indicating the community does not respond.

For matching DocumentReferences returned by the Document Responder, the Document Responder SHALL ensure by rewriting the id and attachment.url that follow-up reads, updates or document retrieval will be handled by same Document Responder actor. Any id, url rewrite SHALL be resolvable for at least an hour.

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Document Consumer** is [MHD Document Consumer](CapabilityStatement-CH.MHD.DocumentConsumer.html).

The CapabilityStatement resource for the **Document Responder** is [MHD Document Responder](CapabilityStatement-CH.MHD.DocumentResponder.html).

### Security Consideration

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with
server certificates. Transactions across communities SHALL use mTLS.

The transaction SHALL use client authentication and authorization using one of the following strategies:
1. Use an extended access token defined in [IUA](iti-71.html) conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.
2. or, use mutual authentication (mTLS) on the transport layer in combination with a XUA token for authorization from the Get X-User Assertion transaction (Annex 5.1 1.6.4.2). The XUA token SHALL be conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.

All Document Responders except the one with the Federated Cross Community Access Option SHALL be grouped with the Authorization Decision Consumer actor of the CH:ADR profile
defined in Extension 2.1 to Annex 5 of the ordinances and perform an Authorization Decision Request [CH:ADR] for
every Find Document References [ITI-67] response (when the response is delivered as multiple pages, the Document
Responder SHALL issue an Authorization Decision Request [CH:ADR] for the first page, and for each subsequent 
page either reuse the obtained Authorization Decision or repeat the Authorization Decision Request).

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).

#### Security Audit Considerations

##### Document Consumer Audit

The **Document Consumer** shall record a
[CH Audit Event for [ITI-67] Document Consumer](StructureDefinition-ChAuditEventIti67Consumer.html) 
([example](AuditEvent-ChAuditEventIti67ConsumerExample.html)).

##### Document Responder Audit

The **Document Responder** shall record a
[CH Audit Event for [ITI-67] Document Responder](StructureDefinition-ChAuditEventIti67Responder.html)
([example](AuditEvent-ChAuditEventIti67ResponderExample.html)).
