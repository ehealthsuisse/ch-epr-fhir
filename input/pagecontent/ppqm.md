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






According to Swiss EPR regulations, patients have the right to decide who is allowed to access and modify data in 
their EPR, and under which circumstance (cf. emergency access). The national integration profile "Privacy Policy 
Query" (CH:PPQ, see Amendment 2.1 of Annex 5 EPRO-FDHA) defines how to specify these decisions as access policies in 
the XACML 2.0 format and interchange them using the SOAP transport protocol. For mobile applications, this 
combination of standards is only restrictedly suitable, therefore a more lightweight solution like HL7 FHIR® is 
required instead. 

The national integration profile CH:PPQm — "Privacy Policy Query for Mobile" — is a FHIR-based counterpart of CH:PPQ.

### Actors and Transactions

CH:PPQm comprises the following actors and transactions:

<figure>
  <img src="assets/images/actors.svg"/>
  <figcaption>Figure 1: CH:PPQm actor diagram</figcaption>
</figure>

**Actor:** Policy Repository<br>
**Role:** Stores policies and policy sets and provides the possibility to add, query, update and delete them<br>
**Actor:** Policy Source<br>
**Role:** Initiates addition, update and deletion of policies and policy sets<br>
**Actor:** Policy Consumer<br>
**Role:** Retrieves policies and policy sets

Table 2 lists the transactions for each actor directly involved in the CH:PPQm Profile. To claim compliance with 
this profile, an actor shall support all required transactions (labeled "R") and may support the optional 
transactions (labeled "O").

| Actors            | Transactions                              | Optionality | Section              |
|-------------------|-------------------------------------------|-------------|----------------------|
| Policy Repository | Mobile Privacy Policy Feed (PPQ-3)        | R           | [PPQ-3](ppqm-3.html) |
|                   | Mobile Privacy Policy Bundle Feed (PPQ-4) | R           | [PPQ-4](ppqm-4.html) |
|                   | Mobile Privacy Policy Retrieve (PPQ-5)    | R           | [PPQ-5](ppqm-5.html) |
| Policy Source     | Mobile Privacy Policy Feed (PPQ-3)        | O (Note 1)  | [PPQ-3](ppqm-3.html) |
|                   | Mobile Privacy Policy Bundle Feed (PPQ-4) | O (Note 1)  | [PPQ-4](ppqm-4.html) |
| Policy Consumer   | Mobile Privacy Policy Retrieve (PPQ-5)    | R           | [PPQ-5](ppqm-5.html) |
{:class="table table-bordered"}

Table 2: CH:PPQm transactions

Note 1: The actor SHALL support at least one transaction.

The required actor groupings are shown in Table 3:

| Actors            | Actor to be grouped with | Reference                                   |
|-------------------|--------------------------|---------------------------------------------|
| Policy Repository | IUA Resource Server      | Amendment mHealth of Annex 5, section 2.3.1 |
|                   | ATNA Secure Application  | Amendment 1 of Annex 5, Section 1.5         |
| Policy Source     | IUA Authorization Client | Amendment mHealth of Annex 5, section 2.3.1 |
|                   | ATNA Secure Application  | Amendment mHealth of Annex 5, section 2.3.4 |
| Policy Consumer   | IUA Authorization Client | Amendment mHealth of Annex 5, section 2.3.1 |
|                   | ATNA Secure Application  | Amendment mHealth of Annex 5, section 2.3.4 |
{:class="table table-bordered"}

Table 3: CH:PPQm required actors groupings

### Referenced Standards

- HL7 FHIR standard Release 4: [http://hl7.org/fhir/R4/index.html](http://hl7.org/fhir/R4/index.html)
- CH Core Implementation Guide (R4) v2.0.0: [http://fhir.ch/ig/ch-core](http://fhir.ch/ig/ch-core)
- CH EPR mHealth Implementation Guide (R4) v1.0.0: [http://fhir.ch/ig/ch-epr-mhealth/index.html](http://fhir.ch/ig/ch-epr-mhealth/index.html)
- CH EPR PPQm Implementation Guide (R4) v1.0.0: [http://fhir.ch/ig/ch-epr-ppqm](http://fhir.ch/ig/ch-epr-ppqm)

### Relation between CH:PPQm and CH:PPQ

_This section is not normative._

Implementers may decide to implement CH:PPQm transactions on top of CH:PPQ ones, i.e. to create a FHIR layer over an 
existing XACML-based Policy Repository. The CH:PPQm specification supports this approach by defining transactions 
and data structures in a way which allows an efficient bridging between CH:PPQ and CH:PPQm, and by providing message 
transformation rules (see Chapter 4).

In terms of actor grouping, this would mean that the Policy Repository may be optionally grouped with CH:PPQ Policy 
Source and CH:PPQ Policy Consumer in order to communicate over PPQ 1 and PPQ 2 with itself.

Note that CH:PPQm is not intended to handle base policies and policy sets, i.e. the ones provided in the official 
Policy Stack and not related to any particular patients.