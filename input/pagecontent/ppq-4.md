### Scope

This transaction is used by the Policy Source to add, update, or delete a set of privacy policies. The only HTTP
method which SHALL be supported is `POST`.

### HTTP Method POST

<figure>
  {% include PPQm-4_actor_diagram.svg %}
  <figcaption>Figure 5: PPQ-4: HTTP Method POST</figcaption>
</figure>

#### Trigger Event

The Policy Source uses HTTP method `POST` to perform an operation on a set of privacy policies in the Policy Repository,
as an ACID transaction.

#### Request Message

The request body SHALL represent a single Bundle resource compliant to the
[PpqmFeedRequestBundle](StructureDefinition-PpqmFeedRequestBundle.html) profile.

The request SHALL be sent to `[baseUrl]`.

#### Expected Actions

Upon receiving the HTTP `POST` request, the Policy Repository SHALL:
- Validate the Bundle resource contained in the request body.
- On each request entry, perform the operation specified the attribute `entry.request.method` on the embedded or
referenced [PpqmConsent](StructureDefinition-PpqmConsent.html) resource:
  - "POST" — add policy set.
  - "PUT" — update policy set if it is already present, otherwise add it.
  - "DELETE" — delete policy set.
- Create a PPQ-4 response according to the transaction outcome.

#### Response Message

The PPQ-4 response SHALL be created according to the section
[3.1.0.11](https://hl7.org/fhir/R4/http.html#transaction) of the FHIR R4 specification.

### Security Considerations

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with
server certificates.

The transaction SHALL use client authentication and authorization using one of the following strategies:
1. Use an extended access token defined in [IUA](iti-71.html) conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.
2. or, use mutual authentication (mTLS) on the transport layer in combination with a XUA token for authorization from the Get X-User Assertion transaction (Annex 5.1 1.6.4.2). The XUA token SHALL be conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.

The Policy Repository actor shall be grouped with CH:ADR, i.e. the Policy Repository shall use the CH:ADR Authorization
Decision Request transaction to authorize the transaction and enforce the authorization decision retrieved from CH:ADR
Authorization Decision Response.

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).

#### Security Audit Considerations

The **Policy Source** and **Policy Repository** SHALL record the right [PPQ-3] audit event for each operation in the 
transaction:

- [CH Audit Event for [PPQ-3] **Create** Privacy Policy](StructureDefinition-ChAuditEventPpq3Create.html)
- [CH Audit Event for [PPQ-3] **Update** Privacy Policy](StructureDefinition-ChAuditEventPpq3Update.html)
- [CH Audit Event for [PPQ-3] **Delete** Privacy Policy](StructureDefinition-ChAuditEventPpq3Delete.html)

All audit events may be sent to the Audit Record Repository in a single Bundle (ITI-20 Send Audit Bundle Request).
[Example of such a Bundle](Bundle-ChAuditEventPpq4Example.html).
