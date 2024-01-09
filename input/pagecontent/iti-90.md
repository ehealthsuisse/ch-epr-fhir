This section describes the national extension for the Swiss EPR to the [Find Matching Care Services
[ITI-90]](https://profiles.ihe.net/ITI/mCSD/ITI-90.html) transaction defined in the IUA profile published in the
IHE IT Infrastructure Technical Framework Trial Implementation “Mobile Care Services Discovery”.

### Scope

A primary system wants to search for healthcare organizations or professionals. It can perform an
[ITI-90](iti-90.html) request with search parameters to get a list of matched resources.

It offers an alternative to the HPD ITI-58 transaction.

### Actor Roles

**Actor:** Care Services Selective Consumer<br>
**Role:** Requests a list of resources from the Care Services Selective Supplier based on query parameters.<br>
**Actor:** Care Services Selective Supplier<br>
**Role:** Accepts the query request and returns a list of matching resources.<br>

### Referenced Standards

1. [IHE ITI Mobile Care Services Discovery (mCSD) 3.8.0](https://profiles.ihe.net/ITI/mCSD/3.8.0/)
2. [FHIR R4 API search](http://hl7.org/fhir/R4/http.html#search)
3. [EPR – Central Services, Interface Documentation v1.0.40](https://www.e-health-suisse.ch/en/technique/technical-interoperability/specifications-for-the-epr-implementation#CentServRes)

### Messages

<div>{% include mCSD_ActorDiagram_ITI-90.svg %}</div>

#### Find Matching Care Services Request Message

The _Find Matching Care Services_ message is a FHIR search operation on the mCSD Resources.

A _Care Services Selective Consumer_ initiates a search request using HTTP GET or POST:

```
GET [base]/[resource]?[parameters]
```

or

```
POST [base]/[resource]/_search
Content-Type: application/x-www-form-urlencoded

param1=value&param2=value
```

##### Semantics

The _Care Services Selective Supplier_ shall support the following search parameters for all resources:

| Parameter    | Type   | Path                      | Modifiers | Description                                                                                                                           |
|--------------|--------|---------------------------|-----------|---------------------------------------------------------------------------------------------------------------------------------------|
| _id          | token  | Resource.id               |           |                                                                                                                                       |
| _lastUpdated | date   | Resource.meta.lastUpdated | ge, le    |                                                                                                                                       |
| _format      | token  | N/A                       |           | Defines the [expected response format](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.6-populating-the-expected-response-format) |
| _sort        |        | N/A                       |           | For [sorting](https://www.hl7.org/fhir/R4/search.html#sort)                                                                           |
| _count       | number | N/A                       |           | For [paging](https://www.hl7.org/fhir/R4/search.html#count)                                                                           |
{:class="table table-bordered"}

The _Care Services Selective Supplier_ shall support the following search parameters on the
**[Organization](StructureDefinition-CH.mCSD.Organization.html)** resource:

| Parameter                                                      | Type      | Path                       | Modifiers         | Description      |
|----------------------------------------------------------------|-----------|----------------------------|-------------------|------------------|
| active                                                         | token     | Organization.active        |                   |                  |
| identifier                                                     | token     | Organization.identifier    |                   |                  |
| name                                                           | string    | Organization.(name, alias) | :contains, :exact |                  |
| partof                                                         | reference | Organization.partOf        |                   |                  |
| type                                                           | token     | Organization.type          |                   |                  |
| _include=Organization.endpoint                                 |           |                            |                   | It has no effect |
| _revInclude=Location:organization                              |           |                            |                   | It has no effect |
| _revInclude=OrganizationAffiliation:participating-organization |           |                            |                   | It has no effect |
| _revInclude=OrganizationAffiliation:primary-organization       |           |                            |                   | It has no effect |
{:class="table table-bordered"}

The _Care Services Selective Supplier_ shall support the following search parameters on the
**[Practitioner](StructureDefinition-CH.mCSD.Practitioner.html)** resource:

| Parameter  | Type   | Path                     | Modifiers         | Description                                                                      |
|------------|--------|--------------------------|-------------------|----------------------------------------------------------------------------------|
| active     | token  | Practitioner.active      |                   |                                                                                  |
| identifier | token  | Practitioner.identifier  |                   |                                                                                  |
| name       | string | Practitioner.name        | :contains, :exact | A server defined search that may match any of the string fields in the HumanName |
| given      | string | Practitioner.name.given  | :contains, :exact |                                                                                  |
| family     | string | Practitioner.name.family | :contains, :exact |                                                                                  |
{:class="table table-bordered"}

The _Care Services Selective Supplier_ shall support the following search parameters on the
**[PractitionerRole](StructureDefinition-CH.mCSD.PractitionerRole.html)** resource:

| Parameter                              | Type      | Path                               | Modifiers | Description                                           |
|----------------------------------------|-----------|------------------------------------|-----------|-------------------------------------------------------|
| active                                 | token     | PractitionerRole.active            |           |                                                       |
| location                               | reference | PractitionerRole.location          |           | Will not yield any results                            |
| organization                           | reference | PractitionerRole.organization      |           |                                                       |
| practitioner                           | reference | PractitionerRole.practitioner      |           |                                                       |
| role                                   | token     | PractitionerRole.code              |           |                                                       |
| service                                | reference | PractitionerRole.healthcareService |           | Will not yield any results                            |
| specialty                              | token     | PractitionerRole.specialty         |           |                                                       |
| _include=PractitionerRole:practitioner |           |                                    |           | Includes the referenced Practitioners in the response |
{:class="table table-bordered"}

The _Care Services Selective Supplier_ may not support other resources (**Endpoint**, **HealthcareService**,
**Location** and **OrganizationAffiliation**), as they are not used in this national extension. Any search query on
these resources may not yield any result. Some example queries are given here:

1. The following request searches for an active **Organization** whose name contains 'Medical':
   `GET [base]/Organization?active=true&name:contains=Medical`
2. The following request searches for a **Practitioner** named 'Müller':
   `GET [base]/Practitioner?family=Müller`
3. The following request searches for a **Practitioner** with the GLN '7601000102737':
   `GET [base]/Practitioner?identifier=urn:oid:2.51.1.3|7601000102737`
4. The following request searches for all **Practitioners** working at the 'HUG' organization:
   `GET [base]/PractitionerRole?organization=Organization/HUG&_include=PractitionerRole:practitioner`

#### Find Matching Care Services Response Message

The response message is a [Search Results Bundle](http://hl7.org/fhir/R4/bundle.html#searchset) that contains
**[Organizations](StructureDefinition-CH.mCSD.Organization.html)**,
**[Practitioners](StructureDefinition-CH.mCSD.Practitioner.html)** and
**[PractitionerRoles](StructureDefinition-CH.mCSD.Practitionerrole.html)**.
[An example of response message](Bundle-FindMatchingCareServicesResponse.html) is provided.

#### Retrieve Care Services Resource Message

The _Retrieve Care Services Resource_ is conducted by executing an HTTP GET against the _Care Services Selective
Supplier_'s Care Services Resource URL, providing the resource id of the resource being retrieved. The target is
formatted as: `GET [base]/[resource]/[resourceId]`. Some examples are

1. Retrieve the **Organization** 'Spital X Dept. 3': `GET [base]/Organization/SpitalXDept3`.
2. Retrieve the **Practitioner** 'Dr. Peter Pan': `GET [base]/Practitioner/DrPeterPan`.
3. Retrieve the **PractitionerRole** 'Dr. Peter Pan at Praxis P': `GET [base]/PractitionerRole/PeterPanPraxisP`.

#### Retrieve Care Services Resource Response Message

The _Care Services Selective Supplier_ shall respond to this query by sending a single _Care Services Resource_
instance.

- If the _Care Services Selective Supplier_ finds the resource, `HTTP 200 OK` is returned with the resource (an
  **[Organization](StructureDefinition-CH.mCSD.Organization.html)**,
  **[Practitioner](StructureDefinition-CH.mCSD.Practitioner.html)** or
  **[PractitionerRole](StructureDefinition-CH.mCSD.Practitionerrole.html)**).
- If the _Care Services Selective Supplier_ does not find the resource, `HTTP 404 Not Found` is returned with an
  **[OperationOutcome](https://www.hl7.org/fhir/r4/operationoutcome.html)** resource.

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Care Services Selective Consumer** is
[mCSD Care Services Selective Consumer](CapabilityStatement-CH.mCSD.CareServicesSelectiveConsumer.html).

The CapabilityStatement resource for the **Care Services Selective Supplier** is
[mCSD Care Services Selective Supplier](CapabilityStatement-CH.mCSD.CareServicesSelectiveSupplier.html).

### Security Considerations

TLS SHALL be used. This national extension enforces authentication and authorization of access to the _Care Services
Selective Supplier_ using the IUA profile with basic access token. Consequently, the _Find Matching Care Services_
[ITI-90] request must authorize using the [_Incorporate Access Token_ [ITI-72]](iti-72.html) transaction of the IUA profile.

#### Security Audit Considerations

Note that the same audit message is recorded by both **Care Services Selective Supplier** and **Care Services 
Selective Consumer**. The difference being the Audit Source element. Both sides record to show consistency between 
the message sent by the Consumer and the action taken at the Supplier.

The actors involved shall record audit events according to the [Audit Event for Find Matching Care Services for Read by
the Care Services Selective Supplier and Consumer](https://profiles.ihe.net/ITI/mCSD/3.8.0/StructureDefinition-IHE.mCSD.Audit.CareServices.Read.html)
or the [Audit Event for Find Matching Care Services for Query by the Care Services Selective Supplier and
Consumer](https://profiles.ihe.net/ITI/mCSD/3.8.0/StructureDefinition-IHE.mCSD.Audit.CareServices.Query.html).
