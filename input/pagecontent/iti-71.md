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

1. [IHE ITI Technical Framework Supplement Internet User Authorization (IUA) Revision 2.2](https://profiles.ihe.net/ITI/IUA/index.html)
2. [SMART Application Launch Framework Implementation Guide Release 2.1.0](http://www.hl7.org/fhir/smart-app-launch/)

### Messages

#### Client Credential Grant Type

This section specifies the OAuth 2.1 client credential grant flow of the IUA Get Access Token transaction, which shall
be used by clinical archive systems to retrieve an Access Token.

<div>{% include IUA_ActorDiagram_ITI-71-cc.svg %}</div>
<figcaption ID="10">Figure: Sequence diagram of the transaction.</figcaption>  

<table class="table table-bordered">

  <colgroup>
   <col span="1" style="width: 5%;">
   <col span="1" style="width: 25%;">
   <col span="1" style="width: 15%;">
   <col span="1" style="width: 15%;">
   <col span="1" style="width: 15%;">
   <col span="1" style="width: 25%;">
</colgroup>

  <thead>
   <tr>
    <th>Step</th>
    <th>Action</th>
    <th>Parameter</th>
    <th>Opt (Basic/ Extended).</th>
    <th>Reference</th>
    <th>Remark</th>
   </tr>
  </thead>
  <tbody>
   <tr>
    <td>00</td>
    <td>The Authorization Client sends an HTTP POST request to the IUA Authorization Server endpoint.</td>
    <td>response_type</td>
    <td>R</td>
    <td>IUA</td>
    <td>The value SHALL be client_credentials.</td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>client_id</td>
    <td>R</td>
    <td>IUA</td>
    <td>The ID, the Authorization Client is registered at the IUA Authorization Server.
    </td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>client_secret</td>
    <td>R</td>
    <td>IUA</td>
    <td>An unguessable value registered for the Authorization Client during onboarding.
    </td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>scope</td>
    <td>R</td>
    <td>IUA</td>
    <td>Attributes the Authorization Client claims (see detailed description below).</td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>aud</td>
    <td>R</td>
    <td>SMART on FHIR</td>
    <td>The URL or array of URL of the Resource Servers the token is intended to be used for.</td>
   </tr>
   <tr>
    <td>01</td>
    <td>The Authorization Server responds with the access token in the HTML body element.</td>
    <td>access_token</td>
    <td>R</td>
    <td>IUA</td>
    <td>A string containing the access token which SHALL be a JWT token.</td>
   </tr>
   <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>token_type</td>
    <td>R</td>
    <td>IUA</td>
    <td>The value of the parameter shall be Bearer.</td>
   </tr>
   <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>scope</td>
    <td>R</td>
    <td>IUA</td>
    <td>The scope granted by the Authorization Server.</td>
   </tr>
   <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>expires_in</td>
    <td>R</td>
    <td>IUA</td>
    <td>Maximum duration of 5 minutes.</td>
   </tr>
  </tbody>
 </table>

<figcaption ID="11">Table: Description of the HTTP conversation of the transaction.</figcaption>  

#### Authorization Code Grant Type

This section specifies the OAuth 2.1 authorization code grant flow of the IUA Get Access Token transaction, which shall
be used by portals and primary systems.

<div>{% include IUA_ActorDiagram_ITI-71.svg %}</div>
<figcaption ID="1">Figure: Sequence diagram of the transaction.</figcaption>  

<table class="table table-bordered">

  <colgroup>
   <col span="1" style="width: 5%;">
   <col span="1" style="width: 25%;">
   <col span="1" style="width: 15%;">
   <col span="1" style="width: 15%;">
   <col span="1" style="width: 15%;">
   <col span="1" style="width: 25%;">
</colgroup>

  <thead>
   <tr>
    <th>Step</th>
    <th>Action</th>
    <th>Parameter</th>
    <th>Opt (Basic/ Extended).</th>
    <th>Reference</th>
    <th>Remark</th>
   </tr>
  </thead>
  <tbody>
   <tr>
    <td>00, 01</td>
    <td>The Authorization Client sends an HTTP GET request to the IUA Authorization Server endpoint.</td>
    <td>response_type</td>
    <td>R</td>
    <td>IUA</td>
    <td>The value SHALL be code.</td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>client_id</td>
    <td>R</td>
    <td>IUA</td>
    <td>The ID, the Authorization Client is registered at the IUA Authorization Server<sup><a href="#1">1</a></sup>.
    </td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>redirect_uri</td>
    <td>R</td>
    <td>IUA / SMART on FHIR</td>
    <td>Used as the callback URL the IUA Authorization Server will send the authorization code to. The URL SHALL match
     one of the client’s pre-registered redirect URIs.</td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>state</td>
    <td>R</td>
    <td>IUA</td>
    <td>An unguessable value used by the Authorization Client to track the state between the authorization request and
     the callback to the redirect_uri.</td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>scope</td>
    <td>R</td>
    <td>IUA / SMART on FHIR</td>
    <td>Attributes the Authorization Client claims (see detailed description below).</td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>aud</td>
    <td>R</td>
    <td>SMART on FHIR</td>
    <td>The URL or array of URL of the Resource Servers the token is intended to be used for.</td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>launch</td>
    <td>R</td>
    <td>SMART on FHIR</td>
    <td>An opaque identifier which indicates that a SMART on FHIR App was launched from a portal or primary system which
     is authorized to access the Swiss EPR as EHR launch.</td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>code_challenge</td>
    <td>R</td>
    <td>IUA</td>
    <td>Transformed version of code_verifier with code_challenge_method.</td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>code_challenge_method</td>
    <td>R</td>
    <td>IUA</td>
    <td>SHALL be “S256”.</td>
   </tr>
   <tr>
    <td>02, 03</td>
    <td>The Authorization Server performs an HTTP GET on the Authorization Client redirect_uri conveying
     the authorization code.</td>
    <td>code</td>
    <td>R</td>
    <td>IUA</td>
    <td>The authorization code generated by the Authorization Server.</td>
   </tr>
   <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>state</td>
    <td>R</td>
    <td>IUA</td>
    <td>The unguessable value used by the Authorization Client to track the state between the authorization request and
     the callback (redirect_uri).</td>
   </tr>
   <tr>
    <td>04</td>
    <td>The Authorization Client performs an HTTP POST with parameter as a form-encoded HTTP entity body, passing its
     client_id and client_secret as an HTTP authorization header field.</td>
    <td>client_id</td>
    <td>R</td>
    <td>IUA</td>
    <td>The ID the Authorization Client is registered at the IUA Authorization Server<sup><a href="#1">1</a></sup>.
    </td>
   </tr>
   <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>grant_type</td>
    <td>R</td>
    <td>IUA</td>
    <td>Value shall be “authorization_code”.</td>
   </tr>
   <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>code</td>
    <td>R</td>
    <td>IUA</td>
    <td>The authorization</td>
   </tr>
   <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>code_verifier</td>
    <td>R</td>
    <td>IUA</td>
    <td>The original code verifier string.</td>
   </tr>
   <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>client_assertion_type</td>
    <td>O</td>
    <td>Swiss extension</td>
    <td>An identifier of the client assertion type, either "urn:ietf:params:oauth:client-assertion-type:jwt-bearer" if a signed 
        JWT is presented, or "urn:ietf:params:oauth:client-assertion-type:saml2-bearer" for base64url encoded SAML 2 assertions <sup><a href="#2">2</a></sup>.
    </td>
   </tr>
   <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>assertion</td>
    <td>O</td>
    <td>Swiss extension</td>
    <td>The identity token the Authorization client retrieved from the certified Identity Provider after successful authentication 
        of the user, either a signed JWT, or a base64url encoded SAML 2 assertion <sup><a href="#2">2</a></sup>.
    </td>
   </tr>
   <tr>
    <td>05</td>
    <td>The Authorization Server responds with the access token in the HTML body element.</td>
    <td>access_token</td>
    <td>R</td>
    <td>IUA</td>
    <td>The access token which SHALL be a signed JWT token.</td>
   </tr>
   <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>token_type</td>
    <td>R</td>
    <td>IUA</td>
    <td>The value of the parameter shall be Bearer.</td>
   </tr>
   <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>scope</td>
    <td>R</td>
    <td>IUA</td>
    <td>The scope granted by the Authorization Server.</td>
   </tr>
   <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>expires_in</td>
    <td>R</td>
    <td>IUA</td>
    <td>Maximum duration of 5 minutes.</td>
   </tr>
  </tbody>
 </table>

<figcaption ID="5">Table: Description of the HTTP conversation of the transaction.</figcaption>  


<sup id="1">1</sup>For SMART on FHIR Apps launched in EPR mode the client_id SHALL be the ID of the portal or primary
system which launched the App.

<sup id="2">2</sup>The presentation of the IdP token is recommended for IUA Authorization Clients which do not use SMART
on FHIR EHR launch.

#### Get Access Token Request

##### Client Credential Grant Type

###### Trigger Events

A clinical archive system aims to access the EPR to write documents.

###### Message Semantics

The Authorization Client SHALL send an IUA compliant OAuth 2.1 Authorization Request for the client credential grant
type with Swiss extensions:

- grant_type (required): The value of the parameter shall be client_credentials.
- scope (required): The scope claimed by the Authorization Client, as defined in the table below.
- resource (optional): Single valued identifier of the Resource Server api endpoint to be accessed.
- requested_token_type (optional): The requested token format shall be urn:ietf:params:oauth:token-type:jwt.

The Authorization Request SHALL use the following Swiss extension:

- principal (optional): The name of the healthcare professional an assistant may act on behalf of.
- principal_id (required): The GLN of the healthcare professional an assistant may act on behalf of.
- person_id (optional/required): EPR-SPID identifier of the patient’s record and the patient assigning authority
  formatted in CX syntax, required for requesting extended access token.

The following table lists the scope values to be sent in the Authorization Request:

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
      <td>Shall be AUTO as defined in the code system 2.16.756.5.30.1.127.3.10.5 of the CH: EPR value set.</td>
    </tr>
    <tr>
      <td>subject_role</td>
      <td>R/R</td>
      <td>token</td>
      <td>See sections below.</td>
      <td>Shall be the value TCU as defined in the code system 2.16.756.5.30.1.127.3.10.1.1.3 of the CH: EPR value set.</td>
    </tr>
  </tbody>
</table>

<sup id="3">3</sup>Token format according FHIR [token type](https://www.hl7.org/fhir/search.html#token).

<figcaption ID="16">Table: Request’s scope parameter for the client credential flow.</figcaption>  

###### Expected Actions

When receiving a Get Access Token Request with purpose of use set to AUTO and subject role set to TCU, the Authorization
Server SHALL:

- identify and authenticate the Authorization Client with the client_id, client_secret and the client's certificate of
  the TLS connection.
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

The Authorization Client SHALL send an IUA compliant OAuth 2.1 Authorization Request for the client credential grant
type with Swiss extensions:

- grant_type (required): The value of the parameter shall be client_credentials.
- scope (required): The scope claimed by the Authorization Client, as defined in the table below.
- resource (optional): Single valued identifier of the Resource Server api endpoint to be accessed.
- requested_token_type (optional): The requested token format shall be urn:ietf:params:oauth:token-type:jwt.

The Authorization Request SHALL use the following Swiss extension:

- person_id (optional/required): EPR-SPID identifier of the patient’s record and the patient assigning authority
  formatted in CX syntax, required for requesting extended access token.
- principal (optional): The name of the healthcare professional an assistant may act on behalf of.
- principal_id (optional): The GLN of the healthcare professional an assistant may act on behalf of.
- group (optional): The name of the organization or group an assistant may act on behalf of
- group_id (optional): The OID of the organization or group an assistant is acting on behalf of.

The following table lists the scope values to be sent in the Authorization Request:

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
      <td>launch</td>
      <td>O/R</td>
      <td> </td>
      <td>SMART on FHIR</td>
      <td>The opaque identifier the SMART on FHIR App was launched with in an EHR launch. The claim is required for SMART on FHIR Apps launched from a portal or primary system.</td>
    </tr>
    <tr>
      <td>purpose_of_use</td>
      <td>O/R</td>
      <td>token</td>
      <td>See sections below.</td>
      <td>Value taken from code system 2.16.756.5.30.1.127.3.10.5 of the CH: EPR value set in [FHIR token type](https://www.hl7.org/fhir/search.html#token) format.</td>
    </tr>
    <tr>
      <td>subject_role</td>
      <td>O/R</td>
      <td>token</td>
      <td>See sections below.</td>
      <td>Value taken from code system 2.16.756.5.30.1.127.3.10.1.1.3 of the CH: EPR value set in [FHIR token type](https://www.hl7.org/fhir/search.html#token) format.</td>
    </tr>
  </tbody>
</table>

<figcaption ID="6">Table: Request’s scope parameter for the authorization code flow.</figcaption>  

The scope parameter of the request MAY claim the following attributes:

- There MAY be a scope with name “launch”. If present, it indicates the permission of SMART on FHIR Apps to obtain
  launch context from a portal or primary system authorized to access the EPR.
- There MAY be a scope with name "purpose_of_use=token". If present, the token SHALL convey the coded value of the
  current transaction’s purpose of use. Allowed values are NORM (normal access) and EMER (emergency access) from code
  system 2.16.756.5.30.1.127.3.10.5 of the CH:EPR value set. e.g. purpose_of_use=urn:oid:
  2.16.756.5.30.1.127.3.10.5\|NORM
- There MAY be a scope with name "subject_role=token". If present, the token SHALL convey the coded value of the
  subject’s role. The value SHALL be either HCP (healthcare professional), ASS (assistant), REP (representative) or
  PAT (patient) from code system 2.16.756.5.30.1.127.3.10.6 of the CH:EPR value set. e.g.: subject_role=urn:oid:
  2.16.756.5.30.1.127.3.10.6\|HCP

Note: The parameters need to be url encoded, see above message example.

Depending on the value of the _subject-role_ scope additional scopes are required, as described in the following
sections.

**Healthcare Professional Extension**

In the healthcare professional extension, the scope subject_role SHALL be the code HCP from code system
2.16.756.5.30.1.127.3.10.6 of the CH:EPR value set.

**Assistant Extension**

In the assistant extension, the scope subject_role SHALL be the code ASS from code system 2.16.756.5.30.1.127.3.10.6 of
the CH:EPR value set. There SHALL be a scope with name principal_id=value. The value SHALL convey the GLN of the
healthcare professional an assistant is acting on behalf of. There SHALL be a scope with name principal=value. The value
SHALL convey the name of the healthcare professional an assistant is acting on behalf of.

There MAY be one or more scopes with name group_id=value and corresponding group=value. If present each value SHALL
convey the ID and name of the subject’s organization or group as registered in the EPR HPD. The ID SHALL be an OID in
the format of a URN.

**Patient Extension**

In the patient extension, the scope subject_role SHALL be the code PAT from code system 2.16.756.5.30.1.127.3.10.6 of
the CH:EPR value set. The value of the purpose of use scope SHALL be the code NORM from code system
2.16.756.5.30.1.127.3.10.5 of the CH:EPR value set.

**Representative Extension**

In the representative extension, the scope subject_role SHALL be the code REP from code system
2.16.756.5.30.1.127.3.10.6 of the CH:EPR value set. The token of the purpose_of_use scope SHALL be the code NORM from
code system 2.16.756.5.30.1.127.3.10.5 of the CH:EPR value set.

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
  to
  authorize access to resources protected by the role and attribute based EPR authorization (i.e. read and write
  documents).
- SHALL validate the launch scope parameter. For SMART on FHIR Apps launched in an EPR Launch, the IUA Authorization
  Server SHALL verify that the portal or primary system which launched the SMART on FHIR App has been registered with
  this
  launch parameter value by the community during the onboarding process.
- SHALL verify that the Authorization Client is authorized to access the EPR on behalf of the user by a community policy
  or by the user's consent. To retrieve the user's consent, the IUA Authorization server SHALL authenticate the user by
  redirecting the user agent to an EPR compliant Identity Provider and present a form to the user to authorize the
  IUA Authorization Client to act on behalf of the user with a given scope. The Authorization Server MAY persist the
  users consent for future access by the Authorization Client.

In case of failure, the IUA Authorization Server SHALL respond with HTTP error code 401 ‘Not authorized’.

In case of success, the IUA Authorization Server SHALL send the authorization code to the Authorization Client
redirect-uri via the user agent.

The Authorization Client SHALL perform the HTTP POST request to the Authorization token endpoint to resolve the
authorization code to the access token, sending the client_id and client_secret in the HTTP authorization header field.

When retrieving the token request, the Authorization Server SHALL verify that the user is authenticated compliant to the
regulations of the Swiss EPR, either by validating the identity token send with the token request or by redirecting the
Authorization Client's user agent to an certified Identity Provider. In the latter case, the Identity Provider
authenticates the user based on its internal session management (i.e. by checking the requests cookies or other methods)
or by validating the user authentication means and returns the identity token to the IUA Authorization Server.

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

The second step of the conversation is an HTTP GET callback from the Authorization Server to the Authorization Client's
user agent conveying the authorization code, e.g.:

```http
GET /callback?code=8V1pr0rJ&state=98wrghuwuogerg97
```

The third step of the conversation is an HTTP POST sending the authorization code to retrieve the authorization token in
the response, e.g.:

```http
POST /token HTTP/1.1 
Host: localhost:9001

Accept: application/json
Content-type: application/x-www-form-urlencoded
Authorization: Basic bXktYXBwOm15LWFwcC1zZWNyZXQtMTIz
grant_type=authorization_code&
code=98wrghuwuogerg97&
code_verifier=qskt4342of74bkncmicdpv2qd143iqd822j41q2gupc5n3o6f1clxhpd2x11&
requested-token-type=urn:ietf:params:oauth:token-type:jwt
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
1.6.4.2 Get X-User Assertion, A5E1).

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

The Authorization Server and Resource Server SHALL support the following extensions to the JWT access token for an EPR
user:

- user_id: subject identifier according to Annex 5 E1, section 1.6.4.3.4.2 Message Semantics.

| JWT Claim (Extension) | Optionality (Basic/ Extended) | XUA Attribute EPR                                   | Remark |
|-----------------------|-------------------------------|-----------------------------------------------------|--------|
| user_id               | O/R                           | &lt;NameID&gt; child element of the &lt;Subject&gt; |        |
| user_id_qualifier     | O/R                           | Name qualifier attribute of &lt;NameID&gt;          |        |

{:class="table table-bordered"}

<figcaption>Table: Attributes of the IUA Get Access Token response in the JWT extension ch_delegation.</figcaption>

###### The JWT ch_group extension

The Authorization Server and Resource Server SHALL support the following extensions to the JWT access token for a list
of groups a subject is member of:

- name: Name of the organization/group. The name SHALL be a string.
- id: The id of the organization/group.The id SHALL be an OID in the format of a URN

The ch_group extension claims shall be wrapped in an "extensions" object with key "ch_group" and a JSON array containing
the JSON objects with properties name and id. The id SHALL be an OID in the format of a URN.

| ch_group array element | Optionality (Basic/ Extended) | XUA Attribute EPR                                   | Remark                                          |
|------------------------|-------------------------------|-----------------------------------------------------|-------------------------------------------------|
| name                   | O/R                           | urn:oasis:names:tc:xspa:1.0:subject:organization    | An array of groups with properties name and id. |
| id                     | O/R                           | urn:oasis:names:tc:xspa:1.0:subject:organization-id | An array of group names and group ids.          |

{:class="table table-bordered"}

<figcaption>Table: Attributes of the IUA Get Access Token response in the JWT extension ch_group.</figcaption>  

###### The JWT ch_delegation extension

The Authorization Server and Resource Server shall support the following extensions to the JWT access token:

- principal (optional) Name of the healthcare professional an assistant is acting on behalf of.
- principal_id (optional) GLN of the healthcare professional an assistant is acting on behalf of.

The ch_delegation extension claims shall be wrapped in an "extensions" object with key 'ch_delegation' and a JSON value
object containing the claims.
The claim content for the JWT CH:EPR extensions shall correspond to the content defined in the XUA specification (see
1.6.4.2 Get X-User Assertion, A5E1).

| JWT Claim (Extension) | Optionality (Basic/ Extended) | XUA Attribute EPR                  | Remark                                                                   |
|-----------------------|-------------------------------|------------------------------------|--------------------------------------------------------------------------|
| principal             | O/R                           | urn:e-health-suisse:principal-name | Name of the healthcare professional an assistant is acting on behalf of. |
| principal_id          | O/R                           | urn:e-health-suisse:principal-id   | GLN of the healthcare professional an assistant is acting on behalf of.  |

{:class="table table-bordered"}

<figcaption>Table: Attributes of the IUA Get Access Token response in the JWT extension ch_delegation.</figcaption>

##### Expected Actions

The business rules for the IUA Authorization Server for the Healthcare Professional, Assistant, Patient and
Representative
Extension SHALL be the same as for Annex 5E1 1.6.4.2.4.4 Expected Actions X-Assertion Provider Extensions.

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
