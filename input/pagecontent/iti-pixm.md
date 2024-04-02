This section specifies Swiss national extensions to Patient Identifier Cross-referencing for mobile (PIXm) profile. PIXm is [published](https://profiles.ihe.net/ITI/PIXm/index.html) as an IHE ITI Trial Implementation profile.

###	Scope  
In the Swiss EPR, the PIXm profile ensures that different systems can correlate the local identity with the MPI-PID (and EPR-SPID) for the community and that the initial demographics data can be fed to the MPI. The profile supports creation, update and deprecation of patient master identity information about a subject of care using the HL7 FHIR standard resources and RESTful transactions.

###	Use Cases  
An EPR App wants to get data from the EPR. The EPR App needs to know the MPI-PID in the community. With the local 
identifier the EPR App can query the MPI-PID (and EPR-SPID) for the community. The local identifier with the initial 
demographics data needs to be setup initially in the community that the correlation is possible.

###	Actors and Transactions, Content Specifications  
This national extension adds restrictions to the correlation to other local identifiers, to the query results and a specific patient content profile is defined. Otherwise there are no extensions or restrictions to the profile actors and the transaction. 

<div>
{%include PIXm_actor_diagram.svg %}
</div>
This figure shows the actors directly involved in the _Patient Identifier Cross-referencing for mobile_ Profile and 
the relevant transactions between them.

### Actor Options  
No extensions or restrictions to the profile actor options are specified in the Swiss national extension. Support for the 'Remove Patient' option for Patient Identity Source and Patient Identifier Cross-reference Manager is not required. 

### Required Actor Grouping  
This national extension enforces authentication and authorization for access control. Therefore actors of this profile must be grouped with actors of other profiles according to the following table: 

| Actor                                         | Required Grouping         | Optionality |
|-----------------------------------------------|---------------------------|-------------|
| Patient Identifier   Cross-reference Manager  | IUA Resource Server       | R           |
| Patient Identity Source                       | IUA Authorization Client  | R           |
| Patient Identifier Cross-reference Consumer   | IUA Authorization Client  | R           |
{:class="table table-bordered"}

<figcaption ID="1">Table 1: Grouping of PIXm actors required by this national extension. </figcaption>

###	Process Flow
For the process flow of this profile and its interplay with the other profiles see [sequence diagrams](sequencediagrams.html). 

###	Security Consideration
This national extension enforces authentication and authorization of access to the Patient Identifier Cross-reference Manager using the IUA profile with basic access token as described in [IUA](iti-71.html).
