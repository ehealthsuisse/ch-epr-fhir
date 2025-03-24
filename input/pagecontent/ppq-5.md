### Scope

This transaction is used by the Policy Consumer to retrieve policy sets. The only HTTP method which SHALL be supported
is `GET`.

### HTTP Method GET

<figure>
  {% include PPQm-5_actor_diagram.svg %}
  <figcaption>Figure 6: PPQ-5: HTTP Method GET</figcaption>
</figure>

#### Trigger Events

The Policy Consumer sends this message to retrieve existing policy sets from the Policy Repository.

#### Request Message

The request body SHALL be empty.

The request SHALL be sent:
- For querying by patient ID — to `[baseUrl]/Consent?patient:identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|[epr-spid]`.
- For querying by policy set ID — to `[baseUrl]/Consent?identifier=[uuid]`.

In the both cases, additional search criteria MAY be provided.

#### Expected Actions

Upon receiving the HTTP `GET` request, the Policy Repository SHALL create a PPQ-5 response according to the transaction
outcome.

#### Response Message

The PPQ-5 response SHALL be created according to the section
[3.1.0.9](https://hl7.org/fhir/R4/http.html#search) of the FHIR R4 specification. If the response body
is a Bundle, then it SHALL comply to the
[PpqmRetrieveResponseBundle](StructureDefinition-PpqmRetrieveResponseBundle.html) profile. 

### Security Considerations

TLS SHALL be used. For user authentication and authorization, the IUA profile with extended access token SHALL be used
as described in the Amendment mHealth of Annex 5, Section 3.2. Consequently, the Mobile Privacy Policy Retrieve [PPQ-5]
transaction SHALL be combined with the Incorporate Access Token
[[ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction of the IUA
profile.

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).

The **Policy Consumer** shall record a
[CH Audit Event for [PPQ-5] Policy Consumer](StructureDefinition-ChAuditEventPpq5Consumer.html).

The **Policy Repository** shall record a
[CH Audit Event for [PPQ-5] Policy Repository](StructureDefinition-ChAuditEventPpq5Repository.html).
