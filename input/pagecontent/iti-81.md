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
https://example.com/ARRservice/AuditEvent?date=ge2020-03-22&date=le2025-03-22&entity.identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|5678
```

The Audit Record Repository shall match this parameter with the AuditEvent.entity.what.identifier field that is of type identifier (ParticipantObjectID in DICOM schema).

For the CH:ATC profile the entity.identifier has to be the EPR-SPID:   
`entity.identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|<<<value EPR-SPID>>>`


#### Message Semantics for Response

The returned AuditEvent FHIR resources in the Bundle shall conform the CH:ATC AuditEvent profile, see [Volume 3 - Content Profiles](volume-3.html).


#### Security Considerations

The transaction is used to exchange sensitive information and requires authentication and authorization. This profile requires all actors to be grouped with Secure Node or Secure Application implementing the "STX: TLS 1.2 floor using BCP195 Option" defined in the [IHE ITI TF-2, chapter 3.19.6.2.3](https://profiles.ihe.net/ITI/TF/Volume2/ITI-19.html#3.19.6.2.3).

Access control shall be implemented by grouping the CH:ATC Audit Consumer and Audit Record Repository with the Authorization Client and Resource Server from the IUA trial implementation profile using the SAML Token option (see [IHE ITI Supplement IUA , chapter 3.72.4.3.2](https://profiles.ihe.net/ITI/IUA/index.html#372432-saml-token-option)). As defined therein, the CH:ATC Audit Consumer and Audit Record Repository shall implement the Incorporate Authorization Token [ITI-72] transaction to convey the XUA token.

The actors shall implement the Incorporate Authorization Token [ITI-72] transaction with SAML token option, using the base64url encoded SAML assertion defined in XUA to the authorization header of the HTTP1.1 GET request with key "Bearer" as follows:
``` http
GET /example/url/to/resource/location HTTP/1.1
Authorization: Bearer fFBGRNJru1FQd[…omitted for brevity…]44AzqT3Zg
Host: examplehost.com
```

The CH:ATC Patient Audit Record Repository shall be grouped with CH:ADR, i.e. the CH:ATC Patient Audit Record Repository shall use the CH:ADR Authorization Decision Request transaction to authorize the transaction and enforce the authorization decision retrieved from CH:ADR Authorization Decision Response.


#### Security Audit Considerations
An audit event as specified in [Access Audit Trail Content Profile](volume-3.html#access-audit-trail-content-profile) shall be returned by a query to Patient Audit Record Repository after the Patient Audit Record Repository has been queried by a Patient Audit Consumer.
