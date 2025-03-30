### Overview

This profile defines the audit trail consumption requirements a community has to provide for a patient’s audit trail.

The profile CH:ATC defines and precises the actors and Retrieve Audit Event [ITI-81] of the [IHE ITI Supplement Add RESTful Query to ATNA](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf) and defines the content of the Audit Messages. The different types of the Audit Messages are based on the requirements for Document and Access Policy management as well as the entry of healthcare professionals into a group in order to achieve the Swiss regulation needs on the audit trail access by patients. These Audit Event types differ from the Audit Events which have also to be logged according to the ATNA requirements.

{% include img.html img="chatc-overview.png" caption="Figure 1: CH:ATC Overview within the Swiss EPR circle of trust" width="60%" %}

Each community shall provide one endpoint to a Patient Audit Record Repository which can be queried according to the Retrieve Audit Event [ITI-81] RESTful Query transaction. A reference community shall implement a Patient Audit Consumer which will query all Patient Audit Record Repositories, aggregate the results and provide it to the patient.

How the Patient Audit Record Repository generates or collects the specified Audit Events within the community is outside the scope of this profile.


### Actors, Transactions and Content Modules
Figure 2 shows the actors directly involved in the CH:ATC Profile and the relevant transactions between them. If needed for context, other actors that may be indirectly involved due to their participation in other related profiles are shown in dotted lines.

{% include img.html img="chatc-actor-diagram.png" caption="Figure 2: CH:ATC Actor diagram" width="60%" %}

Table 1 lists the transactions for each actor directly involved in the CH:ATC Profile. To claim compliance with this Profile, an actor shall support all required transactions (labeled "R") and may support the optional transactions (labeled "O").

{:class="table table-bordered"}
| Actors | Transactions | Initiator or Responder | Opt | Reference |
| --- | --- | --- | --- | --- |
| Patient Audit Consumer | Retrieve Audit Event [ITI-81] | Initiator | R | [Patient Audit Consumer](#patient-audit-consumer) |
| Patient Audit Record Repository | Retrieve Audit Event [ITI-81] | Responder | R | [Patient Audit Record Repository](#patient-audit-record-repository) |

_Table 1: CH:ATC Profile - Actors and Transactions_

#### Actor Descriptions and Actor Profile Requirements

The actors defined in this profile are based on the [IHE ITI TF-2](https://profiles.ihe.net/ITI/TF/Volume2/index.html) and the [IHE ITI Supplement Add RESTful Query to ATNA](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf) actors. This section documents any additional requirements on the profile’s actors required in the Swiss EPR context.

#### Patient Audit Record Repository

For the actor Patient Audit Record Repository the actor Audit Record Repository in [IHE ITI Supplement Add RESTful Query to ATNA](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA_Rev3-3_TI_2021-07-02.pdf) is relevant.

The Patient Audit Record Repository shall support the Retrieve Audit Message Option from the Audit Record Repository ([IHE ITI Supplement Add RESTful Query to ATNA, chapter 9.2.3](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA_Rev3-3_TI_2021-07-02.pdf)) with the search capabilities as defined in [IHE ITI TF-2, chapter 3.81](https://profiles.ihe.net/ITI/TF/Volume2/ITI-81.html) and the Audit Message Formats defined in Volume 3 - Content Profiles.

#### Patient Audit Consumer

For the actor Patient Audit Consumer the actor Audit Consumer in [IHE ITI Supplement Add RESTful Query to ATNA](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf) is relevant.

The Patient Audit Consumer queries a Patient Audit Record Repository for Audit Events defined by this profile. The Patient Audit Consumer shall support the Retrieve Audit Message Option from the Audit Consumer ([IHE ITI Supplement Add RESTful Query to ATNA, chapter 9.2.3](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA_Rev3-3_TI_2021-07-02.pdf)).

The Patient Audit Consumer should filter duplicate AuditEvents for display (e.g. Document Retrieval Audit Event for the same document access are in multiple Patient Audit Record Repositories, because the requesting and responding community need to make the AuditEvent available).

Subsequent processing like translation of the coded elements into the users preferred language and display of the query result is not defined in this profile.


### Integration Profile Options

{:class="table table-bordered"}
| CH:ATC Actor | Option name |
| --- | --- |
| Patient Audit Consumer | Aggregate Audit Message Option |
| Patient Audit Record Repository | - |

_Table 2: Actors and Options_

The Aggregate Audit Message Option allows the Patient Audit Consumer to aggregate results from multiple Patient Audit Record Repositories. A reference community shall provide at least one Patient Audit Consumer with this Option. If a Patient Audit Consumer implementing this option is unable to obtain audit records from a particular community, the Patient Audit Consumer shall add an OperationOutcome with a severity “warning” and the OID of the non-responding community to the aggregated results.


### Actor Groupings

An actor from this profile (Column 1) shall implement all of the required transactions and/or content modules in this profile <i><strong>in addition to <u>all</u></strong></i> of the requirements for the grouped actor.

{:class="table table-bordered"}
<table>
	<thead>
		<tr>
			<td>
				<p><strong>CH:ATC Actor</strong></p>
			</td>
			<td>
				<p><strong>Grouping Condition</strong></p>
			</td>
			<td>
				<p><strong>Actor to be grouped with</strong></p>
			</td>
			<td>
				<p><strong>Reference</strong></p>
			</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td rowspan="3">
				<p>Patient Audit Consumer</p>
			</td>
			<td>
				<p>Required¹</p>
			</td>
			<td>
				<p>ATNA - Secure Node</p>
			</td>
			<td>
				<p>Amendment 1 of Annex 5 EPRO-FDHA</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Required</p>
			</td>
			<td>
				<p>IUA - Authorization Client</p>
			</td>
			<td>
				<p><a href="https://profiles.ihe.net/ITI/IUA/index.html">IHE ITI Suppl IUA</a></p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Optional</p>
			</td>
			<td>
				<p>CH:CPI - CPI Consumer</p>
			</td>
			<td>
				<p>Amendment 2.3 of Annex 5 EPRO-FDHA</p>
			</td>
		</tr>
		<tr>
			<td rowspan="3">
				<p>Patient Audit Record Repository</p>
			</td>
			<td>
				<p>Required¹</p>
			</td>
			<td>
				<p>ATNA - Secure Node</p>
			</td>
			<td>
				<p>Amendment 1 of Annex 5 EPRO-FDHA</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Required</p>
			</td>
			<td>
				<p>CH:ADR - Authorization Decision Consumer</p>
			</td>
			<td>
				<p>Amendment 2.1 of Annex 5 EPRO-FDHA</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Required</p>
			</td>
			<td>
				<p>IUA - Resource Server</p>
			</td>
			<td>
				<p><a href="https://profiles.ihe.net/ITI/IUA/index.html">IHE ITI Suppl IUA</a></p>
			</td>
		</tr>
	</tbody>
</table>

_Table 3: Actor Grouping_

¹: The Secure Node grouping is only required when a XUA token is used. See Section
[Security Considerations](#security-considerations) for more details.

Section [Security Considerations](#security-considerations) describes the groupings required for security considerations.


### Overview - Use Cases

Activities related to the EPR are audited for specific document and access policy management events as well as entry events of healthcare professionals into a group and stored in the communities.

This profile supports the following Use Cases:   

<ol type="a">
  <li>A patient can request protocols of the activities related to his EPR.</li>
  <li>A patient representative can request a protocol of the activities related to the patients delegated EPR.</li>
</ol>

### Security Considerations
This national extension enforces authentication and authorization of access using the IUA profile with basic access token as described in [IUA](iti-71.html).
