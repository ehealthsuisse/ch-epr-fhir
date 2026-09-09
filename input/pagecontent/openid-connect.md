

### Scope

This national extension defines restrictions and extensions to the 
[OpenID Connect 1.0](https://openid.net/specs/openid-connect-core-1_0.html) authorization code flow to 
retrieve EPR compliant identity token used to identify and authenticate users. 

Identity Provider SHALL provide trusted endpoints for Relying Parties implementing the OpenID Connect 1.0 authorization
code flow fulfilling the requirements defined in this section. Other flows supported by OpenID Connect SHALL not be 
supported.

### Definition of terms 

Relying Party - A Relying Party is understood as any actor that relies on an identity claim provided
by an Identity Provider for user authentication. In the context of the EPR, Relying Parties are in
particular medical information systems and portals for patients and healthcare professionals, which
access data and documents from the EPR.

Identity Provider - An Identity Provider is understood as a legal entity which manages the 
user's primary authentication credentials and issues authenticators and assertions derived from
those credentials. Identity Provider typically operate a Verifier and a Credential Service Provider,
but may delegate the services to other provider on a contractual basis.

Verifier - A verifier is understood as any Actor that corroborates identity information, by verifying the
user's identity and by verifying the user’s possession and control of authenticators using an authentication 
protocol.

Credential Service Provider - A Credential Service Provider is understood as actor which registers,
verifies and provides assertion attributes of users. The Credential Service Provider typically
operates Registration and Local Registration Authorities, but may delegate the services to other
provider on a contractual basis.

Certificate Authority - Identity provider MAY operate a managed Certificate Authority (CA) that is 
operated according to documented processes detailed in a Certificate Policy (CP) and Certificate Practice
Statement (CPS). The CA's processes SHALL meet the requirements of class 1 certificates defined within 
the [eCH-0048 PKI Certificate Classes standard Version 2.0](https://www.ech.ch/de/ech/ech-0048/2.0). They MAY 
use this Certificate Authority to issue client certificates (mTLS) for Relying Parties. Identity providers 
MAY may delegate the service to other provider on a contractual basis. 


### Referenced Standards

- [OpenID Connect Core 1.0 incorporating errata set 2](https://openid.net/specs/openid-connect-core-1_0.html), November 2014.
- [The OAuth 2.0 Authorization Framework, RFC 6749](https://datatracker.ietf.org/doc/html/rfc6749), October 2012
- [JSON Web Signature (JWS), RFC 7515](https://www.rfc-editor.org/info/rfc7515/), May 2015.
- [Proof Key for Code Exchange by OAuth Public Clients (PKCE), RFC 7636](https://www.rfc-editor.org/info/rfc7636/), September 2015
- [JSON Web Token (JWT), RFC 7519](https://www.rfc-editor.org/info/rfc7519/), May 2015.
- [The OAuth 2.0 Authorization Framework: Bearer Token Usage, RFC 6750](https://datatracker.ietf.org/doc/html/rfc6750), October 2012.
- [OpenID Connect Back-Channel Logout 1.0 incorporating errata set 1](https://openid.net/specs/openid-connect-backchannel-1_0.html), October 2023.
- [OpenID Connect RP-Initiated Logout 1.0](https://openid.net/specs/openid-connect-rpinitiated-1_0.html), September 2022.
- [eCH-0048 PKI Certificate Classes standard Version 2.0](https://www.ech.ch/de/ech/ech-0048/2.0), November 2018.

### Sequences

#### User Authentication

<div style="width: 80%;">
{% include OpenID-Auth-code-flow.svg %}
</div>
Figure 1: Authentication Sequence with OpenID Connect 1.0 Authorization Code Flow

| SEQ     | Description                                                                                                                                                                                                                                                                                                     |
|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 01,02   | The user agent attempts to access a resource on the relying party on behalf of the user.                                                                                                                                                                                                                        |
| 03      | The Relying Party presents the list of supported Identity Provider to the user.                                                                                                                                                                                                                                 |
| 04,05   | The user selects a Identity Provider.                                                                                                                                                                                                                                                                           |
| 06      | The Relying Party builds an Authentication Request containing the required request parameter and conveys it to the User Agent with a redirect to the authorization endpoint of the Identity Provider.                                                                                                           |
| 07      | The User Agent sends the Authentication Request to the authorization endpoint via HTTP GET or POST protocol.                                                                                                                                                                                                    |
| 08      | The Identity Provider determines whether the user has a logon security context that meets the default or requested authentication policy requirements. If not, the Verifier interacts with the browser to challenge the user to provide valid credentials.                                                      |
| 09...11 | The Identity Provider communicates with the Authenticator(s) to authenticate the user. The user provides valid credentials and the Identity Provider creates a local logon security context for the user.                                                                                                       |
| 12      | The Identity Provider presents a screen for the user to authorize the Relying Party to retrieve the identity data.This step MAY be omitted if the Relying Party application is a confidential client as defined in the OAuth specification and the users consent is stored in a policy or after the initial authorization. |
| 13, 14  | The Identity Provider creates an Authentication Response conveying the Authorization Code and sends the Authorization Response to the User Agent with a redirect to the Relying Party.                                                                                                                          |
| 15      | The Relying Party sends the Authentication Code to the Identity Provider in an Access Token Request using HTTP POST protocol and form serialization.                                                                                                                                                            |
| 16      | The Identity Provider identifies the Relying Party and sends an Access Token Response to the Relying Parties Redirection URI registered beforehand. The Access Token Response conveys an ID and an Access Token.                                                                                                |
| 17      | The Relying Party validates the ID Token and retrieves the user's Subject Identifier.                                                                                                                                                                                                                           |
| 18,19   | Optionally the Relying Party uses the Access Token to retrieve user identity data using the OpenID Connect 1.0 UserInfo protocol.                                                                                                                                                                               |
| 20...22 | The Relying Party returns the requested resource to the user agent.                                                                                                                                                                                                                                             |
{:class="table table-bordered"}

Table 1: Authentication Sequence with OpenID Connect 1.0 Authorization Code Flow

#### Logout

<div>
{% include OpenID-Logout.svg %}
</div>
Figure 2: OpenID Connect Logout Sequence

| SEQ    | Description                                                                                                                                                                              |
|--------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 01     | The user initiates a logout in the user agent of the Relying Party application. The Relying Party redirects the user agent with a Logout Request message to the Identity Provider Logout URI. |
| 02, 03 | The Identity Provider terminates the IdP session and responds to the initial Logout Request with a Logout Response using HTTP.                                                                    |
| 04     | The Relying Party application terminates the user session.                                                                                                                               |
{:class="table table-bordered"}

Table 2: OpenID Connect Logout Sequence

### Messages

#### Authentication Request

The Authentication Request message SHALL be used by the Relying Party to
initiate the authentication sequence. The Authentication Request message
SHALL be compliant with an OAuth 2.0 Authentication Request message.

Relying Parties which fulfill the requirements of confidential
clients SHALL sign the Authentication Request message using JSON Web
Signature.

The Authentication Request SHALL contain the following parameters:
- *scope*: The value SHALL be *openid*.
- *response_type*: The value SHALL be *code*.
- *client_id*: The value SHALL be the Client Identifier the Relying 
  Party was registered with at the Identity Provider.
- *redirect_uri*: SHALL convey the redirection URI the Access Token
  Response SHALL be sent to. Its value must match one of the
  redirection URI the Relying Party was registered at the Identity Provider.
- *state*: SHALL convey an opaque value used to maintain the state
  between the request and the response to mitigate Cross-Site Forgery
  attacks.
- *nonce*: SHALL convey an opaque string passed through from the
  Authentication Request to the ID Token to mitigate replay attacks.
- *code_challenge*: code challenge derived from the code Identity Provider
  using the code challenge method as defined in PKCE.
- *code_challenge_method*: code challenge method indicator defined
  in PKCE (fn. 23). Its value must be S256.


The Identity Provider SHALL validate the Access Token Request as specified in 
the [OpenID Connect Core 1.0](https://openid.net/specs/openid-connect-core-1_0.html) specification.

#### Authentication Response

The Authentication Response message SHALL be used by the Identity Provider as
response to the Authentication Request message to convey the
authorization code after authenticating the user. The
Authentication Response message SHALL be compliant with an OAuth 2.0
Authentication Response message.

The Authentication Response SHALL contain the following parameters:
- *code*: SHALL be an OAuth 2.0 compliant authorization code.
- *state*: SHALL match the state parameter value of the Authentication Request.

In case of an error the Identity Provider SHALL respond a HTTP Error as defined
in [OpenID Connect Core 1.0](https://openid.net/specs/openid-connect-core-1_0.html#AuthError) specification.

#### Access Token Request

The Access Token Request message SHALL be used by the Relying Party to
resolve the authorization code to the Access and ID Token. The Access
Token Request message SHALL be sent via the backchannel. The Access
Token Request message SHALL be compliant with an OAuth 2.0 Access Token
Request message.

Relying Parties which fulfill the requirements of confidential clients
SHALL sign the Access Token Request message using [JSON Web Signature](https://www.rfc-editor.org/info/rfc7515/).

The Access Token Request SHALL contain the following parameters:
- *grant_type*: The value SHALL be authorization_code.
- *code*: SHALL be the OAuth 2.0 compliant authorization code
  retrieved with the Authentication Response.
- *redirect_uri*: SHALL convey the redirection URI the Access Token
  Response SHALL be sent to. Its value must match the redirection URI
  sent with the Authentication Request.
- *code_Identity Provider*: The code Identity Provider value as defined in PKCE (fn. 23).

The Identity Provider SHALL validate the Access Token Request as follows:
1. Identify the client using the client_id. 
2. Verify the signature of the request, if the Relying Party is
   registered as a confidential client, i.e. verify that a secure
   cryptographic algorithm is applied compliant with the JSON Web
   Signature specification. 
3. Authenticate the Relying Party, if the client application is
   registered as a confidential client. 
4. Verify that the authorization code was issued to the Relying Party
   in response to an Authentication Request. 
5. Verify that the authorization code was not used before. 
6. Verify that the value of the *redirect_uri* parameter send with the
   Access Token Request matches the one sent with the Authentication
   Request. 
7. Verify that the value of the *redirect_uri* parameter send with the
   Access Token Request matches one of the re-direct URIs registered
   for the Relying Party. 
8. Verify that the *code-Identity Provider* matches the *code_challenge* send
   with the authentication request respecting the S256 code challenge
   method.

#### Access Token Response

The Access Token Response message SHALL be used by the Identity Provider to convey
the Access Token and the ID Token to the Relying Party in response the
Access Token Request. The Access Token Response message SHALL be send
via the backchannel. The Access Token Response message SHALL be
compliant with an OAuth 2.0 Access Token Response message.

The Access Token Response SHALL contain the following parameters:
- *token_type*: The value SHALL be *Bearer.*
- *expires_in --* The Token lifetime in seconds. The value SHALL be equal to *300* (5 minutes).
- *access_token*: The value SHALL be an OAuth 2.0 compliant access token.
- *id_token*: The value shall be an Identity Token as defined below.

In case of an error the Identity Provider SHALL respond a HTTP Error as defined
in [OpenID Connect Core 1.0](https://openid.net/specs/openid-connect-core-1_0.html#TokenErrorResponse) specification.

##### Message Example

```
HTTP/1.1 200 OK
Content-Type: application/json
{
  "token_type": "Bearer",
  "expires_in": 1788875107,
  "access_token": "e4205d40-ac65-42b5-9327-4d7cecc08dd6",
  "id_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc..."
}
```

#### Identity Token

The Identity Token SHALL be used by the Identity Provider to convey the Subject Identifier to the Relying 
Party. The Identity Token SHALL be compliant with the JSON Web Token and [OpenID Connect Core 1.0](https://openid.net/specs/openid-connect-core-1_0.html#IDToken) specification.

Identity Tokens SHALL be cryptographically signed using [JSON Web Signature](https://www.rfc-editor.org/info/rfc7515/)and the Relying Party SHALL 
validate the signature. 

The Identity Token SHALL contain the following parameters:
- *iss*: The value SHALL be a unique identifier of the Identity Provider as URL.
- *sub*: The Subject Identifier of the user.
- *aud*: The value SHALL be the Client Identifier the Relying Party is registered at the Identity Provider.
- *exp*: The time restricting the lifetime of the token lifetime. The value SHALL be equal to the current time plus 5 minutes.
- *iat*: The time the token was issued by the Identity Provider.
- *nonce*: The value SHALL match the *nonce* value of the Authentication Request.
- *jti*: The value shall be a unique identifier of the ID Token.

The Subject Identifier attribute SHALL be persistent and SHALL be unique for the combination of the 
Subscriber, the Community and the Identity Provider to reduce the risk of cross application identification. 
The Subject Identifier SHALL be confidential and never presented to the user or third party systems.

The Identity Token MAY contain a session identifier in a *sid* attribute, if the Identity Provider 
supports per session logout.

The Identity Token MAY contain other claims which SHALL be ignored by the Relying Party.

The Relying Parties SHALL validate Identity Tokens as follows:

1. Verify that the unique identifier of the Issuer matches the one registered for the Identity Provider. 
2. Verify that the value of the *aud* parameter matches the Client Identifier of the Relying Party. 
3. Validate the signature according to [JSON Web Signature](https://www.rfc-editor.org/info/rfc7515/) using the algorithm specified in the JWT *alg* Header Parameter. 
4. Verify that the signature algorithm matches the algorithm configured for the Identity Provider. 
5. Verify that the Identity Token is not expired and the current time is later or equal to the time the token was issued by the Identity Provider. 
6. Verify that a *nonce* claim is present and its value matches the one that was sent in the Authentication Request.

##### Message Example

```
{
  "iss": "http://client-simulator.org",
  "sub": "16d83c5e85c3",
  "aud": "rp-client-id",
  "exp": 1788875295,
  "iat": 1788874695,
  "nonce": "n-0S6_WzA2Mj",
  "jti": "ba43b960-ac25-437e-970a-f74031874c64"
}
```

#### UserInfo Request

The UserInfo Request message SHALL be used by the Relying Party to retrieve identity data of the user from the Credential
Service Provider via the backchannel. The UserInfo Request message SHALL
be compliant to the [OpenID Connect 1.0 UserInfo Request](https://openid.net/specs/openid-connect-core-1_0.html#UserInfo) message.

Relying Parties SHALL sign the UserInfo Request message using [JSON Web Signature](https://www.rfc-editor.org/info/rfc7515/). 

The Relying Party SHALL send the Access Token in the HTTP Authorization header field as Bearer Token as defined 
in [OAuth 2.0 Authorization Framework: Bearer Token Usage](https://www.rfc-editor.org/info/rfc6750/).

The Identity Provider SHALL validate the User Info Request as follows:
1. Validate the signature according to [JSON Web Signature](https://www.rfc-editor.org/info/rfc7515/) using the algorithm specified in the JWT *alg* Header Parameter. 
2. Verify that the signature algorithm matches the algorithm configured for the Relying Party at the Identity Provider.

##### Message Example

The following listing displays a non-normative example for a UserInfo request with the access token in the 
http authorization header: 

```
 GET /userinfo HTTP/1.1
  Host: server.example.com
  Authorization: Bearer SlAV32hkKG
```

#### UserInfo Response

The UserInfo Response message SHALL be used by the Credential Service Provider to respond with the identity data of the user to
UserInfo Requests from the Relying Party using back-channel communication. The UserInfo Response message SHALL be a JSON Web Token
(JWT) compliant to the [OpenID Connect 1.0 UserInfo Response message](https://openid.net/specs/openid-connect-core-1_0.html#UserInfo).

The UserInfo Response SHALL contain the following parameters:
- *sub*: The subject identifier of the user.
- *first_name*: The first name of the user.
- *family_name*: The family name of the user.
- *gender*: The users coded gender with the value from the value set EprGender (2.16.756.5.30.1.127.3.10.1.25).
- *birthdate*: The users date of birth as ISO 8601-1:2019 formatted string.

If the Identity Provider delivers the GLN of healthcare professionals or assistants, the UserInfo Response 
SHALL contain a *gln* parameter conveying the GLN of healthcare professionals and assistants.

Identity Provider MAY provide other identity claims as defined in 
the [OpenID Connect 1.0 Core](https://openid.net/specs/openid-connect-core-1_0.html) specification.

In case of an error the Identity Provider SHALL respond a HTTP Error as defined in [Section 5.3.3 of the 
OpenID Connect Core 1.0](https://openid.net/specs/openid-connect-core-1_0.html#UserInfoError) specification.

The UserInfo response message SHALL be signed using recommended cryptographic signature standards and the 
signature SHALL be validated by the relying party.

##### Message Example

The following listing displays a non-normative example for a UserInfo response with the required fields and 
an optional GLN: 

```
HTTP/1.1 200 OK
Content-Type: application/json
  {
   "sub": "248289761001",
   "first_name": "Maria",
   "family_name": "Mustermann",
   "gender": "F", 
   "birthdate": "25.07.1998", 
   "gln": "9801000050702" 
  }
```

#### Logout Request

The *LogoutRequest* message SHALL be used by the Relying Party to notify the Identity Provider that a user logged 
out in the Relying Party application.

*LogoutRequest* messages send by the Relying Party to the Identity Provider SHALL be compliant with the
[OpenID Connect RP-Initiated Logout 1.0](https://openid.net/specs/openid-connect-rpinitiated-1_0.html) specification with the requirements defined in this section.

*LogoutRequest* messages SHALL contain a JWT with the following parameters:
- *id_token_hint*: SHALL convey the Identity Token previously issued by the Identity Provider.
- *state*: SHALL convey an opaque value used to maintain the state
   between the request and the response to mitigate Cross-Site Forgery attacks.

The JWT MAY contain other claims which SHALL be ignored by the Identity Provider.

Relying Parties which fulfill the requirements of confidential clients SHALL sign the *LogoutRequest* message 
using [JSON Web Signature](https://www.rfc-editor.org/info/rfc7515/).

The Identity Provider SHALL validate *LogoutRequest* messages as follows:
1. Verify that the Identity Token was issued by the Identity Provider for the requesting client and user. 
2. Verify the signature of the Request Message, if the Relying Party was registered as confidential client. 
3. The JWT MAY contain other claims which SHALL be ignored by the Relying Party. 

The Relying Party SHALL validate *LogoutRequest* messages as follows:
1. Verify that the unique identifier of the Issuer matches the one registered for the Identity Provider. 
2. Verify that the value of the aud parameter matches the Client Identifier of the Relying Party. 
3. Validate the signature according to [JSON Web Signature](https://www.rfc-editor.org/info/rfc7515/) using the algorithm specified in the JWT alg Header Parameter. 
4. Verify that the current time is later or equal to the time the Logout Request was issued by the Identity Provider.

Relying Parties SHALL sign the *LogoutRequest* message and Identity Provider SHALL verify the signature. 

##### Message Example

The following listing displays a non-normative example for a Logout Request send by the relying party as http 
GET transaction with the recommended *id_token_hint* and an optional *post_logout_redirect_uri* :

```
https://idp.com/logout?id_token_hint=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...&post_logout_redirect_uri=https://relying-party.com/redirect
```

#### Logout Response

The *LogoutResponse* message SHALL be send by the Identity Provider to the Relying Party to confirm session termination.

The *LogoutResponse* message SHALL be compliant with Logout Response message defined in the 
[OpenID Connect Back-Channel Logout](https://openid.net/specs/openid-connect-backchannel-1_0.html) specification with the requirements defined in this section.

The *LogoutResponse* message SHALL be signed using recommended cryptographic signature standards and Relying Parties 
SHALL validate the signature of *LogoutResponse* messages.


### Security Considerations

#### Front-channel Communication

The User Agent and the Identity Provider SHALL communicate through an authenticated protected channel using 
TLS 1.2 or higher. The Identity Provider SHALL identify and authenticate itself with X.509 certificates
issued by a class 2 TLS certificate issued by a trusted certificate service provider according to ZertES; 
SR 943.03 and listed by the Swiss Accreditation Service (SAS).

#### Back-channel Communication

The Identity Provider SHALL communicate with Relying Parties through an authenticated
and protected back-channel using TLS 1.2 or higher for access token and user info requests and
responses. 

The Identity Provider SHALL NOT use redirects through an intermediary user agent (e.g., Web Browser) to send requests
to Relying Parties.

The Identity Provider SHALL identify and authenticate itself with class 2 X.509 certificates 
issued by a trusted certificate service provider according to ZertES; SR 943.03 and listed by the Swiss
accreditation service (SAS).

Identity Provider SHALL identify and authenticate the Relying Parties by using mutual TLS (mTLS) or the 
*private_key_jwt* option defined in Section 9 of 
the [OpenID Connect Core 1.0](https://openid.net/specs/openid-connect-core-1_0.html) specification.

The Relying Party SHALL use a certificate issued by a Certificate Authority (CA) that is operated according to 
documented processes detailed in a Certificate Policy (CP) and Certificate Practice Statement (CPS) for 
digital signatures or the mTLS client certificate. 

The CA's processes SHALL meet the requirements of class 1 certificates defined within 
the [eCH-0048 PKI Certificate Classes standard Version 2.0](https://www.ech.ch/de/ech/ech-0048/2.0). This 
Certificate Authority (CA) MAY be operated by the Identity Provider or MAY be delegated by the Identity Provider 
to a provider on a contractual basis.



