This section specifies Swiss national extensions to Internet User Authorization (IUA) Profile, which is [published](https://profiles.ihe.net/ITI/IUA/index.html) as an IHE ITI Trial Implementation profile.

### Scope  
There is no extension or restriction of the profile scope defined in this national extension. 
As described in the IUA Trial Implementation the profile is intended to provide means to retrieve EPR conformal access token (SAML or JWT) and to incorporate the access token to transactions which access protected resources.  

### Use Cases  
No extensions or restrictions to the use cases defined in the IUA profile are specified in the Swiss in national extension.

### Actors and Transactions   
No extensions or restrictions to the IUA actors and transactions are specified in the Swiss national extension. 

### Actor Options  
This national extension restricts the IUA options to the Authorization Server Metadata, JWT Token and SAML Token option. The Token Introspection option of the IUA profile SHALL not be used. 

### Grouping  
The Swiss national extension does not define requirements on the grouping of actors in this profile, which extend or restrict the grouping required from the IUA profile. 

### Process Flow  
For the process flow of this profile and its interplay with the other mHealth profiles see [sequence diagrams](sequencediagrams.html). 

### Security Consideration  
The IUA Authorization Server SHALL enforce authentication of the user by redirecting the mHealth App to the User Authentication Provider (Identity Provider) as described in [IUA](iti-71.html#expected-actions-iua-authorization-server).  
