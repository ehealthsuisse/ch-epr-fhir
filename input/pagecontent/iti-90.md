This section documents additional requirements in the Swiss EPR context on the Request Care Services Updates.
The _Request Care Services Updates [ITI-91]_ transaction is not implemented.

### Scope

A mHealth application wants to search for healthcare organizations and/or healthcare professionals. It can perform an
[ITI-90](iti-90.html) request with search parameters to get a list of matched resources.

It offers an alternative to the HPD ITI-58 transaction.

### Actor Roles

**Actor:** Care Services Selective Consumer<br>
**Role:** Requests a list of resources from the Care Services Selective Supplier based on query parameters.<br>

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

| Parameter | Modifiers | Description |
|-----------|-----------|-------------|
| A         | B         | C           |

#### Find Matching Care Services Response Message Semantics

The response message is a [Search Results Bundle](http://hl7.org/fhir/R4/bundle.html#searchset) that contains
[Organizations](StructureDefinition-ch-mcsd-organization.html),
[Practitioners](StructureDefinition-ch-mcsd-practitioner.html) and
[PractitionerRoles](StructureDefinition-ch-mcsd-practitionerrole.html).

If the response results are paged, `Bundle.link` contains a link to the next page of results (where `relation =
next`), if any.
The total number of results is shown in `Bundle.total`.

