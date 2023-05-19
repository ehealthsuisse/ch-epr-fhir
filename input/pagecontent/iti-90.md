This section documents additional requirements in the Swiss EPR context on the Request Care Services Updates.

### Scope

A mHealth application wants to search for healthcare organizations and/or healthcare professionals. It can perform an
[ITI-90](iti-90.html) request with search parameters to get a list of matched resources.

It offers an alternative to the HPD ITI-58 transaction.

### Actor Roles-

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

#### Find Matching Care Services Request Message

The Find Matching Care Services message is a FHIR search operation on the mCSD Resources.

A Care Services Selective Consumer initiates a search request using HTTP GET or POST:

`GET [base]/[resource]?[parameters]`

or
<pre>
POST [base]/[resource]/_search
Content-Type: application/x-www-form-urlencoded

param1=value&param2=value
</pre>

##### Semantics

The Care Services Selective Supplier shall support the following search parameters for all resources:

{:class="table table-bordered"}
| Parameter    | Type   | Path                      | Modifiers | Description                                                                                                                           |
|--------------|--------|---------------------------|-----------|---------------------------------------------------------------------------------------------------------------------------------------|
| _id          | token  | Resource.id               |           |                                                                                                                                       |
| _lastUpdated | date   | Resource.meta.lastUpdated | ge, le    |                                                                                                                                       |
| _format      | token  | N/A                       |           | Defines the [expected response format](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.6-populating-the-expected-response-format) |
| _sort        |        | N/A                       |           | For [sorting](https://www.hl7.org/fhir/R4/search.html#sort)                                                                           |
| _count       | number | N/A                       |           | For [paging](https://www.hl7.org/fhir/R4/search.html#count)                                                                           |

The Care Services Selective Supplier shall support the following search parameters on the
[Organization](StructureDefinition-CH.mCSD.Organization.html) resource:

| Parameter                                                      | Type      | Path                       | Modifiers          | Description      |
|----------------------------------------------------------------|-----------|----------------------------|--------------------|------------------|
| active                                                         | token     | Organization.active        |                    |                  |
| identifier                                                     | token     | Organization.identifier    |                    |                  |
| name                                                           | string    | Organization.(name, alias) | :contains, :exact  |                  |
| partof                                                         | reference | Organization.partOf        |                    |                  |
| type                                                           | token     | Organization.type          |                    |                  |
| _include=Organization.endpoint                                 |           |                            |                    | It has no effect |
| _revInclude=Location:organization                              |           |                            |                    | It has no effect |
| _revInclude=OrganizationAffiliation:participating-organization |           |                            |                    | It has no effect |
| _revInclude=OrganizationAffiliation:primary-organization       |           |                            |                    | It has no effect |
{:class="table table-bordered"}

The Care Services Selective Supplier shall support the following search parameters on the 
[Practitioner](StructureDefinition-CH.mCSD.Practitioner.html) resource:

| Parameter  | Type   | Path                     | Modifiers          | Description                                                                       |
|------------|--------|--------------------------|--------------------|-----------------------------------------------------------------------------------|
| active     | token  | Practitioner.active      |                    |                                                                                   |
| identifier | token  | Practitioner.identifier  |                    |                                                                                   |
| name       | string | Practitioner.name        | :contains, :exact  | A server defined search that may match any of the string fields in the HumanName  |
| given      | string | Practitioner.name.given  | :contains, :exact  |                                                                                   |
| family     | string | Practitioner.name.family | :contains, :exact  |                                                                                   |
{:class="table table-bordered"}

The Care Services Selective Supplier shall support the following search parameters on the 
[PractitionerRole](StructureDefinition-CH.mCSD.PractitionerRole.html) resource:

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

The Care Services Selective Supplier may not support other resources (Endpoint, HealthcareService, Location and 
OrganizationAffiliation), as they are not used in this national extension. Any search query on these resources may 
not yield any result.

##### Examples

The following request searches for an active organization whose name contains 'Medical':
`GET [base]/Organization?active=true&name:contains=Medical`

The following request searches for a practitioner named 'Müller':
`GET [base]/Practitioner?family=Müller`

The following request searches for a practitioner with the GLN '7601000102737':
`GET [base]/Practitioner?identifier=urn:oid:2.51.1.3|7601000102737`

The following request searches for all practitioners working at the X organization:
`GET [base]/PractitionerRole?organization=X&_include=PractitionerRole:practitioner`

#### Find Matching Care Services Response Message

##### Semantics

The response message is a [Search Results Bundle](http://hl7.org/fhir/R4/bundle.html#searchset) that contains
[Organizations](StructureDefinition-CH.mCSD.Organization.html),
[Practitioners](StructureDefinition-CH.mCSD.Practitioner.html) and
[PractitionerRoles](StructureDefinition-CH.mCSD.Practitionerrole.html).

##### Examples

[Response message example](Bundle-FindMatchingCareServicesResponse.html).

#### Retrieve Care Services Resource Message

The Retrieve Care Services Resource is conducted by executing an HTTP GET against the Care Services Selective 
Supplier's Care Services Resource URL, providing the resource id of the resource being retrieved. The target is 
formatted as:

`GET [base]/[resource]/[resourceId]`

##### Examples

Retrieve the Organization 'Spital X Dept. 3': `GET [base]/Organization/SpitalXDept3`

Retrieve the Practitioner 'Dr. Peter Pan': `GET [base]/Practitioner/DrPeterPan`

Retrieve the PractitionerRole 'Dr. Peter Pan at Praxis P': `GET [base]/PractitionerRole/PeterPanPraxisP`

#### Retrieve Care Services Resource Response Message

The Care Services Selective Supplier shall respond to this query by sending a single Care Services Resource instance.

If the Care Services Selective Supplier finds the resource, `HTTP 200 OK` is returned with the resource (an 
[Organization](StructureDefinition-CH.mCSD.Organization.html),
[Practitioner](StructureDefinition-CH.mCSD.Practitioner.html) or
[PractitionerRole](StructureDefinition-CH.mCSD.Practitionerrole.html)).

If the Care Services Selective Supplier does not find the resource, `HTTP 404 Not Found` is returned with an 
OperationOutcome resource.

### Security Considerations

TLS SHALL be used. This national extension enforces authentication and authorization of access to the Care Services 
Selective Supplier using the IUA profile with basic access token. Consequently, the Find Matching Care Services 
[ITI-90] request must authorize using the Incorporate Access Token [ITI-72] transaction of the IUA profile.
