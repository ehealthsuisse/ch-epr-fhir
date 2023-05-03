This section documents additional requirements in the Swiss EPR context on the Request Care Services Updates.

### Scope

A mHealth application wants to search for healthcare organizations and/or healthcare professionals. It can perform an
[ITI-90](iti-90.html) request with search parameters to get a list of matched resources.

It offers an alternative to the HPD ITI-58 transaction.

### Actor Roles

**Actor:** Care Services Selective Consumer<br>
**Role:** Requests a list of resources from the Care Services Selective Supplier based on query parameters.<br>
**Actor:** Care Services Selective Supplier<br>
**Role:** Accepts the query request and returns a list of matching resources.

### Referenced Standards

[IHE ITI Mobile Care Services Discovery (mCSD) 3.8.0](https://profiles.ihe.net/ITI/mCSD/3.8.0/)<br>
[FHIR R4 API history](http://hl7.org/fhir/R4/http.html#history)

### Messages

<div>{% include mCSD_ActorDiagram_ITI-90.svg %}</div>

#### Find Matching Care Services Request Message Semantics

A Care Services Selective Consumer initiates a history request using HTTP GET:

- `GET [base]/[type]{?[parameters]{&_format=[mime-type]}}` to search for a specific type;
- `GET [base]?_type=[types]&[parameters]{&_format=[mime-type]}` to search for multiples types; and 
- `GET [base]?[parameters]{&_format=[mime-type]}` to search for all types.

There's a lot of search parameters to list here.

| Parameter  | Modifiers | Description |
|------------|-----------|-------------|

#### Find Matching Care Services Response Message Semantics

The response message is a [Search Results Bundle].

#### Retrieve Care Services Resource Request Message Semantics
#### Retrieve Care Services Resource Response Message Semantics

### Todo

Do we support "Retrieve Care Services Resource"? The HPD had no query to retrieve one resource by identifier.

[Search Results Bundle](http://hl7.org/fhir/R4/bundle.html#searchset)
