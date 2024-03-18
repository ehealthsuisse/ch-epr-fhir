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
[PpqmConsent profile](StructureDefinition-PpqmConsent.html).

The request SHALL be sent to `[baseUrl]/Consent`.

Here and in the whole document: Each FHIR URL may contain general parameters defined in the section 3.1.0.1.11 of the
FHIR R4 specification; they are not shown for brevity.

#### Expected Actions

Upon receiving the HTTP POST request, the Policy Repository SHALL:
-	Validate the Consent resource contained in the request body.
-	Persist the policy set represented by this Consent.
-	Create a PPQ 3 response according to the transaction outcome.

#### Response Message

The PPQ 3 response SHALL be created according to the section 3.1.0.8 of the FHIR R4 specification.

### HTTP Method PUT

<figure>
  {% include PPQm-3_put_actor_diagram.svg %}
  <figcaption>Figure 3: PPQ-3: HTTP Method PUT</figcaption>
</figure>

#### Trigger Event

The Policy Source uses HTTP method `PUT` to submit a new or update an existing single privacy policy.

#### Request Message

The request body SHALL represent a single Consent resource compliant to the
[PpqmConsent profile](StructureDefinition-PpqmConsent.html).

The request SHALL be sent to `[baseUrl]/Consent?identifier=[uuid]`.

#### Expected Actions

The Policy Repository SHALL implement the Conditional Update pattern described in section 3.1.0.4.3 of the FHIR R4
specification.

Upon receiving the HTTP PUT request, the Policy Repository SHALL:
- Validate the Consent resource contained in the request body. In particular, it SHALL be validated that the policy set
ID is the same as in the HTTP URL.
- Persist the policy set represented by this Consent.
- Create a PPQ 3 response according to the transaction outcome.

#### Response Message

The PPQ 3 response SHALL be created according to the section 3.1.0.4 of the FHIR R4 specification.

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

The Policy Repository SHALL implement the Conditional Delete pattern described in section 3.1.0.7.1 of the FHIR R4
specification. 

Upon receiving the HTTP PUT request, the Policy Repository SHALL:
-	Delete the policy set referenced in the request.
-	Create a PPQ 3 response according to the transaction outcome.

#### Response Message

The PPQ 3 response SHALL be created according to the section 3.1.0.7 of the FHIR R4 specification.

### Security Considerations

TLS SHALL be used. For user authentication and authorization, the IUA profile with extended access token SHALL be used
as described in the Amendment mHealth of Annex 5, Section 3.2. Consequently, the Mobile Privacy Policy Feed [PPQ 3]
transaction SHALL be combined with the Incorporate Access Token
[[ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction of the IUA
profile.

The involved actors SHALL record audit events. The Policy Source SHALL use the ATNA FHIR Feed option thereby, the
Policy Repository SHALL use either the ATNA FHIR Feed option or the ATNA TLS Syslog option.

The audit records correspond to the ones of PPQ 1, with the following adaptations:
-	`EventTypeCode` SHALL be set to `EV("PPQ-3", "e-health-suisse", "Mobile Privacy Policy Feed")`.
-	The Destination User ID SHALL be the FHIR endpoint URI of the Policy Repository.
