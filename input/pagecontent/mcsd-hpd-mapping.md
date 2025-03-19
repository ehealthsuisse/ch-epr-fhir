# Mapping between mCSD and HPD data models

## Mapping of identifiers

HPD objects may have three types of identifiers:

* Unique ID (`uid` for providers, `cn` for Relationships, etc.).
* Distinguished name (DN) consisting from the unique ID and fixed suffix specific for the object class.
* Business IDs of individual and organizational providers (`hcIdentifier`)
  consisting from issuing authority ID, ID type, ID value, and status, divided by colons.

Unique IDs of providers are mapped to values of `Practitioner.identifier` and `Organization.identifier`
with `system` equal to `urn:ietf:rfc:4514`.

DNs are not mapped to any FHIR attribute, because they are derived from unique IDs, and, moreover,
not used as search parameters.

Business IDs of providers are mapped to `Practitioner.identifier` and `Organization.identifier`.
The combination of issuing authority ID and ID type in HPD (first two components of `hcIdentifier`)
is mapped to the attribute `Identifier.system` in FHIR according to the rules shown in the table below:

<style>
table, th, td {
  border: 1px solid black;
}
</style>
| FHIR `Identifier.system`                           | HPD issuing authority ID | HPD ID type       |
|----------------------------------------------------|--------------------------|-------------------|
| `urn:ietf:rfc:3986`                                | `RefData`                | `OID`             |
| `urn:oid:2.51.1.3`                                 | `RefData`                | `GLN`             |
| `urn:oid:2.16.756.5.30.1.123.100.2.1.1`            | tbd (ZSR)                | tbd (ZSR)         |
| Other values matching the template `urn:${A}:${B}` | `${A}`                   | `${B}`            |
| Values not matching the above template             | no mapping to HPD        | no mapping to HPD |

HPD ID value (third components of `hcIdentifier`) is mapped to FHIR `Identifier.value`.

HPD ID status (fourth components of `hcIdentifier`) is mapped to FHIR
`Identifier.extension[status].valueCode`. If this extension is not present, ID status "active"
is assumed.

## Mapping of postal addresses

Individual and organizational HPD providers can have different types of postal addresses.
In FHIR, they all are mapped to `Address` structures, and are characterized by combinations of
attributes `type` and `use` as shown in the table below:

| HPD address type             | FHIR `Address.type` | FHIR `Address.use` |
|------------------------------|---------------------|--------------------|
| `hpdProviderMailingAddress`  | `postal`            | `work`             |
| `hpdProviderBillingAddress`  | `postal`            | `billing`          |
| `hpdProviderPracticeAddress` | `physical`          | `work`             |
| `hpdProviderLegalAddress`    | `both`              | `work`             |

The next table shows how address elements are mapped between FHIR and HPD:

| HPD address element | Attribute of FHIR `Address`                                                                                                                                             |
|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `status`            | `extension[status].valueCode` (if not present, status "primary" is assumed)                                                                                             |
| `addr`              | `line[0]`                                                                                                                                                               |
| `streetNumber`      | `line[0].extension[houseNumber].valueString` (this extension is defined in the [CH-Core](https://fhir.ch/ig/ch-core/5.0.0/StructureDefinition-ch-core-address.html) IG) |
| `streetName`        | `line[0].extension[streetName].valueString` (this extension is defined in the [CH-Core](https://fhir.ch/ig/ch-core/5.0.0/StructureDefinition-ch-core-address.html) IG)  |
| `city`              | `city`                                                                                                                                                                  |
| `state`             | `state`                                                                                                                                                                 |
| `postalCode`        | `postalCode`                                                                                                                                                            |
| `country`           | `country`                                                                                                                                                               |

Note that HPD `HCProfessional.physicalDeliveryOfficeName` does not represent an address data
structure, and is therefore mapped to FHIR `Practitioner.extension[physicalDeliveryOfficeName].valueString`.

Another difference is related to HPD `HCRegulatedOrganization.hpdProviderLegalAddress`, which is mapped to FHIR
`Organization.address` instead of `Organization.contact.address[use=#work, type=#both]` (which additionally allows
to omit the explicit validation that an organization can have only one legal address).

## Mapping of telecommunication channels

Same as with postal addresses, an HPD provider can have multiple communication channels. On the FHIR site, they
map to `ContactPoint` structures as shown in the table below:

| HPD communication channel  | FHIR `ContactPoint.system` | FHIR `ContactPoint.use` |
|----------------------------|----------------------------|-------------------------|
| `mail`                     | `#email`                   | any                     |
| `telephoneNumber`          | `#phone`                   | `#work`                 |
| `mobile`                   | `#phone`                   | `#mobile`               |
| `pager`                    | `#pager`                   | any                     |
| `facsimileTelephoneNumber` | `#fax`                     | any                     |

HPD `HCProfessional.hpdMedicalRecordsDeliveryEmailAddress` constitutes a special case. The cardinality of this
attribute is 0..1, as opposed to 0..n for all other telecommunication channels, and it does not map conveniently
to FHIR `ContactPoint`. Therefore, it is mapped to FHIR
`Practitioner.extension[hpdMedicalRecordsDeliveryEmailAddress].valueString`.

## Mapping of person names

For the mapping between HPD and FHIR, due to element cardinalities in the HPD specification, only the first repetition
of FHIR `Practitioner.name` is used.

| HPD name element   | Attribute of FHIR `Practitioner.name[0]` (`HumanName`)                                                                                                                               |
|--------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `displayName`      | `text`                                                                                                                                                                               |
| `title`            | `prefix` with `extension[ENQualifier].valueCode == #AC` (this extension is defined in the [CH-Core](https://fhir.ch/ig/ch-core/5.0.0/StructureDefinition-ch-core-humanname.html) IG) |
| `givenName`        | `given`                                                                                                                                                                              |
| `initials`         | `extension[initials].valueString`                                                                                                                                                    |
| `sn` (family name) | `family`                                                                                                                                                                             |

Note that the value of HPD `HCProfessional.cn` is dynamically derived from the practitioner's UID and names, and
therefore not mapped to anything in FHIR.

## Mapping of codes

Codes are used in HPD attributes like `hcProfession` or `hcSpecialization` and consist from
three to four components: issuing authority ID, code system OID, code value, and the optional
display name.

The mapping of data structures is shown in the table below:

| HPD code element     | Attribute of FHIR `coding`                   |
|----------------------|----------------------------------------------|
| Issuing authority ID | No mapping, as this is the fixed value "BAG" |
| Code system          | `system` with the mapping defined below      |
| Code value           | `code`                                       |
| Display name         | `display`                                    |

For code systems, the mapping is as follows:

| HPD code system OID      | FHIR `coding.system`                    |
|--------------------------|-----------------------------------------|
| `2.16.840.1.113883.6.96` | `http://snomed.info/sct`                |
| Any other OID            | The same OID with the prefix `urn:oid:` |


## Mapping of HPD HCProfessional.status

HPD `HCProfessional.hpdProviderStatus` can have four values: `active`, `inactive`, `retired`, and `deceased`,
whereby the latter two can be considered as flavors of `inactive`. In FHIR, the attribute
`Practitioner.active` is of type `boolean`, thus unable to resemble the HPD's code semantics.
Therefore, `Practitioner.active` got an optional extension "inactivityReason" of type `code`,
with the possible values `#retired` and `#deceased`.

The mapping between FHIR and HPD is as follows:

| HPD `HCProfessional.hpdProviderStatus` | FHIR `Practitioner.active` | FHIR `Practitioner.active.extension[inactivityReason].valueCode` |
|----------------------------------------|----------------------------|------------------------------------------------------------------|
| `active`                               | `true`                     | extension is ignored / not created                               |
| `inactive`                             | `false`                    | extension is not present / not created                           |
| `retired`                              | `false`                    | `#retired`                                                       |
| `deceased`                             | `false`                    | `#deceased`                                                      |

NB: HPD `HCRegulatedOrganization.hpdProviderStatus` has only two possible values &mdash; `active` and `inactive` &mdash;
and thus does not need any additional definitions to be mapped to FHIR `Organization.active` of type `boolean`.


## Mapping of organization names

HPD `HCRegulatedOrganization` defines two types of organization names &mdash; legal names (`hcRegisteredName`) and
other names (`O`), both with cardinalities 0..n. In FHIR `Organization` resource, their counterparts are
`name` and `alias`, respectively. But `name` has the cardinality 0..1. Additional legal organization names in FHIR
can be placed into `Organization.name.extension[registeredNames].valueString`.


## Mapping of HPD Relationship objects

An HPD `Relationship` object represents a group of individual and organization healthcare providers ("members") belonging to 
a parent organization ("owner").  The list of members can be empty.  Each HPD `Relationship` has its own identity (`cn`).
An organization can be owner of multiple relationships, but member of only a single one.  An individual provider
can be member of multiple relationships.

There is no direct mapping of HPD `Relationship` to FHIR mCSD resources, because in mCSD, the affiliation with a parent
`Organization` is expressed not groupwise, but individually for each individual member (`PractitionerRole.organization`) 
and organization member (`Organization.partOf`).  

To allow a mapping between these very different models, the following approach is defined:
* `Organization.extension[ownerOf]` (0..*) of the type `HpdUidIdentifier` contains a list of CNs of HPD `Relationship` 
  objects where this `Organization` is the owner.  This is necessary in particular to allow relationships without members.
* `Organization.partOf.extension[memberOf]` (1..1) of the same type contains the CN of the HPD `Relationship` 
  to which this link between two organizations belongs.
* `PractitionerRole.identifier` has a slice "memberOf" (1..1) of the same type 
  which contains the CN of the HPD `Relationship` to which the link between `PractitionerRole.practitioner` 
  and `PractitionerRole.organization` belongs.

The following constraints apply:
* If any "memberOf" CNs of any two FHIR resources (`Organization` or `PractitionerRole`) are equal, 
  then these resources shall reference the same parent `Organization`.
* No two `Organization` resources shall have the same CN in their "ownerOf" lists,
  i.e. no two organizations shall own the same relationship. 
* Each "memberOf" CN shall occur in the "ownerOf" list of exactly one `Organization`.

Implementers of mCSD Directory actors shall assure that these constraints are fulfilled, and that the 
"memberOf" and "ownerOf" attributes are automatically created when serving relevant ITI-130 requests not containing 
them.  Particular algorithms for that are intentionally not prescribed.

## Mapping of HPD HCProfessional object

Attributes of an HPD `HCProfessional` are scattered between one FHIR resource `Practitioner` and 0..* FHIR resources
`PractitionerRole` referencing it.

HPD attributes covered by FHIR `PractitionerRole` are `hcProfession`, `hcSpecialization`, and `memberOf`.

All other attributes of HPD `HCProfessional` are covered by FHIR `Practitioner`. 


## Mapping of HPD HCRegulatedOrganization object

All attributes of an HPD `HCRegulatedOrganization` are covered by a FHIR `Organization` resource.


## What is not mapped

There are three groups of HPD attributes that are intentionally omitted from mapping to FHIR.

Group 1: omitted, because the value is derived from others:
* `DN` of all HPD objects &mdash; derived from identifier, object class, and a fixed suffix.
* `HCProfessional.cn` &mdash; derived from identifier, last name, and first name.

Group 2: omitted, because not used in the EPR context:
* `HCProfessional.userSMIMECertificate`.
* `HCProfessional.hcSigningCertificate`.
* `HCProfessional.userCertificate`.
* `HCProfessional.hcPracticeLocation`.
* `HCRegulatedOrganization.ClinicalInformationContact`.
* `HCRegulatedOrganization.hcSigningCertificate`.
* `HCRegulatedOrganization.hcOrganizationCertificates`.

Group 3: omitted, because the value is constants:
* Issuing authority ID of all codes ("BAG").
* `HCProfessional.hcRegistrationStatus` ("unknown").
* `objectClass` of all HPD objects.


