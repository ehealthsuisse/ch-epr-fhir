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

TLS SHALL be used. For user authentication and authorization, the IUA profile with extended access token SHALL be used
as described in the Amendment mHealth of Annex 5, Section 3.2. Consequently, the Mobile Privacy Policy Bundle Feed
[PPQ-4] transaction SHALL be combined with Incorporate Access Token
[[ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction of the IUA
profile.

The `traceparent` header is required, as described in [Trace Context header](tracecontext.html).

The involved actors SHALL record audit events. The Policy Source SHALL use the ATNA FHIR Feed option thereby, the
Policy Repository SHALL use either the ATNA FHIR Feed option or the ATNA TLS Syslog option.

The audit records correspond to the ones of PPQ-1, with the following adaptations:
- `EventTypeCode` SHALL be set to `EV("PPQ-4", "e-health-suisse", "Mobile Privacy Policy Bundle Feed")`.
- The Destination User ID SHALL be the FHIR endpoint URI of the Policy Repository.
