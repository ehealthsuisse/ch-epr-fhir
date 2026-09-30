This section specifies Swiss national extensions to Internet User Authorization (IUA) Profile 
[published](https://profiles.ihe.net/ITI/IUA/index.html) as IHE ITI Trial Implementation.

### Scope

This national extension provides means to retrieve access tokens and to incorporate them to transactions
to authorize client applications and to evaluate user access rights when accessing protected resources of the 
Swiss EPR. It therefore defines certain restrictions and extensions to the Internet User Authorization (IUA) 
Profile [published](https://profiles.ihe.net/ITI/IUA/index.html).

This national extension is scoped for client authorization in FHIR based interfaces for primary systems, portals and
digital health apps. It is scoped to convey the information required to identify and authenticate 
the clients and to enforce the privacy policy settings, when accessing protected resources from the EPR.

### Use Cases

#### Patient Access from a Portal

A patient uses a portal which is integrated to the Health Dossier using the profiles to access and share data and documents
with healthcare professionals. To access documents from the EPR, the patient authenticates at a certified Identity
Provider. The portal sends the identity token and the required claims to the IUA Authorization Server
to retrieve an authorization token to access the EPR.

The Authorization Server validates the claims together with the data from the identity token and resolves additional
information required to access the EPR (e.g., resolve the digital identity to the EPR-SPID). The IUA Authorization
Server responds an IUA Authorization Token the portal shall incorporate to any transaction to retrieve the data and 
documents from the patients EPR.

#### Patient Access from a digital health app

A patient uses a digital health app which is integrated to the Health Dossier using the profiles to access and share data 
and documents with healthcare professionals. To access documents from the EPR, the patient authenticates at a certified 
Identity Provider. The digital health app sends the identity token and the required claims to the IUA Authorization Server
to retrieve an authorization token to access the patients EPR.

The Authorization Server validates the claims together with the data from the identity token and resolves additional
information required to access the EPR (e.g., resolve the digital identity to the EPR-SPID). The IUA Authorization
Server responds an IUA Authorization Token the digital health app shall incorporate to all transaction to retrieve the 
data and documents from the patients EPR.

#### User Access from a Primary System

A healthcare professional uses a primary system which is integrated to the Health Dossier using the profiles to access and
share data and documents with her patients or other healthcare professionals. To access documents from the EPR the
healthcare professional authenticates at a certified identity provider from her primary system, selects the patient
and switches to the user interface to display the patients documents. The primary system connects to the IUA
Authorization Server and sends the identity token and the required claims to access the patients EPR.

The IUA Authorization Server verifies if the primary system was registered and authorized to access the EPR on behalf
of the user during onboarding.

The Authorization Server validates the claims together with the data from the identity token and resolves additional
information required to access the EPR (e.g., resolve the digital identity to GLN). The IUA Authorization Server
responds an IUA Authorization Token the portal shall incorporate to any transaction to retrieve the data and documents
from the patients EPR.

#### Writing documents from clinical archives

A healthcare professional uses a primary system which stores documents in a clinical archive system. The clinical
archive system uses specific algorithms to decide which documents shall be stored in the Health Dossier of the patient.

The healthcare professional reports medical information of a treatment in her primary system. The primary system creates
a structured or unstructured document from the data and stores them in the clinical archive system. The clinical archive
system decides whether the document shall be stored in the patients EPR using the policies defined in the clinic.

The clinical archive system connects to the IUA Authorization Server and sends a request with the required claims to 
access the patients EPR. The IUA Authorization Server verifies if the clinical archive system was registered during 
onboarding and authorized to access the EPR.

The Authorization Server validates the claims and resolves additional information required to access the EPR. The IUA 
Authorization Server responds an IUA Authorization Token the clinical archive system shall incorporate to any transaction 
to retrieve the data and documents from the patients EPR.

### Actors and Transactions

This national extension enhances the requirements on transactions and the expected actions of the Actors of the IUA Trial
Implementation to comply to the legal requirements of the Health Dossier.

<div>
{%include IUA_actor_diagram.svg %}
</div>
This figure shows the actors directly involved in the Internet User Authorization Profile and the relevant 
transactions between them.

The IUA Authorization Client SHALL authenticate the user at the User Authentication Provider, the Identity Provider, as
specified in [OpenID Connect](openid-connect.html), acting as Relying Party. The IUA Authorization Client SHALL convey the
resulting identity token in the `id_token` parameter of the [Get Access Token [ITI-71]](iti-71.html) request. Technical
users (`TCU`), e.g. clinical archive systems, request access tokens without an authenticated user and do not use
OpenID Connect.

### Actor Options

This national extension restricts the Actor options of the IUA Trial Implementation to comply with the legal requirements
of the Health Dossier.

The IUA Trial Implementation supports three options for the Authorization Token format. In this national extension 
the JWT option is used and SHALL be supported by the IUA Authorization Server and IUA Resource Server. The SAML Token 
option and the Introspection Option SHALL NOT be used.

To support automated client configuration the Authorization Server actor SHALL support the Authorization Metadata option.

### Grouping

The actors SHALL be grouped with other actors as follows:

| Actor                        | Actor to be grouped with                               | Optionality |
|------------------------------|--------------------------------------------------------|-------------|
| Authorization Client         | CT Time Client                                         | R           |
|                              | ATNA Secure Node with [STX:HTTPS IUA Option](https://profiles.ihe.net/ITI/IUA/index.html#9267-stx-https-iua-option) | R           |
| Resource server              | CT Time Client                                         | R           |
|                              | ATNA Secure Node with [STX:HTTPS IUA Option](https://profiles.ihe.net/ITI/IUA/index.html#9267-stx-https-iua-option) | R           |
| Authorization Server         | CT Time Client                                         | R           |
| User Authentication Provider | CT Time Client                                         | R           |
{:class="table table-bordered"}

The grouping of actors with IUA Authorization Client and Resource Server actor are defined in the respective profile 
sections.

### Process Flow

For the process flow of this profile and its interplay with the other profiles see [sequence diagrams](sequencediagrams.html).

### Security Consideration

IUA Authorization Clients SHALL be identified by the **client_id** registered during onboarding. 

The authenticity of requests to the IUA Authorization Server SHALL be verified by a JWK as described in 
[SMART App launch Client Authentication](https://hl7.org/fhir/smart-app-launch/client-confidential-asymmetric.html). The integrity of requests to the IUA Authorization Server SHALL be 
verified by a http message signature as specified in [RFC 9421: HTTP Message Signatures](https://www.rfc-editor.org/info/rfc9421/). See 
[Get Access Token](iti-71.html#security-consideration) for details.  

Applications implementing the IUA Authorization Client actor SHALL register the combination of the OAuth **client_id**, 
and the public key used for signing the authentication JWK and the http message signature during the onboarding process. 

Applications implementing the IUA Authorization Server actor shall verify the combination of the OAuth **client_id**, 
the URLs and the public key of all requests against the registered values and shall reject requests in case of mismatch.