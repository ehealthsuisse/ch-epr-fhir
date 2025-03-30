### Scope
According to Swiss EPR regulations, patients shall decide who is authorized to view the documents and data in 
their EPR, and under which circumstances (cf. emergency access). The national integration profile "Privacy Policy 
Query" (CH:PPQ, see Amendment 2.1 of Annex 5 EPRO-FDHA) defines how these decisions are transmitted as patient privacy policies in 
XACML 2.0 format and the SOAP transport protocol. This profile offers the same functionality based on lightweight HL7 FHIR® resources 
and RESTFul transactions. 

### Use Cases 

#### EPR Onboarding
A patient contacts a community to open an EHR in the community. The patient passes the identification 
process of the community and consents to the EHR. The policy administrator of the community documents 
the patient consent by adding the patient policies to the policy repository. 

The policy administrator of the community adds the following patient privacy policies to the policy repository with the 
Mobile Privacy Policy Feed (PPQ-3) or Mobile Privacy Policy Bundle Feed (PPQ-4) transaction:
* [EPR policy set based on template 201](StructureDefinition-PpqmConsentTemplate201.html) to grant the patient access the EHR.
* [EPR policy set based on template 203](StructureDefinition-PpqmConsentTemplate203.html) to set the default confidentiality level for new documents.

When both of the above policies are stored in the policy repository of the community, healthcare professionals upload 
all new treatment documents to the patients EHR with the confidentiality set as the default confidentiality level, or higher. 

#### Patient authorizes a healthcare professional 
A patient wants to authorize a healthcare professional to access the patients EHR and to view the documents on a specific access level. 
The patient authenticates in the patient portal and opens the view to the access policy settings. The patient opens the form to authorize 
an individual healthcare professional and searches for the healthcare professional entry. The patient selects the healthcare professional 
to be authorized, optionally sets an authorization end date and selects whether the healthcare professional is also authorized 
to delegate the access rights.  

To authorize the healthcare professional, the patient portal adds the following policies to the policy repository with the 
Mobile Privacy Policy Feed (PPQ-3) or Mobile Privacy Policy Bundle Feed (PPQ-4) transaction: 
* [EPR policy set based on template 304](StructureDefinition-PpqmConsentTemplate304.html), if the healthcare professional is authorized to delegate the access rights,  
* [EPR policy set based on template 301](StructureDefinition-PpqmConsentTemplate301.html), otherwise. 

#### Patient authorizes a group of healthcare professionals
A patient wants to authorize a group of healthcare professionals to access the patients EHR and to view the documents on a specific access level. 
The patient authenticates in the patient portal and opens the view to the access policy settings. The patient opens the form to authorize groups 
and searches for the group entry. The patient selects the group to be authorized and sets an authorization end date.

To authorize the group of healthcare professionals, the patient portal adds the following patient private policy to the policy repository with the 
Mobile Privacy Policy Feed (PPQ-3) or Mobile Privacy Policy Bundle Feed (PPQ-4) transaction:
* [EPR policy set based on template 302](StructureDefinition-PpqmConsentTemplate302.html)

#### Patient updates the default confidentiality level
A patient wants to enforce, that all documents stored in the EHR are stored with a minimal confidentiality level. The patient authenticates in 
the patient portal and opens the view to the default confidentiality level settings. The patient sets the default confidentiality level in a form provided by 
the patient portal. 

To set the default confidentiality level, the patient portal updates the following patient privacy policy in the policy repository with the 
Mobile Privacy Policy Feed (PPQ-3) or Mobile Privacy Policy Bundle Feed (PPQ-4) transaction:
* [EPR policy set based on template 203](StructureDefinition-PpqmConsentTemplate203.html)

#### Patient changes the emergency access setting 
A patient wants to change the current setting of the emergency access, which grants all healthcare professionals access to the EHR in a emergency situation. 
The patient authenticates in the patient portal and opens the view of the emergency access setting. The patient disallows emergency access or sets the 
maximum confidentiality level of documents accessible in emergency situations in the form of the emergency settings.

To disallow or allow emergency access of documents up to a confidentiality level, the patient portal deletes or updates the following policy in the policy repository 
with the Mobile Privacy Policy Feed (PPQ-3) or Mobile Privacy Policy Bundle Feed (PPQ-4) transaction:
* [EPR policy set based on template 202](StructureDefinition-PpqmConsentTemplate202.html)

#### Healthcare professional delegates the access rights
A healthcare professional previously authorized by the patient to delegate access rights (e.g., substitution during holidays, second opinions), delegates the 
access rights to another healthcare professional. The healthcare professional authenticates in the portal or primary system and 
opens the view with the delegation settings. The healthcare opens the form to change the delegation settings and searches for the healthcare 
professional to delegate the access rights to. The healthcare professional selects the healthcare professional entry to be authorized and optionally sets 
a delegation end date.

To delegate the access rights, the portal or primary system adds or updates the following policy in the policy repository with the 
Mobile Privacy Policy Feed (PPQ-3) or Mobile Privacy Policy Bundle Feed (PPQ-4) transaction:
* [EPR policy set based on template 301](StructureDefinition-PpqmConsentTemplate301.html)

#### Policy Administrator sets a patient representative 
A policy administrator of the home community intends to set a person as a patient representative. The policy administrator authenticates to the 
portal and selects the view of patient representatives. The policy administrator opens the form to add a representative for the patient and enters the 
required data.

To add the person as patient representative, the portal adds the following policy in the policy repository with the 
Mobile Privacy Policy Feed (PPQ-3) or Mobile Privacy Policy Bundle Feed (PPQ-4) transaction:
* [EPR policy set based on template 303](StructureDefinition-PpqmConsentTemplate303.html)


### Actors and Transactions

CH:PPQm comprises the following actors and transactions:

<figure>
  <img src="assets/images/ppqm-actors.svg" alt="CH:PPQm actor diagram"/>
  <figcaption>Figure 1: CH:PPQm actor diagram</figcaption>
</figure>


**Actor:** Policy Repository<br>
**Role:** Stores policies and policy sets and provides the possibility to add, query, update and delete them<br>
**Actor:** Policy Source<br>
**Role:** Initiates addition, update and deletion of policies and policy sets<br>
**Actor:** Policy Consumer<br>
**Role:** Retrieves policies and policy sets

Table 1 lists the transactions for each actor directly involved in the CH:PPQm Profile. To claim compliance with 
this profile, an actor shall support all required transactions (labeled "R") and may support the optional 
transactions (labeled "O").

| Actors            | Transactions                              | Optionality | Section             |
|-------------------|-------------------------------------------|-------------|---------------------|
| Policy Repository | Mobile Privacy Policy Feed (PPQ-3)        | R           | [PPQ-3](ppq-3.html) |
|                   | Mobile Privacy Policy Bundle Feed (PPQ-4) | R           | [PPQ-4](ppq-4.html) |
|                   | Mobile Privacy Policy Retrieve (PPQ-5)    | R           | [PPQ-5](ppq-5.html) |
| Policy Source     | Mobile Privacy Policy Feed (PPQ-3)        | O (Note 1)  | [PPQ-3](ppq-3.html) |
|                   | Mobile Privacy Policy Bundle Feed (PPQ-4) | O (Note 1)  | [PPQ-4](ppq-4.html) |
| Policy Consumer   | Mobile Privacy Policy Retrieve (PPQ-5)    | R           | [PPQ-5](ppq-5.html) |
{:class="table table-bordered"}

Table 1: CH:PPQm transactions

Note 1: The actor SHALL support at least one transaction.

The required actor groupings are shown in Table 2:

| Actors            | Actor to be grouped with |
|-------------------|--------------------------|
| Policy Repository | IUA Resource Server      |
|                   | ATNA Secure Application  |
| Policy Source     | IUA Authorization Client |
|                   | ATNA Secure Application  | 
| Policy Consumer   | IUA Authorization Client |
|                   | ATNA Secure Application  |
{:class="table table-bordered"}

Table 2: CH:PPQm required actors groupings

### Referenced Standards

- HL7 FHIR standard Release 4: [http://hl7.org/fhir/R4/index.html](http://hl7.org/fhir/R4/index.html)

See also:
- CH:PPQ specification in the [Amendment 2.1 of Annex 5 EPRO-FDHA](https://www.fedlex.admin.ch/eli/oc/2023/221/de/annexes).
- [Policy set templates](https://github.com/ehealthsuisse/ch-epr-adr-ppq/tree/main/Privacy%20Policy%20Stack/Patient%20Specific%20via%20Policy%20Manager)
  in the official EPR policy stack.
- [Description of the official EPR policy stack](https://github.com/ehealthsuisse/ch-epr-adr-ppq/blob/main/docs/Policies.md).

### Security Consideration
This national extension enforces authentication and authorization of access using the IUA profile with basic access token as described in [IUA](iti-71.html).

### Relation between CH:PPQm and CH:PPQ

_This section is not normative._

Implementers may decide to implement CH:PPQm transactions on top of CH:PPQ ones, i.e. to create a FHIR layer over an 
existing XACML-based Policy Repository. The CH:PPQm specification supports this approach by defining transactions 
and data structures in a way which allows an efficient bridging between CH:PPQ and CH:PPQm, and by providing message 
transformation rules (see the page [Mappings](StructureDefinition-PpqmConsent-mappings.html)).

In terms of actor grouping, this would mean that the Policy Repository may be optionally grouped with CH:PPQ Policy 
Source and CH:PPQ Policy Consumer in order to communicate over PPQ-1 and PPQ-2 with itself.

Note that CH:PPQm is not intended to handle base policies and policy sets, i.e. the ones provided in the official 
Policy Stack and not related to any particular patients.

### Further Aspects

In order to provide interoperability between CH:PPQ and CH:PPQm, the page 
[Mappings](StructureDefinition-PpqmConsent-mappings.html) defines transformation rules between XACML 2.0 
Policy Sets and [PpqmConsent](StructureDefinition-PpqmConsent.html) resources.
