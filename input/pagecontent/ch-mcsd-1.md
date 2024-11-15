This section corresponds to transaction [CH:mCSD-1]. Transaction [CH:mCSD-1] is used by the Care Services Source and 
Care Services Directory Actors.

### Scope

The Care Services Feed [CH:mCSD-1] transaction is used to add, update and delete Care Services information from the
Care Services Source to the Care Services Directory.

### Actor Roles

**Actor:** Care Services Source<br>
**Role:** Prepares and issues an add, update, or delete request to Care Services resources<br>
**Actor:** Care Services Directory<br>
**Role:** Accepts add, update, or delete requests to Care Services resources

### Referenced Standards

1. This Profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include mCSD_ActorDiagram_CH-1.svg %}</div>

#### Add Care Service Request Message

The Add Care Service Request Message provides the ability to submit new care service resources (Practitioner,
PractitionerRole or Organization) to a directory.

##### Trigger Events

The Add Care Service Request Message is triggered when a Care Services Source needs to transmit new Care Services resource.

##### Message Semantics

A Care Services Source initiate a [FHIR Create operation](https://hl7.org/fhir/R4/http.html#create) on a 
Practitioner, PractitionerRole or Organization resource, with a standalone HTTP request or a
[batch transaction](https://hl7.org/fhir/R4/http.html#transaction).

A Care Services Source shall send a request for either the JSON or the XML format as defined in FHIR. A Care Services
Directory shall support the JSON and the XML format.

The Care Services Directory shall be capable of accepting elements specified in the profiles
[CH mCSD Practitioner](StructureDefinition-CH.mCSD.Practitioner.html),
[CH mCSD PractitionerRole](StructureDefinition-CH.mCSD.PractitionerRole.html) and
[CH mCSD Organization](StructureDefinition-CH.mCSD.Organization.html).

##### Example

```http
POST [base]/Organization HTTP/1.1
Content-Type: application/fhir+json
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00

{
  // Content of the Organization to add
}
```

##### Expected Actions

The Care Services Directory shall provide a [CapabilityStatement](CapabilityStatement-CH.mCSD.CareServicesDirectory.html)
with the capabilities interaction and indicate that Create is available on the Practitioner, PractitionerRole and 
Organization resources.

The Care Services Directory shall process the Add Care Services Request Message.

##### Response Message

See [https://hl7.org/fhir/R4/http.html#create](https://hl7.org/fhir/R4/http.html#create) for the response.

#### Update Care Service Request Message

The Update Care Service Request Message provides the ability to submit updated care service resources (Practitioner,
PractitionerRole or Organization) to a directory.

##### Trigger Events

The Update Care Service Request Message is triggered when a Care Services Source needs to transmit updated Care 
Services resource.

##### Message Semantics

A Care Services Source initiate a [FHIR Update operation](https://hl7.org/fhir/R4/http.html#update) on a 
Practitioner, PractitionerRole or Organization resource, with a standalone HTTP request or a
[batch transaction](https://hl7.org/fhir/R4/http.html#transaction).

A Care Services Source shall send a request for either the JSON or the XML format as defined in FHIR. A Care Services
Directory shall support the JSON and the XML format.

The Care Services Directory shall be capable of accepting elements specified in the profiles 
[CH mCSD Practitioner](StructureDefinition-CH.mCSD.Practitioner.html),
[CH mCSD PractitionerRole](StructureDefinition-CH.mCSD.PractitionerRole.html) and
[CH mCSD Organization](StructureDefinition-CH.mCSD.Organization.html).

##### Example

```http
PUT [base]/Organization/org-723 HTTP/1.1
Content-Type: application/fhir+json
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00

{
// Content of the Organization to update
}
```

##### Expected Actions

The Care Services Directory shall provide a [CapabilityStatement](CapabilityStatement-CH.mCSD.CareServicesDirectory.html)
with the capabilities interaction and indicate that Conditional Update is available on the Practitioner, 
PractitionerRole and Organization resources.

The Care Services Directory shall process the Update Care Services Request Message.
If the search parameters identify multiple resources, the Care Services Directory shall return an error.

##### Response Message

See [https://hl7.org/fhir/R4/http.html#update](https://hl7.org/fhir/R4/http.html#update) for the response.

#### Delete Care Service Request Message

The Delete Care Service Request Message provides the ability to delete care service resources (Practitioner,
PractitionerRole or Organization) from a directory.

##### Trigger Events

The Delete Care Service Request Message is triggered when a Care Services Source wants to delete Care Services resource.

##### Message Semantics

A Care Services Source initiate a [FHIR Delete operation](https://hl7.org/fhir/R4/http.html#delete) on a 
Practitioner, PractitionerRole or Organization resource, with a standalone HTTP request or a
[batch transaction](https://hl7.org/fhir/R4/http.html#transaction).

##### Example

```http
DELETE [base]/Practitioner/hcp-42 HTTP/1.1
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00
```

##### Expected Actions

The Care Services Directory shall provide a [CapabilityStatement](CapabilityStatement-CH.mCSD.CareServicesDirectory.html)
with the capabilities interaction and indicate that Conditional Delete is available on the Practitioner,
PractitionerRole and Organization resources.

The Care Services Directory shall process the Delete Care Services Request Message.
If the search parameters identify multiple resources, the Care Services Directory shall return an error.

##### Response Message

See [https://hl7.org/fhir/R4/http.html#delete](https://hl7.org/fhir/R4/http.html#delete) for the response.

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
_Care Services Directory_ using the IUA profile with basic access token. Consequently the
_Add/Update/Delete Care Services_ [CH:mCSD-1] request must authorize using the
[[ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction of the IUA profile.

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).

#### Security Audit Considerations

The **Care Services Source** and **Care Services Directory** shall record the right audit event for the operations:

- [CH Audit Event for [CH:mCSD-1] Care Services Source & Directory / **Add**](StructureDefinition-ChAuditEventmCSD1Create.html)
  ([example](AuditEvent-ChAuditEventmCSD1CreateExample.html)).
- [CH Audit Event for [CH:mCSD-1] Care Services Source & Directory / **Update**](StructureDefinition-ChAuditEventmCSD1Update.html)
  ([example](AuditEvent-ChAuditEventmCSD1UpdateExample.html)).
- [CH Audit Event for [CH:mCSD-1] Care Services Source & Directory / **Delete**](StructureDefinition-ChAuditEventmCSD1Delete.html)
  ([example](AuditEvent-ChAuditEventmCSD1DeleteExample.html)).

### Consideration when implementing the mCSD profile with an LDAP backend (HPD)

When implementing the mCSD profile with an LDAP backend (such as the HPD), 

- An informative mapping between the FHIR resources and the LDAP entries is provided in the mapping tab of the 
  respective FHIR profiles.
- When the Source adds a new Care Services resource, the FHIR gateway doing the mapping is responsible for determining
  the LDAP DN of the new entry (either by using the provided LDAP DN, if any, or by generating a new one).
- When the Source updates or delete a Care Services resource, the FHIR gateway is responsible for finding the 
  corresponding LDAP entry, using the provided resource id.
