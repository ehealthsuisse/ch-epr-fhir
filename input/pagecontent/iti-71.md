This section describes the national extension for the Swiss EPR to
the [Get Access Token [ITI-71]](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71) transaction
defined in the IUA profile published in the IHE IT Infrastructure Technical Framework Trial Implementation “Internet
User Authorization”.

### Scope

The transaction is used by an IUA Authorization Client (e.g., portals and primary systems) to pass claims to the
IUA Authorization Server and to retrieve an access token to be used for authorization of the access to protected
resources of the Swiss EPR.

Depending on the claims made by the IUA Authorization Client, two different flavors of access tokens SHALL be provided
by the IUA Authorization Server:

- Basic Access Token – IUA compliant access token authorizing access to the EPR end-points which are NOT protected by
  the EPR role and attribute based authorization (i.e. for the PIXm endpoints).
- Extended Access Token – IUA compliant access token for the EPR endpoints which are protected by the EPR role and
  attribute based authorization (i.e. for the MHD endpoints).

When an IUA Authorization Client is authorized, it may launch SMART on FHIR Apps using the EHR launch by claiming a
launch indicator. When launched the SMART on FHIR Apps inherit the basic access authorization from the launching app and
may retrieve Extended Access Token for EPR endpoints protected by the EPR role and attribute based authorization (e.g.
to retrieve documents).

### Actor Roles

**Actor:** IUA Authorization Client  
**Role:** Communicates claims and launch information to the IUA Authorization Server and receives JWT access token,
optionally authenticates the user and presents the IDP token to the IUA Authorization Server together with the claims
and launch information.      
**Actor:** IUA Authorization Server  
**Role:** Identifies the Authorization Client, authorizes the access on behalf of the user, verifies claims, optionally
enforces user authentication by redirecting the Authorization Client to a certified IdP and responds a JWT Access Token
to the IUA Authorization Client to be incorporated into the transactions to access protected resources.

### Referenced Standards

1. [IHE ITI Technical Framework Supplement Internet User Authorization (IUA) Revision 2.3](https://profiles.ihe.net/ITI/IUA/index.html)
2. [SMART Application Launch Framework Implementation Guide Release 2.2.0](http://www.hl7.org/fhir/smart-app-launch/)

### Messages

#### Client Credential Grant Type

This section specifies the OAuth 2.1 client credential grant flow of the IUA Get Access Token transaction, which shall
be used by clinical archive systems to retrieve an Access Token.

<div>{% include IUA_ActorDiagram_ITI-71-cc.svg %}</div>
<figcaption ID="10">Figure: Sequence diagram of the transaction.</figcaption>

| Step | Action                                                                                           | Remark                                                  | 
|------|--------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| 00   | The Authorization Client sends an Access Token request to the IUA Authorization Server endpoint. | See [MessageSemantics](#client-credential-grant-type-1) | 
| 01   | The Authorization Server responds with the access token in the HTML body element.                | See [Message Semantics](#message-semantics-2)           |
{:class="table table-bordered"}

<figcaption ID="11">Table: Actions in the HTTP sequence of the transaction.</figcaption>

#### Authorization Code Grant Type

This section specifies the OAuth 2.1 authorization code grant flow of the IUA Get Access Token transaction, which shall
be used by portals and primary systems.

<div>{% include IUA_ActorDiagram_ITI-71.svg %}</div>
<figcaption ID="1">Figure: Sequence diagram of the transaction.</figcaption>  

||

| Step  | Action                                                                                                                                                                           | Remark                                         | 
|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------|
| 00,01 | The Authorization Client sends an HTTP GET request to the IUA Authorization Server endpoint.                                                                                     | See [Message Semantics](#message-semantics-1)  | 
| 02,03 | The Authorization Server performs an HTTP GET on the Authorization Client redirect_uri conveying the authorization code.                                                         |                                                |
| 04    | The Authorization Client performs an HTTP POST with parameter as a form-encoded HTTP entity body, passing its client_id and client_secret as an HTTP authorization header field. | See [Message Semantics](#message-semantics-1)  |
| 05    | The Authorization Server responds with the access token in the HTML body element.                                                                                                | See [Message Semantics](#message-semantics-2)  |
|       |                                                                                                                                                                                  |                                                |
{:class="table table-bordered"}

<figcaption ID="5">Table: Actions in the HTTP sequence of the transaction.</figcaption>


#### Get Access Token Request

##### Client Credential Grant Type

###### Trigger Events

A clinical archive system aims to access the EPR to write documents.

###### Message Semantics

The Authorization Client SHALL send an IUA compliant OAuth 2.1 Authorization Request for the client credential grant
type with Swiss extensions:

- grant_type (required): The value of the parameter shall be `client_credentials`.
- client_id (required): The ID the Authorization Client is registered at the IUA Authorization Server.
- client_secret (required): The secret the Authorization Client is registered at the IUA Authorization Server.
- scope (required): The scope claimed by the Authorization Client, as defined in the table below.
- resource (optional): Single valued identifier of the Resource Server API endpoint to be accessed.
- requested_token_type (optional): If present, the value shall be `urn:ietf:params:oauth:token-type:jwt`.

The Authorization Request SHALL use the following Swiss extension:

- principal (optional): The name of the healthcare professional the technical user acts on behalf of.
- principal_id (required): The GLN of the healthcare professional the technical user acts act on behalf of.
- person_id (optional/required): EPR-SPID identifier of the patient’s record and the patient assigning authority
  formatted in CX syntax, required for requesting extended access token.

Authorization Clients SHALL sent the scope values in the Authorization Request:

<table class="table table-bordered">
  <thead>
    <tr>
      <th>Scope</th>
      <th>Optionality (Basic/ Extended)</th>
      <th>Type</th>
      <th>Reference</th>
      <th>Remark</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>purpose_of_use</td>
      <td>R/R</td>
      <td>token<sup><a href="#3">3</a></sup></td>
      <td>See sections below.</td>
      <td>Shall be AUTO as defined in the code system 2.16.756.5.30.1.127.3.10.5 of the CH:EPR value set.</td>
    </tr>
    <tr>
      <td>subject_role</td>
      <td>R/R</td>
      <td>token</td>
      <td>See sections below.</td>
      <td>Shall be the value TCU as defined in the code system 2.16.756.5.30.1.127.3.10.1.1.3 of the CH:EPR value set.</td>
    </tr>
  </tbody>
</table>

<sup id="3">3</sup>Token format according FHIR [token type](https://www.hl7.org/fhir/search.html#token).

<figcaption ID="16">Table: Authorization Request’s scope parameter for the client credential flow.</figcaption>  

###### Expected Actions

When receiving a Get Access Token Request with purpose of use set to AUTO and subject role set to TCU, the Authorization
Server SHALL:

- identify and authenticate the Authorization Client with the client_id and client_secret.
- verify, that the Authorization Client was registered during onboarding with the same client_id, client_secret and the
  client's certificate of the TLS connection and is authorized to access the EPR.
- verify that the principal_id matches the GLN of the legal responsible healthcare professional the Authorization Client
  was registered during onboarding.

The Authorization Server SHALL respond with the Get Access Token response as defined
in [Get Access Token Response](#get-access-token-response) only if all checks are successful. If one of the above checks
fails, the Authorization Server SHALL respond with HTTP 401 (Unauthorized) error.

The Authorization Server SHALL respond with an Extended Access Token, only if the person_id is set in the request. The
Authorization Server SHALL respond with a Basic Access Token, if the person_id is not set.

The Authorization Client SHALL use the access token as defined in IUA Incorporate Access Token transaction, when
performing requests to resources of the Swiss EPR.

###### Message Example

```http
POST /token HTTP/1.1 
Host: localhost:9001

Accept: application/json
Content-type: application/x-www-form-urlencoded
Authorization: Basic bXktYXBwOm15LWFwcC1zZWNyZXQtMTIz
grant_type=client_credentials&
requested-token-type=urn:ietf:params:oauth:token-type:jwt&
person_id=761337610411353650%5E%5E%5E%262.16.756.5.30.1.109.6.5.3.1.1%26ISO&
principal_id=9801000050702&
scope=user%2F*.*+openid+fhirUser+purpose_of_use%3Durn%3Aoid%3A2.16.756.5.30.1.127.3.10.5%7CAUTO+subject_role%3Durn%3Aoid%3A2.16.756.5.30.1.127.3.10.6%7CTC
```

##### Authorization Code Grant Type

###### Trigger Events

A user launches a portal, primary system or a SMART on FHIR App to access data and documents from the Swiss EPR.

###### Message Semantics

In the first step of the sequence the Authorization Client SHALL send an IUA compliant OAuth 2.1 Authorization 
Request for the authorization code grant type with the following Swiss extension:

- response_type (required): The value of the parameter shall be code.
- client_id (required): The ID the Authorization Client is registered at the IUA Authorization Server. For SMART on FHIR 
  Apps launched in EPR mode the client_id SHALL be the ID of the portal or primary system which launched the App.
- state (required): The state parameter is used to protect against cross-site request forgery attacks. The value of the
  parameter is passed through unmodified from the request to the response.
- resource (optional): If present, the single valued identifier of the Resource Server api endpoint to be accessed.
- code_challenge (optional): The code challenge is a cryptographic challenge used to protect against cross-site request
  forgery attacks. The value of the parameter is passed through unmodified from the request to the response.
- code_challenge_method (optional): The code challenge method is the cryptographic method used to protect against cross-site 
  request forgery attacks. If present, the value of it SHALL be S256.
- redirect_uri (required): The URL the Authorization Client is registered at the IUA Authorization Server.
- scope (required): The scope claimed by the Authorization Client, as defined in the table below.
- requested_token_type (optional): If present, the requested token format shall be urn:ietf:params:oauth:token-type:jwt.

The Authorization Request SHALL use the following Swiss extension:
- person_id (optional/required): EPR-SPID identifier of the patient’s record and the patient assigning authority
  formatted in CX syntax, required for requesting extended access token.
- principal (optional): The name of the healthcare professional an assistant may act on behalf of.
- principal_id (optional): The GLN of the healthcare professional an assistant may act on behalf of.
- group (optional): The name of the organization or group an assistant may act on behalf of.
- group_id (optional): The OID of the organization or group an assistant is acting on behalf of.

Authorization Clients SHALL send the following values in the scope attribute of the Authorization Request:

| Scope          | Optionality (Basic/ Extended) | Type  | Reference            | Remark                                                                                                                                                         |
|----------------|-------------------------------|-------|----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| launch         | O/R                           |       | SMART on FHIR        | An opaque identifier of a SMART on FHIR App launched in an EHR launch. The claim is required for SMART on FHIR Apps launched from a portal or primary system.  | 
| purpose_of_use | O/R                           | token | See sections below.  | Value taken from code system 2.16.756.5.30.1.127.3.10.5 of the CH: EPR value set in [FHIR token type](https://www.hl7.org/fhir/search.html#token) format.      |
| subject_role   | O/R                           | token | See sections below.  | Value taken from code system 2.16.756.5.30.1.127.3.10.1.1.3 of the CH: EPR value set in [FHIR token type](https://www.hl7.org/fhir/search.html#token) format.  |
{:class="table table-bordered"}

<figcaption ID="6">Table: Authorization Request’s scope parameter for the authorization code flow.</figcaption>  


The scope parameter of the request MAY claim the following attributes:

- There MAY be a scope with name “launch”. If present, it indicates the permission of SMART on FHIR Apps to obtain
  launch context from a portal or primary system authorized to access the EPR.
- There MAY be a scope with name "purpose_of_use=token". If present, the token SHALL convey the coded value of the
  current transaction’s purpose_of_use. Allowed values are NORM (normal access) and EMER (emergency access) from code
  system 2.16.756.5.30.1.127.3.10.5 of the CH:EPR value set. e.g. purpose_of_use=urn:oid:
  2.16.756.5.30.1.127.3.10.5\|NORM.
- There MAY be a scope with name "subject_role=token". If present, the token SHALL convey the coded value of the
  subject’s role. The value SHALL be either HCP (healthcare professional), ASS (assistant), REP (representative) or
  PAT (patient) from code system 2.16.756.5.30.1.127.3.10.6 of the CH:EPR value set. e.g.: subject_role=urn:oid:
  2.16.756.5.30.1.127.3.10.6\|HCP.
- Authorization Clients may claim other scopes as defined in the SMART on FHIR specification.

Note: The parameters need to be url encoded, see above message example.

Additional scopes are required depending on the user's role:

For healthcare professionals, the scope subject_role SHALL be the code HCP from code system
2.16.756.5.30.1.127.3.10.6 of the CH:EPR value set.

For assistants, the scope subject_role SHALL be the code ASS from code system 2.16.756.5.30.1.127.3.10.6 of
the CH:EPR value set. There SHALL be a scope with name principal_id, the value of which SHALL be the GLN of the
healthcare professional an assistant is acting on behalf of. There SHALL be a scope with name principal, the value of 
which SHALL be the name of the healthcare professional an assistant is acting on behalf of. There MAY be one or more 
pairs with name group_id and group, the value of which SHALL be the ID and name of the subject’s organization 
or group as registered in the EPR HPD. The value of group_id SHALL be an OID in the format of a URN.

For patients, the scope subject_role SHALL be the code PAT from code system 2.16.756.5.30.1.127.3.10.6 of
the CH:EPR value set. The value of the purpose_of_use scope SHALL be the code NORM from code system
2.16.756.5.30.1.127.3.10.5 of the CH:EPR value set. 

For representatives, the scope subject_role SHALL be the code REP from code system 2.16.756.5.30.1.127.3.10.6 and 
the scope purpose_of_use SHALL be the code NORM from code system 2.16.756.5.30.1.127.3.10.5 of the CH:EPR value set.

In the second step of the sequence the Authorization Client SHALL perform an IUA compliant OAuth 2.1 Access 
Token Request for the authorization code grant type with the following Swiss extension:

The POST request SHALL contain the following attributes:
- grant_type (required): The value of the parameter shall be client_credentials.
- code (required): The authorization code received from the Authorization Server in the authorization response.
- code_verifier (required): The original code verifier string.
- client_id (required): The client identifier the Authorization Client is registered with at the Authorization Server.
- requested_token_type (optional): If present, the value shall be urn:ietf:params:oauth:token-type:jwt.
- client_assertion_type (required/optional): If present, the value shall be urn:ietf:params:oauth:client-assertion-type:jwt-bearer 
  if the client assertion is JWT, or urn:ietf:params:oauth:client-assertion-type:saml2-bearer for base64url encoded SAML 2 assertions.
  Required for IUA Authorization Clients which do not use SMART on FHIR EHR launch.
- client_assertion (required/optional): The identity token the Authorization Client retrieved from the certified Identity Provider 
  after successful authentication of the user. Required for IUA Authorization Clients which do not use SMART on FHIR EHR launch.

###### Expected Actions

The IUA Authorization Client and Authorization Server SHALL support the HTTP conversation of the OAuth 2.1 Authorization
Code grant type.

When launched, the IUA Authorization Client SHALL send an HTTP GET request to the Authorization Servers authorization
endpoint with query parameter as defined in [Table](#5) and with the scope claims described in [Table](#6).

When receiving the request the Authorization Server

- SHALL verify that the Authorization Client was registered during onboarding with the client_id and client secret
  presented in the request.
- SHALL validate the requests parameter (i.e.: person_id). Depending on the parameter, the IUA Authorization Server
  SHALL either build a Basic Access Token authorizing basic access to the EPR (i.e. PIXm), or an Extended Access Token
  to authorize access to resources protected by the role and attribute based EPR authorization (i.e. read and write
  documents).
- SHALL validate the launch scope parameter. For SMART on FHIR Apps launched in an EPR Launch, the IUA Authorization
  Server SHALL verify that the portal or primary system which launched the SMART on FHIR App has been registered with
  this launch parameter value by the community during the onboarding process.
- SHALL verify that the Authorization Client is authorized to access the EPR on behalf of the user by community policy
  or by the user's consent. 
- MAY retrieve the user's consent by redirecting the user agent to an EPR compliant Identity Provider to authenticate 
  the user and present a form to the user to authorize the IUA Authorization Client to act on behalf of the user with 
  a given scope. The Authorization Server MAY persist the users consent for future access by the Authorization Client.

In case of failure, the IUA Authorization Server SHALL respond with HTTP error code 401 ‘Not authorized’.

In case of success, the IUA Authorization Server SHALL send the authorization code to the Authorization Client
redirect-uri via the user agent.

The Authorization Client SHALL perform the HTTP POST request to the Authorization token endpoint to resolve the
authorization code to the access token, sending the client_id and client_secret in the HTTP authorization header field.

When retrieving the token request, the Authorization Server SHALL verify that the user is authenticated compliant to the
regulations of the Swiss EPR, either by validating the identity token send with the token request or by redirecting the
Authorization Client's user agent to an certified Identity Provider.

The Authorization Server SHALL respond with the Get Access Token response as defined
in [Get Access Token Response](#get-access-token-response)
only if all checks are successful.

In case of failure, the IUA Authorization Server SHALL respond with HTTP error code 401 ‘Not authorized’.

The IUA Authorization Client SHALL use the access token as defined in IUA Incorporate Access Token transaction, when
performing requests to resources of the Swiss EPR.

###### Message Example

The first step of the conversation is an HTTP GET which may look like for a Basic Access Token:

```http
GET authorize?
    response_type=code&
    client_id=app-client-id&
    redirect_uri=http%3A%2F%2Flocalhost%3A9000%2Fcallback&
    launch=xyz123&
    scope=launch+user%2F%2A.%2A+openid+fhirUser&
    state=98wrghuwuogerg97&
    aud=https%3A%2F%2Fehr%2Ffhir&
    code_challenge=ZmVjMmIwMWYyYTNjZWJiNTgyNTgxYzlmOGYyMWM0MWI3YmZhMjQ4YjU5MDc3Mzk4MDBmYTk0OThlNzZiNjAwMw&
    code_challenge_method=S256
```

An extended access token where at least purpose_of_use (NORM), subject_role (HCP) and person_id are specified may look
like:

```http
GET authorize?
    response_type=code&
    client_id=app-client-id&
    redirect_uri=http%3A%2F%2Flocalhost%3A9000%2Fcallback&
    launch=xyz123&
    person_id=761337610411353650%5E%5E%5E%262.16.756.5.30.1.109.6.5.3.1.1%26ISO&
    scope=launch+user%2F*.*+openid+fhirUser+purpose_of_use%3Durn%3Aoid%3A2.16.756.5.30.1.127.3.10.5%7CNORM+subject_role%3Durn%3Aoid%3A2.16.756.5.30.1.127.3.10.6%7CHCP&
    code_challenge=ZmVjMmIwMWYyYTNjZWJiNTgyNTgxYzlmOGYyMWM0MWI3YmZhMjQ4YjU5MDc3Mzk4MDBmYTk0OThlNzZiNjAwMw&
    code_challenge_method=S256
```

In the second step of the conversation, the IUA Authorization Server send a HTTP GET to the Authorization Client's user 
agent conveying the authorization code, e.g.:

```http
GET /callback?code=8V1pr0rJ&state=98wrghuwuogerg97
```

In the third step of the conversation, the IUA Authorization Client sends a HTTP POST request to the token endpoint of 
IUA Authorization Server to exchange the authorization code and optional identity token (signed JWT or SAML 2 Assertion) 
to the access token, e.g.:

```http
POST /token HTTP/1.1 
Host: localhost:9001

Accept: application/json
Content-type: application/x-www-form-urlencoded
Authorization: Basic bXktYXBwOm15LWFwcC1zZWNyZXQtMTIz
grant_type=authorization_code&
code=98wrghuwuogerg97&
code_verifier=qskt4342of74bkncmicdpv2qd143iqd822j41q2gupc5n3o6f1clxhpd2x11&
client_id=app-client-id&
requested_token_type=urn:ietf:params:oauth:token-type:jwt
client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
client_assertion=eyJraWQiOiIxZTlnZGs3IiwiYWxnIjoiUlMyNTYifQ[...omitted for brevity...]
```

#### Get Access Token Response

##### Message Semantics

The response SHALL either convey a Basic Access Token in JWT format, granting basic access to the EPR (i.e. to access
patient data), or an Extended Access Token to access resources protected by the role and attribute based EPR
authorization (i.e. read and write documents).

###### JSON Web Token Option

The Authorization Server and Resource Server SHALL support the IUA JWT extension with the following claims as defined in
Table <a href="#jwttiua">below</a>.

The claim content for the JWT IUA extensions SHALL correspond to the content defined in the XUA specification (see
Annex 5 Addendum 1, section 1.6.4.2 Get X-User Assertion).

<table class="table table-bordered">
  <thead>
    <tr>
      <th>JWT Claim (Extension)</th>
      <th>Optionality (Basic/ Extended)</th>
      <th>XUA Attribute EPR</th>
      <th>Remark</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>subject_name</td>
      <td>R/R</td>
      <td>urn:oasis:names:tc:xspa:1.0:subject:subject-id</td>
      <td>Plain text's username.</td>
    </tr>
    <tr>
      <td>subject_organization</td>
      <td>O/O</td>
      <td>urn:oasis:names:tc:xspa:1.0:subject:organization</td>
      <td>The name of the user’s organization or institution as text.</td>
    </tr>
    <tr>
      <td>subject_organization_id</td>
      <td>O/O</td>
      <td>urn:oasis:names:tc:xspa:1.0:subject:organization-id</td>
      <td>The OID of the user’s organization in URN notation.</td>
    </tr>
    <tr>
      <td>subject_role</td>
      <td>O/R</td>
      <td>urn:oasis:names:tc:xacml:2.0:subject:role</td>
      <td>Code indicating the user role. In the Swiss EPR the value SHALL be taken from the EPR Role Code Value Set.</td>
    </tr>
    <tr>
      <td>purpose_of_use</td>
      <td>O/R</td>
      <td>urn:oasis:names:tc:xspa:1.0:subject:purposeofuse</td>
      <td>Code indicating the purpose of use. In the Swiss EPR the value SHALL be taken from the EPR Purpose Of Use Value Set.</td>
    </tr>
    <tr>
      <td>home_community_id</td>
      <td>O/R</td>
      <td>urn:ihe:iti:xca:2010:homeCommunityId</td>
      <td>The user’s home community identifier where the request originated. Its value should be an OID in URN notation.</td>
    </tr>
    <tr>
      <td>person_id</td>
      <td>O/R</td>
      <td>urn:oasis:names:tc:xacml:2.0:resource:resource-id</td>
      <td>SHALL be the EPR-SPID of the patients EPR.</td>
    </tr>
  </tbody>
</table>

<figcaption id='jwttiua'>Table: Attributes of the IUA Get Access Token response in the JWT extension ihe_iua.</figcaption>  

###### The JWT ch_epr extension

The Authorization Server and Resource Server SHALL support this extension to convey the user's EPR identifier 
in the JWT access token of the Get Access Token Response. It's attributes are: 

- user_id (required): The EPR subject identifier as defined in the table below. 
- user_id_(required): The subject identifier qualifier as defined in the table below.

||

| user role               | user_id  | user_id_qualifier                              | Remark |
|-------------------------|----------|------------------------------------------------|--------|
| Patient                 | EPR-SPID | urn:e-health-suisse:2015:epr-spid              |        |
| Healthcare Professional | GLN      | urn:gs1:gln                                    |        |
| Assistent               | GLN      | urn:gs1:gln                                    |        |
| Representative          | IdP-ID   | urn:e-health-suisse:representative-id          |        |
| Document Administrator  | IdP-ID   | urn:e-health-suisse:policy-administrator-id    |        |
| Policy Administrator    | IdP-ID   | urn:e-health-suisse:document-administrator-id  |        |
{:class="table table-bordered"}

<figcaption>Table: user_id and user_id_qualifier of EPR user.</figcaption>

||

Note: This extension corresponds to the NameID element of SAML 2.0 formatted X-User Assertions described in
Annex 5 E1, section 1.6.4.2.4.2.

###### The JWT ch_group extension

Groups are the objects used in the access management of the Swiss EPR. Patients and representatives may assign access
rights to groups which typically are sub-organizations of the institutions, but may also be cross institution boundaries, 
e.g., a tumorboard with healthcare professionals from more than one institution. 

The Authorization Server and Resource Server SHALL support this extension in the JWT access token for a list of groups 
a subject of role healthcare professional is a member of. For users of role assistant, the groups SHALL be the groups of 
the healthcare professional the assistant is acting on behalf of.

Groups SHALL be wrapped in an "extensions" object with key 'ch_group' with a JSON array containing one JSON object 
per group with the following attributes:

- id (required): The id of the group. Required for users of role healthcare professional and assistant. 
  The id SHALL be an OID in the format of a URN.
- name (required): Name of the group. Required for users of role healthcare professional and assistant.
  The name SHALL be a string.

Note: This extension corresponds to the list of urn:oasis:names:tc:xspa:1.0:subject:organization and 
urn:oasis:names:tc:xspa:1.0:subject:organization-id elements of SAML 2.0 formatted X-User Assertions described in
Annex 5 Addendum 1, section 1.6.4.2.4.2.

###### The JWT ch_delegation extension

Delegation is used used in the access management of the Swiss EPR to indicate that a user of role Assistant is acting on 
behalf of a healthcare professional. The Authorization Server and Resource Server SHALL support this extension in the 
JWT access token to name the healthcare professional (principal) the assistant is acting on behalf of.

Principals SHALL be wrapped in an "extensions" object with key 'ch_delegation' and a JSON value
object with attributes:

- principal (optional) Name of the healthcare professional an assistant is acting on behalf of.
- principal_id (optional) GLN of the healthcare professional an assistant is acting on behalf of.

Note: This extension corresponds to the attributes urn:e-health-suisse:principal-name and urn:e-health-suisse:principal-id
in the XUA specification in Annex 5 Addendum 1, section 1.6.4.2.4.2.2.

##### Expected Actions

The business rules for the IUA Authorization Server for the Healthcare Professional, Assistant, Patient and
Representative Extension SHALL be the same as for Annex 5 Addendum 1, section 1.6.4.2.4.4 Expected Actions X-Assertion Provider 
Extensions.

##### Message Example

A basic JWT access token returned by the IUA Authorization Server and to be used to retrieve patient data may look like:

```json
{
  "iss": "http://issuerAdress.ch",
  "sub": "UserId-bfe8a208-b9d0-4012-b2f5-168b949fc3cb",
  "aud": "http://pixmResourceServerURL.ch",
  "exp": 1587294580000,
  "nbf": 1587294460000,
  "iat": 1587294460000,
  "jti": "c5436729-3f26-4dbf-abd3-2790dc7771a",
  "extensions": {
    "ihe_iua": {
      "subject_name": "Martina Musterarzt",
      "home_community_id": "urn:oid:1.2.3.4"
    },
    "ch_epr": {
      "user_id": "2000000090092",
      "user_id_qualifier": "urn:gs1:gln"
    }
  }
}
```

An extended JWT access token to be used to access patient documents SHALL have the additional attributes of the purpose
of use, subject role, the EPR-SPID of the patient and may look like:

```json
{
  "iss": "http://issuerAdress.ch",
  "sub": "UserId-bfe8a208-b9d0-4012-b2f5-168b949fc3cb",
  "aud": "http://mhdResourceServerURL.ch",
  "exp": 1587294580000,
  "nbf": 1587294460000,
  "iat": 1587294460000,
  "jti": "c5436729-3f26-4dbf-abd3-2790dc7771a",
  "extensions": {
    "ihe_iua": {
      "subject_name": "Martina Musterarzt",
      "home_community_id": "urn:oid:1.2.3.4",
      "person_id": "761337610411353650^^^&2.16.756.5.30.1.127.3.10.3&ISO",
      "subject_role": {
        "system": "urn:oid:2.16.756.5.30.1.127.3.10.6",
        "code": "HCP"
      },
      "purpose_of_use": {
        "system": "urn:uuid:2.16.756.5.30.1.127.3.10.5",
        "code": "NORM"
      }
    },
    "ch_epr": {
      "user_id": "2000000090092",
      "user_id_qualifier": "urn:gs1:gln"
    },
    "ch_group": [
      {
        "name": "Name of group with id urn:oid:2.2.2.1",
        "id": "urn:oid:2.2.2.1"
      },
      {
        "name": "Name of group with id urn:oid:2.2.2.2",
        "id": "urn:oid:2.2.2.2"
      },
      {
        "name": "Name of group with id urn:oid:2.2.2.2",
        "id": "urn:oid:2.2.2.3"
      }
    ]
  }
}
```

An extended JWT access token to be used to access by an assistant acting behalf on a healthcare professional for a
patient SHALL have the additional extension ch_delegation:

```json
{
  "iss": "http://issuerAdress.ch",
  "sub": "UserId-bfe8a208-b9d0-4012-b2f5-168b949fc3cb",
  "aud": "http://mhdResourceServerURL.ch",
  "exp": 1587294580000,
  "nbf": 1587294460000,
  "iat": 1587294460000,
  "jti": "c5436729-3f26-4dbf-abd3-2790dc7771a",
  "extensions": {
    "ihe_iua": {
      "subject_name": "Dagmar Musterassistent",
      "home_community_id": "urn:oid:1.2.3.4",
      "person_id": "761337610411353650^^^&2.16.756.5.30.1.127.3.10.3&ISO",
      "subject_role": {
        "system": "urn:oid:2.16.756.5.30.1.127.3.10.6",
        "code": "HCP"
      },
      "purpose_of_use": {
        "system": "urn:uuid:2.16.756.5.30.1.127.3.10.5",
        "code": "NORM"
      }
    },
    "ch_epr": {
      "user_id": "2000000090108",
      "user_id_qualifier": "urn:gs1:gln"
    },
    "ch_group": [
      {
        "name": "Name of group with id urn:oid:2.2.2.1",
        "id": "urn:oid:2.2.2.1"
      },
      {
        "name": "Name of group with id urn:oid:2.2.2.2",
        "id": "urn:oid:2.2.2.2"
      },
      {
        "name": "Name of group with id urn:oid:2.2.2.2",
        "id": "urn:oid:2.2.2.3"
      }
    ],
    "ch_delegation": {
      "principal": "Martina Musterarzt",
      "principal_id": "2000000090092"
    }
  }
}
```

#### CapabilityStatement Resource

There are no CapabilityStatement resources defined for this transaction.

### Security Consideration

IUA Authorization Clients, Authorization Servers and Resource Server actors SHALL use the JWS (signed) alternative
of the JWT token as specified in the IUA Trial Implementation. The JWE alternative SHALL not be used.

When receiving requests of transactions where the EPR-SPID is provided in the IUA token and in the transaction body,
the Resource Servers SHALL verify that both are the same.

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).

#### Security Audit Considerations

There is no audit event required for this transaction.
