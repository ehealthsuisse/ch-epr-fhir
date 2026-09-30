This section specifies Swiss national extensions to Patient Identifier Cross-referencing for mobile (PIXm) profile. PIXm is [published](https://profiles.ihe.net/ITI/PIXm/index.html) as an IHE ITI Trial Implementation profile.

###	Scope  
In the Swiss Health Dossier, the PIXm profile ensures that different systems can update the patient contact information.

###	Use Cases  
Patient data like address, contact information (phone number, e-mail) are allowed to be updated by a Health App.

###	Actors and Transactions, Content Specifications  
This national extension adds restrictions to only allow updating of a contact information of a patient. 
Otherwise there are no extensions or restrictions to the profile actors and the transaction. 

<div>
{%include PIXm_actor_diagram.svg %}
</div>
This figure shows the actors directly involved in the _Patient Identifier Cross-referencing for mobile_ Profile and 
the relevant transactions between them.

The Mobile Patient Identifier Cross-reference Query [[ITI-83]](https://profiles.ihe.net/ITI/PIXm/ITI-83.html) transaction defined in [PIXm](https://profiles.ihe.net/ITI/PIXm/index.html) SHALL not be made available in this context.

### Actor Options  
No extensions or restrictions to the profile actor options are specified in the Swiss national extension. Support for the 'Remove Patient' option for Patient Identity Source and Patient Identifier Cross-reference Manager is not required. 

### Required Actor Grouping  
This national extension enforces authentication and authorization for access control. Therefore actors of this profile must be grouped with actors of other profiles according to the following table: 

| Actor                                         |Required Grouping                                                 | Optionality | Remark |
|-----------------------------------------------|------------------------------------------------------------------|-------------|--------|
| Patient Identifier   Cross-reference Manager  |[IUA Resource Server](iti-iua.html#actors-and-transactions)       | R           | -      |
| Patient Identity Source                       |[IUA Authorization Client](iti-iua.html#actors-and-transactions)  | R           | `TCU` not allowed |
{:class="table table-bordered"}

<figcaption ID="1">Table 1: Grouping of PIXm actors required by this national extension. </figcaption>

<br/>

###	Security Consideration
This national extension enforces authentication and authorization of access to the Patient Identifier Cross-reference 
Manager using the IUA profile as described in [IUA](iti-71.html).
