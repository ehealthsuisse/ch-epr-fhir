This section specifies Swiss national extensions to Internet User Authorization (IUA) Profile, which is [published](https://profiles.ihe.net/ITI/IUA/index.html) as an IHE ITI Trial Implementation profile.

### Scope  
This profile provides means to retrieve EPR compliant access token and to incorporate the access token to transactions to authorize client applications when accessing protected resources. 

This profile is based on the IHE IUA Trial Implementation and adds certain restrictions to be compliant to the ordinances of the Swiss EPR. 

The scope of this profile is limited to primary systems and portals and the following options for native mobile clients present in the IUA Trial Implementation are not supported:
 * SMART on FHIR App launch of standalone Apps without a launch context. 
 * Client Authorization by User Consent at application launch.

For further restrictions on transactions and security consideration, see below. 

### Use Cases 

#### Patient Access from a Portal

A patient uses a portal which is integrated to the Swiss EPR using the mHealth profiles to access and share data and documents with healtcare professionals. To access documents from the EPR the patient authenticates at a certified Identity Provider and the portal connects to the IUA Authorization Server and sends the required claims to access the EPR. 

The IUA Authorization Server verifies if the portal is authorized to access the EPR on behalf of the patient by checking that the portal is registered as a protal of the community.

The IUA Authorization Server verfies that the patient has a valid session at the Identity Provider and retrieves the Identity Assertion from the Identity Provider. The Authorization Server validates the claims together with the data from the Identity Assertion and resolves additional information required to access the EPR (e.g., resolve the digital identity to the EPR-SPID).

The IUA Authorization Server responds an IUA Authorization Token the portal shall incorporate to any transaction to retrieve the data and documents from the patients EPR.

#### User Access from an integrated Primary System

A healthcare professional uses a primary system which is integrated to the Swiss EPR using the mHealth profiles to access and share data and documents with her patients or other healtcare professionals. To access documents from the EPR the healthcare professional authenticates in her primary system, selects the patient and switches to the user interface to display the patients documents and the primary system connects to the IUA Authorization Server and sends the required claims to access the patients EPR. 

The IUA Authorization Server verifies if the primary system is authorized to access the EPR on behalf of the user by checking that the primary system has been registered during the onboarding process of the primary system.

The IUA Authorization Server verfies that the healthcare professional has a valid session at the Identity Provider and retrieves the Identity Assertion from the Identity Provider. The Authorization Server validates the claims together with the data from the Identity Assertion and resolves additional information required to access the EPR (e.g., resolve the relations to institutions or other groups).

The IUA Authorization Server responds an IUA Authorization Token the primary system shall incorporate to any transaction to retrieve the data and documents from the patients EPR.

#### User Access from a SMART on FHIR component

A patient or healthcare professional uses a portal or primary system which uses SMART on FHIR Apps to connect to the Swiss EPR.  

The patient or healthcare professional authenticates in the portal or primary system and launches the SMART on FHIR App from the portal or primary system. The portal or primary system first builds a SMART on FHIR launch context with the patient context and identifiers of the portal or primary system application and launches the SMART on FHIR App with the launch context.

The IUA Authorization Server verifies that the portal or primary system is authorized to launch SMART on FHIR Apps which connect to the EPR on behalf of the user by checking that the portal or primary system has been registered beforehand during the onboarding process of the portal or primary system application.

The IUA Authorization Server verfies that the patient or healthcare professional has a valid session at the Identity Provider and retrieves the Identity Assertion from the Identity Provider. The Authorization Server validates the claims together with the data from the Identity Assertion and resolves additional information the SMART on FHIR App requires to access the EPR (e.g., resolve the digital identity to th EPR-SPID).

The IUA Authorization Server responds an IUA Authorization Token the SMART on FHIR App shall incorporate to any transaction to retrieve the data and documents from the patients EPR.


### Actors and Transactions   
No extensions or restrictions to the IUA actors and transactions are specified in the Swiss national extension. 

### Actor Options  
This national extension restricts the IUA options to the Authorization Server Metadata and JWT Token option. The SAML Token and Token Introspection optios of the IHE IUA Trial Implementation SHALL not be used. 

### Grouping  
The Swiss national extension does not define requirements on the grouping of actors in this profile, which extend or restrict the grouping required from the IUA profile. 

### Process Flow  
For the process flow of this profile and its interplay with the other mHealth profiles see [sequence diagrams](sequencediagrams.html). 

### Security Consideration  
The IUA Authorization Server SHALL enforce authentication of the user by redirecting the App to the User Authentication Provider (Identity Provider) as described in [IUA](iti-71.html#expected-actions-iua-authorization-server).
