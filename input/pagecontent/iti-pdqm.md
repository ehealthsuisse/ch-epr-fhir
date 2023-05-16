This section specifies Swiss national extensions to Patient Demographics Query for mobile (PDQm). PDQm is [published](https://profiles.ihe.net/ITI/PDQm/index.html) as an IHE ITI Trial Implementation profile.

###	Scope  
In the Swiss EPR, the PDQm profile ensures that different systems can search patients participating in the Swiss EPR by demographics and that the initial demographics data can be retrieved from the MPI. 

###	Use Cases  
A mHealth App wants to search a patient participating in the EPR. The mHealth App needs to provide demographic search cirterias and can then retreive patients matching this parameters.

###	Actors and Transactions, Content Specifications  
This national extension adds restrictions to the amount of query results if too many many are found. Otherwise there are no extensions or restrictions to the profile actors and the transaction. 

### Actor Options  
No extensions or restrictions to the profile actor options are specified in the Swiss national extension. 

### Required Actor Grouping  
This national extension enforces authentication and authorization for access control. Therefore actors of this profile must be grouped with actors of other profiles according to the following table: 

{:class="table table-bordered"}
| Actor                                         | Required Grouping         | Optionality |
|-----------------------------------------------|---------------------------|-------------|
| Patient Demographics Supplier                 | IUA Resource Server       | R           |
| Patient Demographics Consumer                 | IUA Authorization Client  | R           |

<figcaption ID="1">Table 1: Grouping of PDQm actors required by this national extension. </figcaption>

###	Security Consideration
This national extension enforces authentication and authorization of access to the Patient Demographics Supplier using the IUA profile with basic access token as described in [IUA](iti-71.html).
