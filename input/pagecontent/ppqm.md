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

# Volume 3 – Content Profiles

Definitions of resource profiles, coding systems, and value sets for the FHIR resources used in the CH:PPQm profile 
are provided in the CH:PPQm implementation guide.

The rest of this chapter defines a mapping between CH:PPQm and CH:PPQ data structures — section 4.1 draws parallels 
between FHIR Consent resources and XACML 2.0 policy sets, section 4.2 focusses on the transformation of messages 
used in CH:PPQm and CH:PPQ transactions.

## Mapping between PpqmConsent Resources and CH:PPQ Policy Sets

### Transformation of PpqmConsent Resources into CH:PPQ Policy Sets

Each [PpqmConsent](StructureDefinition-PpqmConsent.html) resource contains an element identifier with 
`type.coding.code` equal to "templateId". In this element, the attribute value contains the ID of the official 
Policy Stack template. For example:

```json
{ 
  "type": {
    "coding": [{
      "system": "http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType",
      "code": "templateId"
    }]
  },
  "value": "201" 
}
```

The PPQ-conformant XACML 2.0 Policy Set SHALL be created according to this template. Thereby, the value placeholders 
SHALL be filled according to the table below:

| Placeholder          | PpqmConsent attribute                                                          |
|:---------------------|--------------------------------------------------------------------------------|
| Policy Set ID        | `identifier.value` where `identifier.type.coding.code` equals to "policySetId" |
| EPR-SPID             | `patient.identifier.value`                                                     |
| GLN                  | `provision.actor.reference.identifier.value`                                   |
| Group OID            | `provision.actor.reference.identifier.value`                                   |
| Representative ID    | `provision.actor.reference.identifier.value`                                   |
| PolicySetIDReference | `policyRule.coding.code`                                                       |
| Start date           | `provision.period.start`                                                       |
| End date             | `provision.period.end`                                                         |
{:class="table table-bordered"}

Table 4: Mapping of PpqmConsent attributes onto CH:PPQ policy set template placeholders

### Transformation of CH:PPQ Policy Sets into PpqmConsent Resources

Each patient-related CH:PPQ policy set is generated from a template provided in the official Policy Stack, but does 
not hold a direct reference to this template. Therefore, the first step is to determine the template ID. For that, 
the following heuristics SHALL be used:
- The policy set contains an element `/PolicySet/Target/Subjects` with _three_ sub-elements Subject → template **203**.
- The policy set contains an element `/PolicySet/Target/Subjects/Subject/SubjectMatch/AttributeValue/CodedValue` with 
  `@codeSystem` equal to "2.16.756.5.30.1.127.3.10.6" and:
  - `@code` equal to "PAT" → template **201**.
  - `@code` equal to "REP" → template **303**.
- The policy set contains an element `/PolicySet/Target/Subjects/Subject/SubjectMatch/AttributeValue/CodedValue` with 
  `@codeSystem` equal to "2.16.756.5.30.1.127.3.10.5" and `@code` equal to "EMER" → template **202**.
- The policy set contains an element `/PolicySet/Target/Subjects/Subject/SubjectMatch/SubjectAttributeDesignator` with 
  `@AttributeId` equal to "urn:oasis:names:tc:xspa:1.0:subject:organization-id" → template **302**.
- Otherwise → template **301**.

The [PpqmConsent](StructureDefinition-PpqmConsent.html) resource attributes SHALL be populated according to the 
rules defined for each template in the table below:

<table class="table table-bordered">
	<thead>
		<tr>
			<td><strong>PpqmConsent attribute</strong></td>
			<td><strong>Template 201</strong><br>(full access for the patient)</td>
			<td><strong>Template 202</strong><br>(confidentiality level for emergency access)</td>
			<td><strong>Template 203</strong><br>(minimal confidentiality level for upload)</td>
			<td><strong>Template 301</strong><br>(individual access permissions)</td>
			<td><strong>Template 302</strong><br>(group access permissions)</td>
			<td><strong>Template 303</strong><br>(full access for the patient's representative)</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><code>identifier.value</code> (1)</td>
			<td colspan="6">value of <code>/PolicySet/@PolicySetId</code></td>
		</tr>
		<tr>
			<td><code>identifier.type</code> (1)</td>
			<td colspan="6">fixed value: code "http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType|policySetId"</td>
		</tr>
		<tr>
			<td><code>identifier.value</code> (2)</td>
			<td>fixed value: "201"</td>
			<td>fixed value: "202"</td>
			<td>fixed value: "203"</td>
			<td>fixed value: "301"</td>
			<td>fixed value: "302"</td>
			<td>fixed value: "303"</td>
		</tr>
		<tr>
			<td><code>identifier.type</code> (2)</td>
			<td colspan="6">fixed value: code "http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType|templateId"</td>
		</tr>
		<tr>
			<td><code>status</code></td>
			<td colspan="6">fixed value: code "active"</td>
		</tr>
		<tr>
			<td><code>scope</code></td>
			<td colspan="6">fixed value: code "http://terminology.hl7.org/CodeSystem/consentscope|patient-privacy"</td>
		</tr>
		<tr>
			<td><code>category</code></td>
			<td colspan="6">fixed value: code "http://terminology.hl7.org/CodeSystem/v3-ActCode|INFA"</td>
		</tr>
		<tr>
			<td><code>patient.identifier.system</code></td>
			<td colspan="6">fixed value: "urn:oid:2.16.756.5.30.1.127.3.10.3" (OID of EPR-SPID in URN format)</td>
		</tr>
		<tr>
			<td><code>patient.identifier.value</code></td>
			<td colspan="6">EPR-SPID of the patient</td>
		</tr>
		<tr>
			<td><code>policyRule.coding.code</code></td>
			<td colspan="6">value of <code>/PolicySet/PolicySetIdReference</code></td>
		</tr>
		<tr>
			<td><code>provision.period.start</code></td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td>allowed only if the end date is provided</td>
			<td>optional</td>
			<td><em>not populated</em></td>
		</tr>
		<tr>
			<td><code>provision.period.end</code></td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td>optional</td>
			<td>required</td>
			<td><em>not populated</em></td>
		</tr>
		<tr>
			<td><code>provision.actor.role</code></td>
			<td>fixed code: "EprRole|PAT"</td>
			<td>fixed code: "EprRole|HCP"</td>
			<td>fixed code: "EprRole|HCP"</td>
			<td>fixed code: "EprRole|HCP"</td>
			<td>fixed code: "EprRole|HCP"</td>
			<td>fixed code: "EprRole|REP"</td>
		</tr>
		<tr>
			<td><code>provision.actor.reference.identifier.type.coding.code</code></td>
			<td>fixed value: "urn:e-health-suisse:2015:epr-spid"</td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td>fixed value: "urn:gs1:gln"</td>
			<td>fixed value: "urn:oasis: names:tc:xspa: 1.0:subject:organization-id"</td>
			<td>fixed value: "urn:e-health-suisse:representative-id"</td>
		</tr>
		<tr>
			<td><code>provision.actor.reference.identifier.value</code></td>
			<td>EPR‑SPID of the patient</td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td>GLN of the healthcare professional</td>
			<td>OID of the HCP group, in URN format</td>
			<td>ID of the patient's representative</td>
		</tr>
		<tr>
			<td><code>provision.actor.reference.display</code></td>
			<td><em>not populated</em></td>
			<td>fixed value: "all"</td>
			<td>fixed value: "all"</td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
		</tr>
		<tr>
			<td><code>provision.purpose</code></td>
			<td><em>not populated</em></td>
			<td>fixed value: code "EprPurposeOfUse|EMER"</td>
			<td>fixed value: set of codes "EprPurposeOfUse|NORM", "EprPurposeOfUse|AUTO" , "EprPurposeOfUse|DICOM_AUTO"</td>
			<td>fixed value: code "EprPurposeOfUse|NORM"</td>
			<td>fixed value: code "EprPurposeOfUse|NORM"</td>
			<td><em>not populated</em></td>
		</tr>
	</tbody>
</table>

Table 5: Mapping of CH:PPQ policy set elements onto PpqmConsent attributes

## Mapping between CH:PPQm and CH:PPQ Messages

### Transformation of PPQ-3 Requests into PPQ-1 Requests

The PPQ 1 request type depends on the HTTP method used to submit the PPQ 3 request:
- "POST" — AddPolicyRequest.
- "PUT" — UpdatePolicyRequest if the policy already exists in the Policy Repository, otherwise AddPolicyRequest.
- "DELETE" — DeletePolicyRequest.

The policy set in AddPolicyRequest and UpdatePolicyRequest SHALL be constructed as described in section 4.1.1 from 
the [PpqmConsent](StructureDefinition-PpqmConsent.html) resource contained in the PPQ 3 request body.

The policy set ID in the DeletePolicyRequest SHALL be taken from the PPQ 3 request URL.

### Transformation of PPQ-4 Requests into PPQ-1 Requests

PPQ 4 request body is a PpqmRequestBundle resource, where all attributes entry.request.method have the same value — 
"POST", "PUT", or "DELETE".

The PPQ 1 request type depends on this value as follows:
- "POST" — AddPolicyRequest.
- "PUT" — UpdatePolicyRequest if the policy sets contained in the PPQ 4 request bundle already exist in the Policy 
  Repository, otherwise AddPolicyRequest. If some policy sets do already exist in the Policy Repository while 
  others do not, then the transformation of the PPQ 4 request into an PPQ 1 request is not possible, and the PPQ 4 
  request SHALL be rejected (creating two PPQ 1 requests would break the transactional semantics of PPQ 4).
- "DELETE" — DeletePolicyRequest.

Policy sets in AddPolicyRequest and UpdatePolicyRequest SHALL be constructed as described in section 4.1.1 from the
[PpqmConsent](StructureDefinition-PpqmConsent.html) resources embedded in the PPQ 4 request bundle.

Policy set IDs in the DeletePolicyRequest SHALL be taken from the all attributes `entry.request.url` of the PPQ 4 
request bundle.

### Transformation of PPQ-1 Responses into PPQ-3/PPQ-4 Responses

Three variants are possible:
1. PPQ 1 response with the status "urn:e-health-suisse:2015:response-status:success".
2. PPQ 1 response with the status "urn:e-health-suisse:2015:response-status:failure".
3. PPQ 1 call ends with a SOAP Fault.
4. If the PPQ 1 response has the status "urn:e-health-suisse:2015:response-status:success", then the PPQ 3/PPQ 4 
   response SHALL be created according to the sections 3.1.0.4 (for UpdatePolicy), 3.1.0.7 (for DeletePolicy), or 3.1.0.
   8 (for AddPolicy) of the FHIR R4 specification. If the client’s HTTP return preference is OperationOutcome, then 
   this resource SHALL be created as defined in Table 6.

If the PPQ 1 response has the status "urn:e-health-suisse:2015:response-status:failure", then the PPQ 3/PPQ 4 
response SHALL be an OperationOutcome resource created as defined in Table 6, and the HTTP status code SHALL be set 
to 400.

The following mapping SHALL be used when transforming PPQ 1 responses into OperationOutcome resources:
<table class="table table-bordered">
	<tbody>
		<tr>
			<td rowspan="2"><strong>OperationOutcome attribute</strong></td>
			<td colspan="2"><strong>Attribute "status" of the PPQ-1 response: 
urn:e-health-suisse:2015:response-status:<…></strong></td>
		</tr>
		<tr>
			<td><strong>success</strong></td>
			<td><strong>failure</strong></td>
		</tr>
		<tr>
			<td>severity</td>
			<td>fixed value "information"</td>
			<td>fixed value "error"</td>
		</tr>
		<tr>
			<td>code</td>
			<td>fixed value "informational"</td>
			<td>fixed value "processing"</td>
		</tr>
	</tbody>
</table>

Table 6: Mapping of PPQ-1 response elements onto OperationOutcome attributes

If the PPQ 1 call ended with a SOAP Fault, then the PPQ 3/PPQ 4 response SHALL be an OperationOutcome resource 
created as defined in section 4.2.6, and the HTTP status code SHALL be set to the value defined in the same section.

### Transformation of PPQ-5 Requests into PPQ-2 Requests

If the PPQ 5 request URL contains the parameter `patient:identifier`, then the PPQ 2 request SHALL address all 
policies related to the patient referenced there (retrieve policies by EPR-SPID).

If the PPQ 5 request URL contains the parameter `identifier`, then the PPQ 2 request SHALL address the policy set 
referenced there (retrieve policies by direct references).

### Transformation of PPQ-2 Responses into PPQ-5 Responses

Three variants are possible:
1. PPQ 2 response with the status "urn:oasis:names:tc:xacml:1.0:status:ok".
2. PPQ 2 response with another status.
3. PPQ 2 call ends with a SOAP Fault.

If the PPQ 2 response has the status "urn:oasis:names:tc:xacml:1.0:status:ok", then the PPQ 5 response SHALL be a 
Bundle resource compliant to the PpqmRequestBundle profile. For 
each policy set contained in the PPQ 2 response, the following steps SHALL be performed:
- Transform the policy set into a Consent resource compliant to the 
  [PpqmConsent profile](StructureDefinition-PpqmConsent.html), as described in section 4.1.2.
- Add this Consent to the PPQ 5 response Bundle.

If the PPQ 2 response hat the status other than "urn:e-health-suisse: 2015:response-status:failure", then the PPQ 5 
response SHALL be an OperationOutcome resource created as defined in Table 7, and the HTTP status code SHALL be 
according to Table 8.
The following mapping SHALL be used for transformation of negative PPQ 2 responses into OperationOutcome resources:

| OperationOutcome attribute | Value                                                                                 |
|:---------------------------|:--------------------------------------------------------------------------------------|
| `severity`                 | fixed value "error"                                                                   |
| `code`                     | Mapping of `//samlp:StatusCode/@Value` to a FHIR issue type code according to Table 8 |
{:class="table table-bordered"}

Table 7: Mapping of PPQ-2 response elements onto OperationOutcome attributes

| `//samlp:StatusCode/@Value`                          | FHIR Issue type code | HTTP status code |
|:-----------------------------------------------------|:---------------------|:-----------------|
| `urn:oasis:names:tc:SAML:2.0:status:Requester`       | `invalid`            | 400              |
| `urn:oasis:names:tc:SAML:2.0:status:Responder`       | `invalid`            | 500              |
| `urn:oasis:names:tc:SAML:2.0:status:VersionMismatch` | `structure`          | 500              |
{:class="table table-bordered"}

Table 8: Mapping of SAML error codes onto FHIR issue type codes and HTTP status codes

If the PPQ 2 call ended with a SOAP Fault, then the PPQ 5 response SHALL be an OperationOutcome resource created as 
defined in section 4.2.6, and the HTTP status code SHALL be set to the value defined in the same section.

### Transformation of SOAP Faults into OperationOutcome Resources

The following mapping SHALL be used when transforming SOAP Faults into OperationOutcome resources:

| OperationOutcome attribute | Value                                                                                         |
|:---------------------------|:----------------------------------------------------------------------------------------------|
| `severity`                 | fixed value "error"                                                                           |
| `code`                     | Mapping of `/soap:Fault/soap:Code/soap:Value` to a FHIR issue type code according to Table 10 |
| `diagnostics`              | The whole `soap:Fault` element, Base64-encoded                                                |
{:class="table table-bordered"}

Table 9: Mapping of SOAP Fault elements onto OperationOutcome attributes

| SOAP error code       | FHIR issue type code | HTTP status code |
|:----------------------|:---------------------|:-----------------|
| `VersionMismatch`     | `structure`          | 500              |
| `MustUnderstand`      | `not-supported`      | 500              |
| `DataEncodingUnknown` | `structure`          | 500              |
| `Sender`              | `invalid`            | 400              |
| `Receiver`            | `transient`          | 503              |
{:class="table table-bordered"}

Table 10: Mapping of SOAP error codes onto FHIR issue type codes and HTTP status codes
