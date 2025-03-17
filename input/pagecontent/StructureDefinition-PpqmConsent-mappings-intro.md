### Mapping between PpqmConsent Resources and CH:PPQ Policy Sets

#### Transformation of PpqmConsent Resources into CH:PPQ Policy Sets

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

Table 1: Mapping of PpqmConsent attributes onto CH:PPQ policy set template placeholders

#### Transformation of CH:PPQ Policy Sets into PpqmConsent Resources

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
- The ID of the referenced policy set (value of the element `<PolicySetIdReference>`) contains the substring 
  "delegation" → template **304**.  
- Otherwise → template **301**.

The [PpqmConsent](StructureDefinition-PpqmConsent.html) resource attributes SHALL be populated according to the
rules defined for each template in the table below:

<table class="table table-bordered">
	<thead>
		<tr>
			<td><strong>PpqmConsent attribute</strong></td>
			<td><strong>Template 201</strong><br>(full access for the patient)</td>
			<td><strong>Template 202</strong><br>(confidentiality level for emergency read access)</td>
			<td><strong>Template 203</strong><br>(minimal confidentiality level for upload)</td>
			<td><strong>Template 301</strong><br>(individual read access permissions)</td>
			<td><strong>Template 302</strong><br>(group read access permissions)</td>
			<td><strong>Template 303</strong><br>(full access for the patient's representative)</td>
			<td><strong>Template 304</strong><br>(individual read access permissions with delegation)</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><code>identifier.value</code> (1)</td>
			<td colspan="7">value of <code>/PolicySet/@PolicySetId</code></td>
		</tr>
		<tr>
			<td><code>identifier.type</code> (1)</td>
			<td colspan="7">fixed value: code "http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType|policySetId"</td>
		</tr>
		<tr>
			<td><code>identifier.value</code> (2)</td>
			<td>fixed value: "201"</td>
			<td>fixed value: "202"</td>
			<td>fixed value: "203"</td>
			<td>fixed value: "301"</td>
			<td>fixed value: "302"</td>
			<td>fixed value: "303"</td>
			<td>fixed value: "304"</td>
		</tr>
		<tr>
			<td><code>identifier.type</code> (2)</td>
			<td colspan="7">fixed value: code "http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType|templateId"</td>
		</tr>
		<tr>
			<td><code>status</code></td>
			<td colspan="7">fixed value: code "active"</td>
		</tr>
		<tr>
			<td><code>scope</code></td>
			<td colspan="7">fixed value: code "http://terminology.hl7.org/CodeSystem/consentscope|patient-privacy"</td>
		</tr>
		<tr>
			<td><code>category</code></td>
			<td colspan="7">fixed value: code "http://terminology.hl7.org/CodeSystem/v3-ActCode|INFA"</td>
		</tr>
		<tr>
			<td><code>patient.identifier.system</code></td>
			<td colspan="7">fixed value: "urn:oid:2.16.756.5.30.1.127.3.10.3"</td>
		</tr>
		<tr>
			<td><code>patient.identifier.value</code></td>
			<td colspan="7">EPR-SPID of the patient</td>
		</tr>
		<tr>
			<td><code>policyRule.coding.code</code></td>
			<td colspan="7">value of <code>/PolicySet/PolicySetIdReference</code></td>
		</tr>
		<tr>
			<td><code>provision.period.start</code></td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td>allowed only if the end date is provided</td>
			<td>optional</td>
			<td><em>not populated</em></td>
			<td>optional</td>
		</tr>
		<tr>
			<td><code>provision.period.end</code></td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td>optional</td>
			<td>required</td>
			<td><em>not populated</em></td>
			<td>required</td>
		</tr>
		<tr>
			<td><code>provision.actor.role.coding.code</code></td>
			<td>fixed value: "PAT"</td>
			<td>fixed value: "HCP"</td>
			<td>fixed value: "HCP"</td>
			<td>fixed value: "HCP"</td>
			<td>fixed value: "HCP"</td>
			<td>fixed value: "REP"</td>
			<td>fixed value: "HCP"</td>
		</tr>
		<tr>
			<td><code>provision.actor.role.coding.system</code></td>
			<td colspan="7">fixed value: "urn:oid:2.16.756.5.30.1.127.3.10.6"</td>
		</tr>
		<tr>
			<td><code>provision.actor.reference.identifier.type.coding.code</code></td>
			<td>fixed value: "urn:e-health-suisse:2015:epr-spid"</td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td>fixed value: "urn:gs1:gln"</td>
			<td>fixed value: "urn:oasis:names:tc:xspa:1.0:subject:organization-id"</td>
			<td>fixed value: "urn:e-health-suisse:representative-id"</td>
			<td>fixed value: "urn:gs1:gln"</td>
		</tr>
		<tr>
			<td><code>provision.actor.reference.identifier.value</code></td>
			<td>EPR‑SPID of the patient</td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td>GLN of the healthcare professional</td>
			<td>OID of the HCP group, in URN format</td>
			<td>ID of the patient's representative</td>
			<td>GLN of the healthcare professional</td>
		</tr>
		<tr>
			<td><code>provision.actor.reference.identifier.system</code></td>
			<td>fixed value: "urn:oid:2.16.756.5.30.1.127.3.10.3"</td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td>fixed value: "urn:oid:2.51.1.3"</td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td>fixed value: "urn:oid:2.51.1.3"</td>
		</tr>
		<tr>
			<td><code>provision.actor.reference.display</code></td>
			<td><em>not populated</em></td>
			<td>fixed value: "all"</td>
			<td>fixed value: "all"</td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
			<td><em>not populated</em></td>
		</tr>
		<tr>
			<td><code>provision.purpose.code</code></td>
			<td><em>not populated</em></td>
			<td>fixed value: "EMER"</td>
			<td>fixed values: "NORM", "AUTO", "DICOM_AUTO"<br/>(each in its own repetition of <code>provision.purpose</code>)</td>
			<td>fixed value: "NORM"</td>
			<td>fixed value: "NORM"</td>
			<td><em>not populated</em></td>
			<td>fixed value: "NORM"</td>
		</tr>
		<tr>
			<td><code>provision.purpose.system</code></td>
			<td colspan="7">fixed value: "urn:oid:2.16.756.5.30.1.127.3.10.5" if <code>provision.purpose.code</code> is provided; otherwise not present</td>
		</tr>
	</tbody>
</table>

Table 2: Mapping of CH:PPQ policy set elements onto PpqmConsent attributes
