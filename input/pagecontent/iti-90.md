This section documents additional requirements in the Swiss EPR context on the Request Care Services Updates.
The _Request Care Services Updates [ITI-91]_ transaction is not implemented.

### Scope

A mHealth application wants to search for healthcare organizations and/or healthcare professionals. It can perform an
[ITI-90](iti-90.html) request with search parameters to get a list of matched resources.

It offers an alternative to the HPD ITI-58 transaction.

### Actor Roles

**Actor:** Care Services Selective Consumer<br>
**Role:** Requests a list of resources from the Care Services Selective Supplier based on query parameters.<br>
**Actor:** Care Services Selective Supplier<br>
**Role:** Accepts the query request and returns a list of matching resources.<br>

### Referenced Standards

1. [IHE ITI Mobile Care Services Discovery (mCSD) 3.8.0](https://profiles.ihe.net/ITI/mCSD/3.8.0/)<br>
2. [FHIR R4 API history](http://hl7.org/fhir/R4/http.html#history)<br>
3. [EPR – Central Services, Interface Documentation v1.0.40](https://www.e-health-suisse.ch/en/technik-semantik/epr-projectathon/epr-programming-aids/relevant-specifications.html#CentServRes)

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

The Care Services Selective Supplier shall support the following modifiers in all of the string query parameters below.
```
:contains -> <substrings><any />
:exact -> <equalityMatch><value />
```

The Care Services Selective Supplier shall support the following search parameters as defined at http://hl7.org/fhir/R4/search.html#all.
```
_id -> search by DN?
_lastUpdated -> modifyTimestamp? Maybe not available for Relationships.
```

The Care Services Selective Supplier shall also support the following prefixes for the _lastUpdated parameter:
```
gt -> no equivalent in DSML2
lt -> no equivalent in DSML2
ge -> <greaterOrEqual />
le -> <lessOrEqual />
sa -> no equivalent in DSML2
eb -> no equivalent in DSML2
```

The Care Services Selective Supplier shall support the following search parameters on the Organization Resource as defined at http://hl7.org/fhir/R4/organization.html#search. String parameter modifiers are defined at http://hl7.org/fhir/R4/search.html#string.
```
active -> ok, mapped
identifier -> ok, mapped
name -> ok, mapped
partof -> ok, could be implemented as two DSML2 search queries
type -> could be ok, two mappings on type
_include=Organization.endpoint -> not mapped
_revInclude=Location:organization -> not implemented
_revInclude=OrganizationAffiliation:participating-organization-> not implemented
_revInclude=OrganizationAffiliation:primary-organization-> not implemented
```

The Care Services Selective Supplier shall support the following search parameters on the Practitioner Resource as defined at http://hl7.org/fhir/R4/practitioner.html#search. String parameter modifiers are defined at http://hl7.org/fhir/R4/search.html#string.
```
active -> badly mapped
identifier -> ok, mapped
name -> could be ok but no direct equivalent in DSML2
given -> ok, mapped
family -> ok, mapped
```

The Care Services Selective Supplier shall support the following search parameters on the PractitionerRole Resource 
as defined at [http://hl7.org/fhir/R4/practitionerrole.html#search] (http://hl7.org/fhir/R4/practitionerrole.html#search).
```
active -> no mapping, always true?
location -> not implemented
organization -> could be ok
practitioner -> could be ok
role -> not mapped
service -> not mapped
specialty -> not mapped
_include=PractitionerRole:practitioner -> useless, we have it required
```

HPD does not support paging and sorting at the same time.
Paging uses a cookie -> pass it in URL.


- **\_count**: The maximum number of search results on a page. It is equivalent to CH:PIDD's _pageSize_.
- **\_pageNumber**: The actual page requested (starting with 1). It is equivalent to CH:PIDD's _pageNumber_.
- **\_format**: Define the
- [expected response format](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.6-populating-the-expected-response-format)
  , override the HTTP content negotiation.


#### Find Matching Care Services Response Message Semantics

The response message is a [Search Results Bundle](http://hl7.org/fhir/R4/bundle.html#searchset) that contains
[Organizations](StructureDefinition-CH.mCSD.Organization.html),
[Practitioners](StructureDefinition-CH.mCSD.Practitioner.html) and
[PractitionerRoles](StructureDefinition-CH.mCSD.Practitionerrole.html).
Endpoint, HealthcareService, Location and OrganizationAffiliation are not implemented in this profile.

If the response results are paged, `Bundle.link` contains a link to the next page of results (where `relation =
next`), if any.
The total number of results is shown in `Bundle.total`.

### Security Considerations

The actors involved shall record audit events according to TODO?

### Todo

#### PractitionerRole

`code` is required, but Relationships contains only the Practitioner and the Organization references.

`specialty` could be mapped to HCProfessional.hcSpecialisation?

Mappings between PractitionerRole and Relationship put pressure on implementation.
