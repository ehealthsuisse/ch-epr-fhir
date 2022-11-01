This section specifies Swiss national extensions to the Mobile Access to Health Documents (MHD) with XDS on FHIR Profile, which is [published](https://profiles.ihe.net/ITI/MHD/index.html) as an IHE ITI Trial Implementation profile.

### Scope  
A mHealth App can query, retrieve or publish data to EPR communities using the transaction of the MHD profile.   

###	Use Cases  
No extensions or restrictions to the profile use cases are specified in the Swiss in national extension. 

###	Actors and Transactions  
No extensions or restrictions to the actors and transactions are specified in the Swiss national extension.

### Actor options  
For all actors the Comprehensive Metadata Option and the XDS on FHIR Option SHALL be supported. For all actors the Metadata as defined in Annex 3 SHALL be supported.

### Required Actor Groupings  
The Actors Document Recipient and Document Responder MUST be grouped according to the XDS on FHIR grouping condition see Table 33.3-1: MHD - Actors Required Grouping.
This national extension enforces authentication and authorization for access control. Therefore actors of this profile must be grouped with actors of other profiles according to the following table: 


{:class="table table-bordered"}
| Actor                                         | Required Grouping         | Optionality |
|-----------------------------------------------|---------------------------|-------------|
| Document Recipient                            | IUA Resource Server       | R           |
| Document Responder                            | IUA Authorization Client  | R           |
| Document Source                               | IUA Authorization Client  | R           |
| Document Consumer                             | IUA Authorization Client  | R           |

<figcaption ID="2">Table 2: Grouping of MHD actors required by this national extension.</figcaption>

###	Process Flow
For the process flow of this profile and its interplay with the other mHealth profiles see [sequence diagrams](sequencediagrams.html). 

### Security Consideration
This national extension enforces authentication and authorization of access to the Patient Identity Manager using the IUA profile with extended access token as described in [IUA](iti-71.html#expected-actions-iua-authorization-server).
