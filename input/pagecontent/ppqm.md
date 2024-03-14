This section specifies

### Scope

### Use Cases


### Actors and Transactions, Content Specifications

<div>
{%include mCSD_actor_diagram.svg %}
</div>
This figure shows the actors directly involved in the _Mobile Care Services Discovery_ Profile and the relevant 
transactions between them.

### Required Actor Grouping

This national extension enforces authentication and authorization for access control.
Therefore, actors of this profile must be grouped with actors of other profiles according to the following table:

| Actor             | Required Grouping        | Optionality |
|-------------------|--------------------------|-------------|
| Policy Source     | IUA Authorization Client | R           |
| Policy Consumer   | IUA Authorization Client | R           |
| Policy Repository | IUA Resource Server      | R           |
{:class="table table-bordered"}

<figcaption ID="1">Table 1: Grouping of PPQm actors required by this national extension.</figcaption>

### Security Consideration

This national extension enforces authentication and authorization of access to the _Care Services Selective Supplier_
using the IUA profile with basic access token as described in [IUA](iti-71.html).






The CH:PPQm specification is based on:
* [HL7 FHIR (R) standard Release 4](http://hl7.org/fhir/R4) &mdash; for basis definitions.
* [CH EPR Term Implementation Guide](http://fhir.ch/ig/ch-epr-term) &mdash; for Swiss EPR coding systems and value sets.
* [CH EPR mHealth Implementation Guide](http://fhir.ch/ig/ch-epr-mhealth) &mdash; for RESTful ATNA and IUA profiles.

See also:
* CH:PPQ specification in the [Amendment 2.1 of Annex 5 EPRO-FDHA](https://www.fedlex.admin.ch/eli/oc/2023/221/de/annexes).
* [Policy set templates](https://github.com/ehealthsuisse/ch-epr-adr-ppq/tree/main/Privacy%20Policy%20Stack/Patient%20Specific%20via%20Policy%20Manager)
  in the official EPR policy stack.
* [Description of the official EPR policy stack](https://github.com/ehealthsuisse/ch-epr-adr-ppq/blob/main/docs/Policies.md).