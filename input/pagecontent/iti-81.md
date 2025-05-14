### Constraints on Retrieve ATNA Audit Event [ITI-81]

The Retrieve ATNA Audit Event [ITI-81] transaction is defined in [IHE ITI TF-2](https://profiles.ihe.net/ITI/TF/Volume2/index.html) and the [IHE ITI Supplement Add RESTful Query to ATNA](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf). The following rules shall be applied for the CH:ATC profile.

#### Message Semantics

The Retrieve ATNA Audit Event message shall be a HTTP GET request sent to the Patient Audit Record Repository. This message is a FHIR search (see [http://hl7.org/fhir/R4/search.html](http://hl7.org/fhir/R4/search.html)) on AuditEvent Resources (see [http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html)). This "search" target is formatted as:

``` http
<scheme>://<authority>/<path>/AuditEvent?date=ge[start-time]&date=le[stop-time]&<query>
```

where:

<ol type="a">
  <li>
    <code>&lt;scheme&gt;</code> shall be https.
  </li>
  <li>
    <code>&lt;query&gt;</code> shall include the entity.identifier as defined in <a href="#additional-atna-search-parameters">Additional ATNA Search Parameters</a> and may include additional ATNA Search parameters. If entity.identifier is not included an HTTP response code 400 - Bad Request shall be returned.
  </li>
</ol>


#### Additional ATNA Search Parameters

The Patient Audit Consumer shall not use the following parameters in a query parameters: address, patient.identifier, source, type, outcome. The Patient Audit Consumer may use other parameters as listed in Retrieve Audit Event [ITI-81].

**entity.identifier** is a parameter of token type. This parameter specifies unique identifier for the object. The parameter value should be identified in accordance to the entity type;   
For example:   
``` http
http://example.com/ARRservice/AuditEvent?date=ge2020-03-22&date=le2025-03-22&entity.identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|5678
```

The Audit Record Repository shall match this parameter with the AuditEvent.entity.what.identifier field that is of type identifier (ParticipantObjectID in DICOM schema).

For the CH:ATC profile the entity.identifier has to be the EPR-SPID:   
`entity.identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|<<<value EPR-SPID>>>`


#### Message Semantics for Response

The returned AuditEvent FHIR resources in the Bundle shall conform the CH:ATC AuditEvent profile, see [Volume 3 - Content Profiles](volume-3.html).


#### Security Considerations

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with
server certificates.

The transaction SHALL use client authentication and authorization using one of the following strategies:
1. Use an extended access token defined in [IUA](iti-71.html) conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.
2. or, use mutual authentication (mTLS) on the transport layer in combination with a XUA token for authorization from the Get X-User Assertion transaction (Annex 5.1 1.6.4.2). The XUA token SHALL be conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.

The CH:ATC Patient Audit Record Repository shall be grouped with CH:ADR, i.e. the CH:ATC Patient Audit Record Repository shall use the CH:ADR Authorization Decision Request transaction to authorize the transaction and enforce the authorization decision retrieved from CH:ADR Authorization Decision Response.

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).

#### Security Audit Considerations
An audit event as specified in [Access Audit Trail Content Profile](volume-3.html#access-audit-trail-content-profile) shall be returned by a query to Patient Audit Record Repository after the Patient Audit Record Repository has been queried by a Patient Audit Consumer.
