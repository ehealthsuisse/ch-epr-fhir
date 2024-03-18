### Introduction

This Implementation Guide is a part of the Swiss EPR specifications and contains definitions necessary
for the Swiss national integration profile
["Privacy Policy Query for Mobile"](https://www.e-health-suisse.ch/technik-semantik/epd-projectathon/programmierhilfen-epd/relevante-spezifikationen.html)
(CH:PPQm).  The goal of this profile is to provide a possibility to manage privacy policies using a lightweight
technology stack suitable for mobile devices &mdash; as opposed to the classic CH:PPQ which is based
on XACML 2.0 and SAML 2.0.

The CH:PPQm specification is based on:
* [HL7 FHIR (R) standard Release 4](http://hl7.org/fhir/R4) &mdash; for basis definitions.
* [CH EPR Term Implementation Guide](http://fhir.ch/ig/ch-epr-term) &mdash; for Swiss EPR coding systems and value sets.
* [CH EPR mHealth Implementation Guide](http://fhir.ch/ig/ch-epr-mhealth) &mdash; for RESTful ATNA and IUA profiles.
  <br/>

See also:
* CH:PPQ specification in the [Amendment 2.1 of Annex 5 EPRO-FDHA](https://www.fedlex.admin.ch/eli/oc/2023/221/de/annexes).
* [Policy set templates](https://github.com/ehealthsuisse/ch-epr-adr-ppq/tree/main/Privacy%20Policy%20Stack/Patient%20Specific%20via%20Policy%20Manager)
  in the official EPR policy stack.
* [Description of the official EPR policy stack](https://github.com/ehealthsuisse/ch-epr-adr-ppq/blob/main/docs/Policies.md).

### Downloads

You can [download](package.tgz) the whole Implementation Guide as a NPM package.

Version history is documented in the [change log](changelog.html).
<br/>

### Actors and Transactions

In CH:PPQm, EPR privacy policies are represented as [PpqmConsent](StructureDefinition-PpqmConsent.html)
resources, whose structure resembles the EPR flavor of XACML 2.0 Policy Set and obeys the same logical constraints.

The CH:PPQm profile defines the following actors and transactions:

<div><img src="assets/images/actors.svg"/></div>
<br/>

Thereby, the Policy Repository is a component of an EPR reference community's central IT infrastructure.
The Policy Source and Policy Consumer are the actors to be implemented in mobile clients.
<br/>
<br/>

#### PPQ-3: Mobile Privacy Policy Feed

To create, update, or delete _single_ policies
([PpqmConsent](StructureDefinition-PpqmConsent.html) resources)
in the Policy Repository, a mobile client may use the __Mobile Privacy Policy Feed__ transaction (PPQ-3):

<div>{% include PPQ-3.svg %}</div>
<br/>

#### PPQ-4: Mobile Privacy Policy Bundle Feed

To manipulate policies _groupwise_, the __Mobile Privacy Policy Bundle Feed__ transaction (PPQ-4) can be used:

<div>{% include PPQ-4.svg %}</div>

The request is a [PpqmFeedRequestBundle](StructureDefinition-PpqmFeedRequestBundle.html)
resource containing one or more [PpqmConsent](StructureDefinition-PpqmConsent.html)
resources (for add and update operations) or references to them (for the delete operation).
<br/>
<br/>

#### PPQ-5: Mobile Privacy Policy Retrieve

Read access to the Policy Repository is provided by the __Mobile Privacy Policy Retrieve__ transaction (PPQ-5):

<div>{% include PPQ-5.svg %}</div>

The response is a [PpqmRetrieveResponseBundle](StructureDefinition-PpqmRetrieveResponseBundle.html)
resource containing zero or more [PpqmConsent](StructureDefinition-PpqmConsent.html)
resources.
<br/>
<br/>

### Further Aspects

In order to provide interoperability between CH:PPQ and CH:PPQm, the CH:PPQm integration profile defines
transformation rules between XACML 2.0 Policy Sets and
[PpqmConsent](StructureDefinition-PpqmConsent.html) resources.


### IP Statements

{% include ip-statements.xhtml %}

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### Dependency Table

{% include dependency-table.xhtml %}

### Globals Table

{% include globals-table.xhtml %}
