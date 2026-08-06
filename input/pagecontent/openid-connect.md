# OpenID Connect

Verifier and Credential Service Provider SHALL provide trusted endpoints
for Relying Parties implementing the OpenID Connect 1.0 Authorization
Code Flow fulfilling the requirements defined in this section. Other
flows supported by OpenID Connect (i.e., Renew Flow, Hybrid or Implicit
Flows) SHALL not be supported.

# Referenced Standards

- OpenID Connect Core 1.0 incorporating errata set 1, November 2014.
- The OAuth 2.0 Authorization Framework, RFC 6749, October 2012
- JSON Web Signature (JWS), RFC 7515, May 2015.
- Proof Key for Code Exchange by OAuth Public Clients (PKCE), RFC 7636, September 2015
- JSON Web Token (JWT), RFC 7519, May 2015.
- OpenID Connect Back-Channel Logout 1.0 - draft 06, August 2020.
- The OAuth 2.0 Authorization Framework: Bearer Token Usage, RFC 6750, October 2012.
- OpenID Connect RP-Initiated Logout 1.0 - draft 01, August 2020.
- eCH-0048 PKI Certificate Classes standard Version 2.0, November 2018.

## Sequences

### User Authentication

![Figure 5: Authentication Sequence with OpenID Connect 1.0 Authorization Code Flow](media/image1.png)

| SEQ      | Description                                                                                                                                                                                                                                                                                                                         |
|----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 01,02    | The Claimant's user agent attempts to access a resource on the relying party.                                                                                                                                                                                                                                                       |
| 03       | The Relying Party presents the list of supported Verifiers to the Claimant.                                                                                                                                                                                                                                                         |
| 04,05    | The Claimant selects Verifier.                                                                                                                                                                                                                                                                                                      |
| 06       | The Relying Party builds an Authentication Request containing the required request parameter and conveys it to the User Agent with a redirect to the authorization endpoint of the Verifier.                                                                                                                                        |
| 07       | The User Agent sends the Authentication Request to the authorization endpoint via HTTP GET or POST protocol.                                                                                                                                                                                                                        |
| 08       | The Verifier determines whether the Claimant has an existing logon security context that meets the default or requested authentication policy requirements. If not, the Verifier interacts with the browser to challenge the Claimant to provide valid credentials.                                                                 |
| 09...11  | The Verifier communicates with the Authenticator(s) to authenticate the Claimant. The Claimant provides valid credentials and the Verifier creates a local logon security context for the Claimant.                                                                                                                                 |
| 12       | The Verifier presents a screen for the Claimant to authorize the Relying Party to retrieve the identity data.This step MAY be omitted if the Relying Party application is a confidential client as defined in the OAuth specification and the Claimant/Subscriber consent is stored in a policy or after the initial authorization. |
|13, 14    | The Verifier creates an Authentication Response conveying the Authorization Code and sends the Authorization Response to the User Agent with a redirect to the Relying Party.                                                                                                                                                       |
| 15       | The Relying Party sends the Authentication Code to the Verifier in an Access Token Request using HTTP POST protocol and form serialization.                                                                                                                                                                                         |
| 16       | The Verifier identifies the Relying Party and sends an Access Token Response to the Relying Parties Redirection URI registered beforehand. The Access Token Response conveys an ID and an Access Token.                                                                                                                             |
| 17       | The Relying Party validates the ID Token and retrieves the Claimant's Subject Identifier.                                                                                                                                                                                                                                           |
| 18,19    | Optionally the Relying Party uses the Access Token to retrieve user identity data using the OpenID Connect 1.0 UserInfo protocol.                                                                                                                                                                                                   |
| 20...22  | The Relying Party returns the requested resource to the  Claimant's user agent.                                                                                                                                                                                                                                                     |

: Table 1: Authentication Sequence with OpenID Connect 1.0
Authorization Code Flow

### Logout

![Figure 6: OpenID Connect Logout Sequence](media/image2.jpeg)

| SEQ    | Description                                                                                                                                                                              |
|--------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 01     | The Claimant initiates a logout in the user agent of the Relying Party application. The Relying Party redirects the user agent with a Logout Request message to the Verifier Logout URI. |
| 02, 03 | The Verifier terminates the IdP session and responds to the initial Logout Request with a Logout Response using HTTP.                                                                    |
| 04     | The Relying Party application terminates the user session.|

: Table 2: OpenID Connect Logout Sequence


## Protocol Requirements

### Front-channel Communication

The User Agent and the Verifier SHALL communicate through an
authenticated protected channel using TLS 1.2 or higher. The Verifier
SHALL identify and authenticate itself with X.509 certificates which are
issued by a class 2 TLS certificate issued by a trusted certificate
service provider according to ZertES; SR 943.03 and listed by the Swiss
Accreditation Service (SAS).

Relying Parties and Authenticators which communicate with the Verifier
and Credential Service Provider through an intermediary user agent SHALL
use digital signatures for message level authentication. The X.509
certificates used for signatures SHALL be issued by a managed
Certificate Authority (CA) that is operated according to documented
processes detailed in a Certificate Policy (CP) and Certificate Practice
Statement (CPS). The CA's processes SHALL meet the requirements of class
1 certificates defined within the eCH-0048 PKI Certificate Classes
standard (Version 2.0).

Relying Parties which fulfill the requirements of confidential clients
of the OAuth 2.0 specification, SHALL use digital signatures for message
level authentication.

### Back-channel Communication

The Verifier and the Credential Service provider SHALL communicate with
Relying Parties through an authenticated and protected back-channel
using TLS 1.2 or higher for access token and user info requests and
responses. The Verifier SHALL identify and authenticate itself with
class 2 X.509 certificates issued by a trusted certificate service
provider according to ZertES; SR 943.03 and listed by the Swiss
accreditation service (SAS).

Relying Parties SHALL fulfill the requirements of OAuth 2.0 confidential
clients and SHALL use message level authentication (e.g., digital
signature) to authenticate. Relying Parties SHALL use X.509 certificates
issued by a managed Certificate Authority (CA) that are operated
according to documented processes detailed in a Certificate Policy (CP)
and Certificate Practice Statement (CPS) to identify and authenticate
themselves for access token and user info requests. The CA\'s processes
should meet the requirements of class 1 certificates defined within the
eCH-0048 PKI Certificate Classes standard (Version 2.0).

The Verifier and the Credential Service Provider SHALL NOT use redirects
through an intermediary user agent (e.g., Web Browser) to send requests
to Relying Parties.

### Client Authentication

If the Relying Parties provide confidential clients, the clients SHALL
authenticate when performing Access Token Requests using the
*private_key_jwt* option defined in Section 9 of the OpenID Connect Core
1.0 specification.

## Messages

### Authentication Request

The Authentication Request message SHALL be used by the Relying Party to
initiate the authentication sequence. The Authentication Request message
SHALL be compliant with an OAuth 2.0 Authentication Request message.

Relying Parties which fulfill the requirements of confidential
clients SHALL sign the Authentication Request message using JSON Web
Signature. The signature SHALL be asymmetric using X.509
certificates issued by a managed Certificate Authority (CA) that is
operated according to documented processes detailed in a Certificate
Policy (CP) and Certificate Practice Statement (CPS). The CA\'s
processes should meet the requirements of class 1 certificates defined
within the eCH-0048 PKI Certificate Classes standard (Version 2.0).

The Authentication Request SHALL contain the following parameters:
- *scope*: The value SHALL be *openid*.
- *response_type*: The value SHALL be *code*.
- *client_id*: The value SHALL be the Client Identifier the Relying
Party was registered with at the Verifier.
- *redirect_uri*: SHALL convey the redirection URI the Access Token
Response SHALL be sent to. Its value must match one of the
redirection URI the Relying Party was registered at the Verifier.
- *state*: SHALL convey an opaque value used to maintain the state
between the request and the response to mitigate Cross-Site Forgery
attacks.
- *nonce*: SHALL convey an opaque string passed through from the
Authentication Request to the ID Token to mitigate replay attacks.
- *code_challenge*: code challenge derived from the code verifier
using the code challenge method as defined in PKCE.
- *code_challenge_method*: code challenge method indicator defined
in PKCE (fn. 23). Its value must be S256.


The Verifier SHALL validate the Access Token Request as follows:
1. Identify the client using the *client_id*. 
2. Verify the signature of the request if the Relying Party is
registered as a confidential client. 
3. Verify that a secure cryptographic algorithm is applied. 
4. Authenticate the Relying Party, if the client application is
registered as a confidential client. 
5. Validate the signature according to JSON Web Signature (see fn. 22)
using the algorithm specified in the JWT *alg* Header Parameter.

### Authentication Response

The Authentication Response message SHALL be used by the Verifier as
response to the Authentication Request message to convey the
authorization code after authenticating the Claimant/Subscriber. The
Authentication Response message SHALL be compliant with an OAuth 2.0
Authentication Response message.

The Authentication Response SHALL contain the following parameters:
- *code*: SHALL be an OAuth 2.0 compliant authorization code.
- *state*: SHALL match the state parameter value of the
Authentication Request.

In case of an error the Verifier SHALL respond a HTTP Error as defined
in Section 3.1.2.6 of the OpenID Connect Core 1.0 specification (see fn.
20).

The authentication response message SHALL be signed using recommended
cryptographic signature standards. The signature SHALL be validated by
the relying party. The X.509 certificate used for signatures by the
Verifier SHALL be issued by a trusted certificate service provider
according to ZertES; SR 943.03 and listed by the Swiss Accreditation
Service (SAS).

### Access Token Request

The Access Token Request message SHALL be used by the Relying Party to
resolve the authorization code to the Access and ID Token. The Access
Token Request message SHALL be sent via the backchannel. The Access
Token Request message SHALL be compliant with an OAuth 2.0 Access Token
Request message.

Relying Parties which fulfill the requirements of confidential clients
(see fn. 21) SHALL sign the Access Token Request message using JSON Web
Signature (see fn. 22). The signature SHALL be asymmetric using X.509
certificates issued by a managed Certificate Authority (CA) that is
operated according to documented processes detailed in a Certificate
Policy (CP) and Certificate Practice Statement (CPS). The CA\'s
processes should meet the requirements of class 1 certificates defined
within the eCH-0048 PKI Certificate Classes standard (Version 2.0).

The Access Token Request SHALL contain the following parameters:
- *grant_type*: The value SHALL be authorization_code.
- *code*: SHALL be the OAuth 2.0 compliant authorization code
retrieved with the Authentication Response.
- *redirect_uri*: SHALL convey the redirection URI the Access Token
Response SHALL be sent to. Its value must match the redirection URI
sent with the Authentication Request.
- *code_verifier*: The code verifier value as defined in PKCE (fn.
23).

The Verifier SHALL validate the Access Token Request as follows:
1. Identify the client using the client_id. 
2. Verify the signature of the request, if the Relying Party is
registered as a confidential client, i.e. verify that a secure
cryptographic algorithm is applied compliant with the JSON Web
Signature (see fn. 22) specification. 
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
8. Verify that the *code-verifier* matches the *code_challenge* send
with the authentication request respecting the S256 code challenge
method.

### Access Token Response

The Access Token Response message SHALL be used by the Verifier convey
the Access Token and the ID Token to the Relying Party in response the
Access Token Request. The Access Token Response message SHALL be send
via the backchannel. The Access Token Response message SHALL be
compliant with an OAuth 2.0 Access Token Response message.

The Access Token Response SHALL contain the following parameters:
- *token_type*: The value SHALL be *Bearer.*
- *expires_in --* The Token lifetime in seconds. The value SHALL be
equal to *300* (5 minutes).
- *access_token*: The value SHALL be an OAuth 2.0 compliant access
token.
- *id_token*: The value shall be an Identity Token as defined below.

In case of an error the Verifier SHALL respond a HTTP Error as defined
in Section 3.1.3.4 of the OpenID Connect Core 1.0 specification (see fn.
20).

The access token response message SHALL be signed using recommended
cryptographic signature standards. The signature SHALL be validated by
the relying party. The X.509 certificate used for signatures by the
Verifier SHALL be issued by a trusted certificate service provider
according to ZertES; SR 943.03 and listed by the Swiss Accreditation
Service (SAS).

### Identity Token

The Identity Token SHALL be used by the Verifier to convey the Subject
Identifier to the Relying Party. The Identity Token SHALL be compliant
with the JSON Web Token and OpenID Connect Core 1.0 specification
(see fn. 20).

Identity Tokens SHALL be cryptographically signed using JSON Web
Signature (see fn. 22) and the Relying Party SHALL validate the
signature. The X.509 certificate used for signatures by the Verifier
SHALL be issued by a trusted certificate service provider according to
ZertES; SR 943.03 and listed by the Swiss Accreditation Service (SAS).

The Identity Token SHALL contain the following parameters:
- *iss*: The value SHALL be a unique identifier of the Issuer
Credential Service Provider as URL.
- *sub*: The Subject Identifier of the Claimant/Subscriber.
- *aud*: The value SHALL be the Client Identifier the Relying Party
is registered at the Verifier.
- *exp*: The time restricting the lifetime of the token lifetime.
The value SHALL be equal to the current time plus 5 minutes.
- *iat*: The time the token was issued by the Verifier.
- *nonce*: The value SHALL match the *nonce* value of the
Authentication Request.
- *jti*: The value shall be a unique identifier of the ID Token.

The Subject Identifier attribute SHALL be persistent and SHALL be unique
for the combination of the Subscriber, the Community and the Identity
Provider to reduce the risk ofcross application identification. The
Subject Identifier SHALL be confidential and never presented to the
Claimant or third party systems.

The Identity Token MAY contain a session identifier in a *sid*
attribute, if the Identity Provider supports per session logout.

The Identity Token MAY contain other claims which SHALL be ignored by
the Relying Party.

The Relying Parties SHALL validate Identity Tokens as follows:

1. Verify that the unique identifier of the Issuer matches the one
registered for the Verifier. 
2. Verify that the value of the *aud* parameter matches the Client
Identifier of the Relying Party. 
3. Validate the signature according to JSON Web Signature (see fn. 22)
using the algorithm specified in the JWT *alg* Header Parameter. 
4. Verify that the signature algorithm matches the algorithm configured
for the Verifier. 
5. Verify that the Identity Token is not expired and the current time
is later or equal to the time the token was issued by the Verifier. 
6. Verify that a *nonce* claim is present and its value matches the one
that was sent in the Authentication Request.

### UserInfo Request

The UserInfo Request message SHALL be used by the Relying Party to
retrieve identity data of the Claimant/Subscriber from the Credential
Service Provider via the backchannel. The UserInfo Request message SHALL
be compliant to the OpenID Connect 1.0 UserInfo Request message.

Relying Parties which fulfill the requirements of confidential clients
(see fn. 21) SHALL sign the UserInfo Request message using JSON Web
Signature (see fn. 22). The signature SHALL be asymmetric using X.509
certificates issued by a managed Certificate Authority (CA) that is
operated according to documented processes detailed in a Certificate
Policy (CP) and Certificate Practice Statement (CPS). The CA\'s
processes should meet the requirements of class 1 certificates defined
within the eCH-0048 PKI Certificate Classes standard (Version 2.0).

The Relying Party SHALL send the Access Token in the HTTP Authorization
header field as Bearer Token as defined in The OAuth 2.0 Authorization
Framework: Bearer Token Usage.

The Credential Service Provider SHALL validate the User Info Request as
follows:
1. Validate the signature according to JSON Web Signature (see fn. 22)
using the algorithm specified in the JWT *alg* Header Parameter. 
2. Verify that the signature algorithm matches the algorithm configured
for the Relying Party at the Credential Service Provider.

### UserInfo Response

The UserInfo Response message SHALL be used by the Credential Service
Provider to respond with the identity data of the Claimant/Subscriber to
UserInfo Requests from the Relying Party using back-channel
communication. The UserInfo Response message SHALL be a JSON Web Token
(JWT) compliant to the OpenID Connect 1.0 UserInfo Response message.

The UserInfo Response SHALL contain the following parameters:
- *first_name*: The first name of the Claimant/Subscriber.
- *family_name*: The family name of the Claimant/Subscriber.
- *gender*: The Claimants/Subscribers coded gender with the value
from the value set EprGender (2.16.756.5.30.1.127.3.10.1.25).
- *birthdate*: The Claimants/Subscribers date of birth as ISO
8601-1:2019 formatted string.

If the Identity Provider delivers the GLN of healthcare professionals or
assistants, the UserInfo Response SHALL contain a *gln* parameter
conveying the GLN of healthcare professionals and assistants.

Credential Service Provider MAY provide other identity claims as defined
in the OpenID Connect 1.0 Core specification (see fn. 20).

In case of an error the Credential Service Provider SHALL respond a HTTP
Error as defined in Section 5.3.3 of the OpenID Connect Core 1.0
specification (see fn. 2020).

The UserInfo response message SHALL be signed using recommended
cryptographic signature standards. The signature SHALL be validated by
the relying party. The X.509 certificate used for signatures by the
Verifier SHALL be issued by a trusted certificate service provider
according to ZertES; SR 943.03 and listed by the Swiss Accreditation
Service (SAS).

### Logout Request

The *LogoutRequest* message SHALL be used by the Relying Party to
notify the Verifier that a Claimant/Subscriber logged out in the Relying
Party application.

*LogoutRequest* messages send by the Relying Party to the Verifier
SHALL be compliant with the OpenID Connect RP-Initiated Logout 1.0
specification with the requirements defined in this section.

*LogoutRequest* messages SHALL contain a JWT with the following parameters:
- *id_token_hint*: SHALL convey the Identity Token previously issued
by the Verifier.
- *state*: SHALL convey an opaque value used to maintain the state
between the request and the response to mitigate Cross-Site Forgery
attacks.

The JWT MAY contain other claims which SHALL be ignored by the Verifier.

Relying Parties which fulfill the requirements of confidential clients
(see fn. 21) SHALL sign the *LogoutRequest* message using JSON Web
Signature (see fn. 22). The signature SHALL be asymmetric using X.509
certificates issued by a managed Certificate Authority (CA) that is
operated according to documented processes detailed in a Certificate
Policy (CP) and Certificate Practice Statement (CPS). The CA\'s
processes should meet the requirements of class 1 certificates defined
within the eCH-0048 PKI Certificate Classes standard (Version 2.0).

The Verifier SHALL validate *LogoutRequest* messages as follows:
1. Verify that the Identity Token was issued by the Verifier for the
requesting client and user. 
2. Verify the signature of the Request Message, if the Relying Party
was registered as confidential client. 
3. The JWT MAY contain other claims which SHALL be ignored by the Relying
Party. 

The Relying Party SHALL validate *LogoutRequest* messages as follows:
1. Verify that the unique identifier of the Issuer matches the one
registered for the Verifier. 
2. Verify that the value of the aud parameter matches the Client
Identifier of the Relying Party. 
3. Validate the signature according to JSON Web Signature (see fn. 22)
using the algorithm specified in the JWT alg Header Parameter. 
4. Verify that the current time is later or equal to the time the the
Logout Request was issued by the Verifier.

Relying Parties SHALL sign the *LogoutRequest* message using X.509
certificates issued by a managed Certificate Authority (CA) that is
operated according to documented processes detailed in a Certificate
Policy (CP) and a Certificate Practice Statement (CSP). The CA's process
should meet the requirements of class 1 certificates defined within the
eCH-0048 PKI Certificate Classes standard (Version 2.0).

Verifiers SHALL validate the signature of *LogoutRequest* messages.

### Logout Response

The *LogoutResponse* message SHALL be send by the Verifier to the
Relying Party to confirm session termination.

The *LogoutResponse* message SHALL be compliant with Logout Response
message defined in the OpenID Connect back-channel Logout specification
(see fn. 20) with the requirements defined in this section.

The *LogoutResponse* message SHALL be signed using recommended
cryptographic signature standards. The X.509 certificate used for
signatures by the Verifier SHALL be issued by a trusted certificate
service provider according to ZertES; SR 943.03 and listed by the Swiss
Accreditation Service (SAS).

Relying Parties SHALL validate the signature of *LogoutResponse*
messages.

