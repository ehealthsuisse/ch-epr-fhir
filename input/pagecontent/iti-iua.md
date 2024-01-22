This section specifies Swiss national extensions to Internet User Authorization (IUA) Profile, which is [published](https://profiles.ihe.net/ITI/IUA/index.html) as an IHE ITI Trial Implementation profile.

### Scope

This profile provides means to retrieve EPR compliant access token and to incorporate the access token to transactions to authorize client applications when accessing protected resources. 

This profile is based on the IUA Trial Implementation and adds certain restrictions to be compliant to the ordinances of the Swiss EPR. 

The scope of this national extension is limited to provide FHIR based interfaces for primary systems and portals connected to the Swiss EPR. This national extension is currently not scoped for native mobile clients. This profile therefore adds the following restrictions to the IUA Trial Implementation:

* SMART on FHIR Apps launched from portals and primary systems require a launch context identifying the portal or primary system. 
* Only portals and primary systems registered in the community during the onboarding process may retrieve an authorization token. The Client Authorization by User Consent method of the IUA Trial Implementation SHALL NOT be supported.

For further restrictions on transactions and security consideration, see below. 

### Use Cases

#### Patient Access from a Portal

A patient uses a portal which is integrated to the Swiss EPR using the mHealth profiles to access and share data and documents with healthcare professionals. To access documents from the EPR the patient authenticates at a certified Identity Provider and the portal connects to the IUA Authorization Server and sends the required claims to access the EPR. 

The IUA Authorization Server verifies if the portal is authorized to access the EPR on behalf of the patient by checking that the portal is registered as a portal of the community.

The IUA Authorization Server verifies that the patient has a valid session at the Identity Provider and retrieves the Identity Assertion from the Identity Provider. The Authorization Server validates the claims together with the data from the Identity Assertion and resolves additional information required to access the EPR (e.g., resolve the digital identity to the EPR-SPID).

The IUA Authorization Server responds an IUA Authorization Token the portal shall incorporate to any transaction to retrieve the data and documents from the patients EPR.

#### User Access from an integrated Primary System

A healthcare professional uses a primary system which is integrated to the Swiss EPR using the mHealth profiles to access and share data and documents with her patients or other healthcare professionals. To access documents from the EPR the healthcare professional authenticates in her primary system, selects the patient and switches to the user interface to display the patients documents and the primary system connects to the IUA Authorization Server and sends the required claims to access the patients EPR. 

The IUA Authorization Server verifies if the primary system is authorized to access the EPR on behalf of the user by checking that the primary system has been registered during the onboarding process of the primary system.

The IUA Authorization Server verifies that the healthcare professional has a valid session at the Identity Provider and retrieves the Identity Assertion from the Identity Provider. The Authorization Server validates the claims together with the data from the Identity Assertion and resolves additional information required to access the EPR (e.g., resolve the relations to institutions or other groups).

The IUA Authorization Server responds an IUA Authorization Token the primary system shall incorporate to any transaction to retrieve the data and documents from the patients EPR.

#### User Access from a SMART on FHIR component

A patient or healthcare professional uses a portal or primary system which uses SMART on FHIR Apps to connect to the Swiss EPR.  

The patient or healthcare professional authenticates in the portal or primary system and launches the SMART on FHIR App from the portal or primary system. The portal or primary system first builds a SMART on FHIR launch context with the patient context and identifiers of the portal or primary system application and launches the SMART on FHIR App with the launch context.

The IUA Authorization Server verifies that the portal or primary system is authorized to launch SMART on FHIR Apps which connect to the EPR on behalf of the user by checking that the portal or primary system has been registered beforehand during the onboarding process of the portal or primary system application.

The IUA Authorization Server verifies that the patient or healthcare professional has a valid session at the Identity Provider and retrieves the Identity Assertion from the Identity Provider. The Authorization Server validates the claims together with the data from the Identity Assertion and resolves additional information the SMART on FHIR App requires to access the EPR (e.g., resolve the digital identity to th EPR-SPID).

The IUA Authorization Server responds an IUA Authorization Token the SMART on FHIR App shall incorporate to any transaction to retrieve the data and documents from the patients EPR.

### Actors and Transactions   

This national extension enhance the requirements on transactions and the expected actions of the Actors of the IUA Trial Implementation to comply to the legal requirements of the Swiss EPR.

The scope of this national extension is limited to portals and primary systems to comply with ordinances of the Swiss EPR. This national extension is currently not scoped for native mobile clients. Therefore the Client Authorization by User Consent method SHALL NOT be supported. 

Portals and primary systems SHALL be identified and authorized either on the TLS connection level or by digital signatures of the messages exchanged, or both. See section Expected Actions of the [Get Access Token transaction](iti-71.html#expected-actions-iua-authorization-server) for further details. 

<div>
{%include IUA_actor_diagram.svg %}
</div>
This figure shows the actors directly involved in the _Internet User Authorization_ Profile and the relevant 
transactions between them.

### Actor Options 

This national extension restricts the Actor options of the IUA Trial Implementation to comply to the legal requirements of the Swiss EPR.

The IUA Trial Implementation supports three options for the Authorization Token format; the JWT Token, the SAML Token and the Token Introspection option. Since this national extension will apply to cross community communication, the Token Introspection Option SHALL NOT be used. 

This national extension intends to simplify and modernize the technologies used to connect to the Swiss EPR. The legacy SAML Token option SHALL NOT be used. To support automated client configuration the Authorization Server actor SHALL support the Authorization Metadata option.  

### Grouping  
The Swiss national extension does not define requirements on the grouping of actors in this profile, which extend or restrict the grouping required from the IUA profile. 

### Process Flow  
For the process flow of this profile and its interplay with the other mHealth profiles see [sequence diagrams](sequencediagrams.html). 

### Security Consideration  
The Swiss national extension does not define additional security requirements beyond those sepcified in the underlying [IUA Trial Implementation](https://profiles.ihe.net/ITI/IUA/index.html).
