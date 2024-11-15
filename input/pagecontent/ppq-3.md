### Scope

This transaction is used by the Policy Source to add, update, or delete single privacy policies. Correspondingly, the
following HTTP methods SHALL be supported: `POST`, `PUT`, and `DELETE`.

### HTTP Method POST

<figure>
  {% include PPQm-3_post_actor_diagram.svg %}
  <figcaption>Figure 2: PPQ-3: HTTP Method POST</figcaption>
</figure>

#### Trigger Event

The Policy Source uses HTTP method `POST` to submit a single new privacy policy to the Policy Repository.

#### Request Message

The request body SHALL represent a single Consent resource compliant to the
[PpqmConsent](StructureDefinition-PpqmConsent.html) profile.

The request SHALL be sent to `[baseUrl]/Consent`.

#### Expected Actions

Upon receiving the HTTP POST request, the Policy Repository SHALL:
-	Validate the Consent resource contained in the request body.
-	Persist the policy set represented by this Consent.
-	Create a PPQ-3 response according to the transaction outcome.

#### Response Message

The PPQ-3 response SHALL be created according to the section
[3.1.0.8](https://hl7.org/fhir/R4/http.html#create) of the FHIR R4 specification.

### HTTP Method PUT

<figure>
  {% include PPQm-3_put_actor_diagram.svg %}
  <figcaption>Figure 3: PPQ-3: HTTP Method PUT</figcaption>
</figure>

#### Trigger Event

The Policy Source uses HTTP method `PUT` to submit a new or update an existing single privacy policy.

#### Request Message

The request body SHALL represent a single Consent resource compliant to the
[PpqmConsent](StructureDefinition-PpqmConsent.html) profile.

The request SHALL be sent to `[baseUrl]/Consent?identifier=[uuid]`.

#### Expected Actions

The Policy Repository SHALL implement the Conditional Update pattern described in section
[3.1.0.4.3](https://hl7.org/fhir/R4/http.html#cond-update) of the FHIR R4 specification.

Upon receiving the HTTP PUT request, the Policy Repository SHALL:
- Validate the Consent resource contained in the request body. In particular, it SHALL be validated that the policy set
ID is the same as in the HTTP URL.
- Persist the policy set represented by this Consent.
- Create a PPQ-3 response according to the transaction outcome.

#### Response Message

The PPQ-3 response SHALL be created according to the section
[3.1.0.4](https://hl7.org/fhir/R4/http.html#update) of the FHIR R4 specification.

###	HTTP Method DELETE

<figure>
  {% include PPQm-3_delete_actor_diagram.svg %}
  <figcaption>Figure 4: PPQ-3: HTTP Method DELETE</figcaption>
</figure>

#### Trigger Event

The Policy Source uses HTTP method `DELETE` to delete a single existing privacy policy from the Policy Repository.

#### Request Message

The request body SHALL be empty.

The request SHALL be sent to `[baseUrl]/Consent?identifier=[uuid]`.

#### Expected Actions

The Policy Repository SHALL implement the Conditional Delete pattern described in section 
[3.1.0.7.1](https://hl7.org/fhir/R4/http.html#3.1.0.7.1) of the FHIR R4 specification. 

Upon receiving the HTTP DELETE request, the Policy Repository SHALL:
-	Delete the policy set referenced in the request.
-	Create a PPQ-3 response according to the transaction outcome.

#### Response Message

The PPQ-3 response SHALL be created according to the section
[3.1.0.7](https://hl7.org/fhir/R4/http.html#delete) of the FHIR R4 specification.

### Security Considerations

TLS SHALL be used. For user authentication and authorization, the IUA profile with extended access token SHALL be used
as described in the Amendment mHealth of Annex 5, Section 3.2. Consequently, the Mobile Privacy Policy Feed [PPQ-3]
transaction SHALL be combined with the Incorporate Access Token
[[ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction of the IUA
profile.

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).

The **Policy Source** and **Policy Repository** SHALL record the right audit event for the operations:

- [CH Audit Event for [PPQ-3] **Create** Privacy Policy](StructureDefinition-ChAuditEventPpq3Create.html)
- [CH Audit Event for [PPQ-3] **Update** Privacy Policy](StructureDefinition-ChAuditEventPpq3Update.html)
- [CH Audit Event for [PPQ-3] **Delete** Privacy Policy](StructureDefinition-ChAuditEventPpq3Delete.html)