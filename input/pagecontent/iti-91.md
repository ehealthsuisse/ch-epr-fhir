This section documents additional requirements in the Swiss EPR context on the Request Care Services Updates.

### Scope

A mHealth application wants to duplicate the registry of healthcare organizations and professionals to perform local
operations on it. It can perform an ITI-91 request with a parameter to get the list of changes to the
registry since the given date and time.

It offers an alternative to the HPD CH:PIDD transaction.

### Actor Roles

**Actor:** Care Services Update Consumer<br>
**Role:** Requests a list of updated resources from the Care Services Update Supplier.<br>
**Actor:** Care Services Update Supplier<br>
**Role:** Accepts the update request and returns a list of updated resources.

### Referenced Standards

[IHE ITI Mobile Care Services Discovery (mCSD) 3.8.0](https://profiles.ihe.net/ITI/mCSD/3.8.0/)<br>
[FHIR R4 API history](http://hl7.org/fhir/R4/http.html#history)

### Messages

<div>{% include mCSD_ActorDiagram_ITI-91.svg %}</div>

#### Request Message Semantics

A Care Services Update Consumer initiates a history request using HTTP GET: 
`GET [base]/_history{?[parameters]&_format=[mime-type]}`.

The following [search parameters] are supported:

- **\_since**: Only include resource versions that were created at or after the given instant in time. It is 
  equivalent to CH:PIDD's ??.
- **\_count**: The maximum number of search results on a page. It is equivalent to CH:PIDD's _pageSize_.
- **\_pageNumber**: The actual page requested (starting with 1). It is equivalent to CH:PIDD's _pageNumber_.
- **\_format**: Define the [expected response format], override the HTTP content negotiation.

#### Response Message Semantics

The response message is a [History Bundle].

If the response results are paged, `Bundle.link` contains a link to the next page of results (where `relation = next`).
The total number of results is shown in `Bundle.total`.

For an **addition** (equivalent to CH:PIDD's `<addRequest>`):

- `Bundle.entry[x].resource` contains the new resource.
- `Bundle.entry[x].request.method` equals `POST`.

For a **modification** (equivalent to CH:PIDD's `<modifyRequest>`):

- `Bundle.entry[x].resource` is ?
- `Bundle.entry[x].request.method` equals `PUT or PATCH?`.

For a **deletion** (equivalent to CH:PIDD's `<delRequest>`):

- `Bundle.entry[x].resource` is not present.
- `Bundle.entry[x].request.method` equals `DELETE`.
- `Bundle.entry[x].request.url` is ?

For all entries:

- `Bundle.entry[x].response.lastModified` contains the action effective date time.

No Location. Maybe no HealthcareService?

See the X example of a search response.

### Security Considerations

The actors involved shall record audit events according to ?

### Todo

For `<modifyRequest>`, do we go with PUT (full resource) or PATCH (differential only)? JsonPatch, XMLPatch or FHIRPath?

[search parameters](http://hl7.org/fhir/search.html#ptypes)
[expected response format](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.6-populating-the-expected-response-format)
[History Bundle](http://hl7.org/fhir/R4/bundle.html#history)
