This section specifies Swiss national extensions to Internet User Authorization (IUA) Profile, which
is [published](https://profiles.ihe.net/ITI/IUA/index.html) as an IHE ITI Trial Implementation profile.

### Scope

This profile provides means to retrieve EPR compliant access token and to incorporate the access token to transactions
to authorize client applications when accessing protected resources.

This profile is based on the IUA Trial Implementation and adds certain restrictions to be compliant to the ordinances of
the Swiss EPR.

The scope of this national extension is limited to provide FHIR based interfaces for primary systems and portals
connected to the Swiss EPR, as well as for SMART on FHIR components launched from the portals or primary systems.

SMART on FHIR Apps launched from a portal or primary system require a launch context which identifies the portal or 
primary system the app is launched from. The portal or primary system shall be registered with "client_id" and 
"client-secret" during onboarding, while the SMART on FHIR App may require an user consent for given scopes. When the 
user consent is requested in a form provided by the Authorization Server, users must be authenticated compliant to 
EPRO Annex 8.

Portals and primary systems registered during onboarding, shall provide the identity token received from a certified 
identity provider after user authentication in the access token request send to the IUA Authorization Server. 
The IUA Authorization Server shall verify the identity token and accept the user identity data of the authenticated 
user.  

### Use Cases

#### Patient Access from a Portal

A patient uses a portal which is integrated to the Swiss EPR using the profiles to access and share data and documents
with healthcare professionals. To access documents from the EPR, the patient authenticates at a certified Identity
Provider. The portal sends the identity token and the required claims to the IUA Authorization Server 
to retrieve an authorization token to access the EPR.

The Authorization Server validates the claims together with the data from the identity token and resolves additional 
information required to access the EPR (e.g., resolve the digital identity to the EPR-SPID). The IUA Authorization Server 
responds an IUA Authorization Token the portal shall incorporate to any transaction to retrieve the data and documents 
from the patients EPR.

#### User Access from an integrated Primary System

A healthcare professional uses a primary system which is integrated to the Swiss EPR using the profiles to access and
share data and documents with her patients or other healthcare professionals. To access documents from the EPR the
healthcare professional authenticates at a certified identity provider from her primary system, selects the patient 
and switches to the user interface to display the patients documents. The primary system connects to the IUA Authorization 
Server and sends the identity token and the required claims to access the patients EPR.

The IUA Authorization Server verifies if the primary system is authorized to access the EPR on behalf of the user by
checking that the primary system has been registered during the onboarding process.

The Authorization Server validates the claims together with the data from the identity token and resolves additional
information required to access the EPR (e.g., resolve the digital identity to GLN). The IUA Authorization Server
responds an IUA Authorization Token the portal shall incorporate to any transaction to retrieve the data and documents
from the patients EPR.

#### User Access from a SMART on FHIR component

A patient or healthcare professional uses a portal or primary system which uses SMART on FHIR Apps to connect to the
Swiss EPR.

The patient or healthcare professional authenticates in the portal or primary system and launches the SMART on FHIR App
from the portal or primary system. The portal or primary system first builds a SMART on FHIR launch context with the
patient context and identifiers of the portal or primary system application and launches the SMART on FHIR App with the
launch context.

The IUA Authorization Server verifies that the portal or primary system is authorized to launch SMART on FHIR Apps which
connect to the EPR on behalf of the user by checking that the portal or primary system has been registered beforehand
during the onboarding process of the portal or primary system application.

<!-- TODO present form to consent -->
The IUA Authorization Server verifies that the patient or healthcare professional has a valid session at the Identity
Provider and retrieves the Identity Assertion from the Identity Provider. The Authorization Server validates the claims
together with the data from the Identity Assertion and resolves additional information the SMART on FHIR App requires to
access the EPR (e.g., resolve the digital identity to the EPR-SPID).

The IUA Authorization Server responds an IUA Authorization Token the SMART on FHIR App shall incorporate to any
transaction to retrieve the data and documents from the patients EPR.

#### Writing documents from clinical archives

A healthcare professional uses a primary system which stores documents in a clinical archive system. The clinical
archive system uses specific algorithms to decide which documents shall be stored in the Swiss EPR of the patient.

The healthcare professional reports medical information of a treatment in her primary system. The primary system creates
a structured or unstructured document from the data and stores them in the clinical archive system. The clinical archive
system decides whether the document shall be stored in the patients EHR using the policies defined in the clinic.

To access the patient EHR the clinical archive system first request a basic authorization token using the client
credential flow and uses the basic authorization token in the PIXm or PDQm transactions used to retrieve the EHR-SPID
and the XAD PID of the patient.

The Authorization server returns the basic access token if the clinical archive systems is registered beforehand and is
authorized to access the Swiss EHR.

The clinical archive system then requests an extended authorization token to be used with the MHD transaction to store
the document in the patients EHR.

### Actors and Transactions

This national extension enhance the requirements on transactions and the expected actions of the Actors of the IUA Trial
Implementation to comply to the legal requirements of the Swiss EPR.

<div>
{%include IUA_actor_diagram.svg %}
</div>
This figure shows the actors directly involved in the _Internet User Authorization_ Profile and the relevant 
transactions between them.

### Actor Options

This national extension restricts the Actor options of the IUA Trial Implementation to comply to the legal requirements
of the Swiss EPR.

The IUA Trial Implementation supports three options for the Authorization Token format; the JWT Token, the SAML Token
and the Token Introspection option. Since this national extension will apply to cross community communication, the Token
Introspection Option SHALL NOT be used.

This national extension intends to simplify and modernize the technologies used to connect to the Swiss EPR. The legacy
SAML Token option SHALL NOT be used. To support automated client configuration the Authorization Server actor SHALL
support the Authorization Metadata option.

### Grouping

The Swiss national extension does not define requirements on the grouping of actors in this profile, which extend or
restrict the grouping required from the IUA profile.

### Process Flow

For the process flow of this profile and its interplay with the other profiles
see [sequence diagrams](sequencediagrams.html).

### Security Consideration

<!-- TODO -->
Portals and primary systems SHALL be identified and authorized either on the TLS connection level or by digital
signatures of the messages exchanged, or both. See section Expected Actions of
the [Get Access Token transaction](iti-71.html#expected-actions-1) for further details.

This national extension enforces client authentication of the TLS network layer with X.509 client certificates. The TLS
client certificate shall be used together with the OAuth 2 client ID to identify the client when granting access to the
EPR. The client certificates shall match the requirements of EPRO-FDHA, Annex 2, Section 4.15.3b.

Communities shall verify and register the combination of the OAuth client ID, the URLs and the client certificate during
the onboarding process.

Communities shall verify the combination of the OAuth client ID, the URLs and the client certificate of all requests
against the registered values and shall reject requests in case of mismatch.

The Swiss national extension does not define further additional security requirements beyond those specified in the
underlying [IUA Trial Implementation](https://profiles.ihe.net/ITI/IUA/index.html).
