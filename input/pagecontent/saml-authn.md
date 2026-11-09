### Scope

This national extension defines restrictions and extensions to the
[SAML 2.0](https://docs.oasis-open.org/security/saml/Post2.0/sstc-saml-tech-overview-2.0.html) 
Artifact Binding with Artifact Resolution Protocol via SOAP back-channel to retrieve 
an EPR-compliant identity token used to identify and authenticate users.

Verifier SHALL provide trusted endpoints for Relying Parties implementing the SAML 2.0 Artifact Binding with Artifact
Resolution Protocol via SOAP back-channel fulfilling the requirements defined in this section.

### Definition of terms

Relying Party - A Relying Party is understood as any actor that relies on an identity claim provided
by an Identity Provider for user authentication. In the context of the EPR, Relying Parties are in
particular medical information systems and portals for patients and healthcare professionals, which
access data and documents from the EPR.

Identity Provider - The term Identity Provider is used for legal entities that manage the
user's primary authentication credentials and issues authenticators and assertions derived from
those credentials. Identity Providers typically operate a Verifier and a Credential Service Provider,
but may delegate the services to other providers on a contractual basis.

Verifier - The term Verifier is used for an actor that corroborates identity information by verifying the
user's identity and by verifying the user's possession and control of authenticators using an authentication
protocol.

Credential Service Provider - The term Credential Service Provider is used for actors that register,
verify and provide assertion attributes of users. A Credential Service Provider typically
operates Registration and Local Registration Authorities, but may delegate the services to other
providers on a contractual basis.

Certificate Authority - Identity Provider MAY operate a managed Certificate Authority (CA) that is
operated according to documented processes detailed in a Certificate Policy (CP) and Certification Practice
Statement (CPS). The CA's processes SHALL meet the requirements of class 1 certificates defined within
the [eCH-0048 PKI Certificate Classes standard Version 2.0](https://www.ech.ch/de/ech/ech-0048/2.0). The Identity Provider MAY
use this Certificate Authority to issue client certificates (mTLS) for Relying Parties. Identity Providers
MAY delegate the service to another provider on a contractual basis.

### Referenced Standards

- [SAML 2.0](https://docs.oasis-open.org/security/saml/Post2.0/sstc-saml-tech-overview-2.0.html), March 2008.
- [eCH-0048 PKI Certificate Classes standard Version 2.0](https://www.ech.ch/de/ech/ech-0048/2.0), November 2018.
- [WS-Trust 1.3, A framework for requesting and issuing security tokens](https://docs.oasis-open.org/ws-sx/ws-trust/200512/ws-trust-1.3-os.html),  March 2007
- [Assertions and Protocols for the OASIS Security Assertion Markup Language (SAML) V2.0](), March 2005:

  [^2]: [Assertions and Protocols for the OASIS Security Assertion Markup Language (SAML) V2.0](), March
  2005: [saml-core-2.0-os].
  [^3]: Profiles for the OASIS Security Assertion Markup Language (SAML) V2.0, March 2005: [saml-profiles-2.0-os].
  [^4]: OASIS Web Services Security: SOAP Message Security 1.1, February 2006.

### Sequences

#### User Authentication

<div style="width: 80%;">
{% include SAML-Artifact-flow.svg %}
</div>

Figure 1: Authentication-Sequence with SAML 2 Artifact Binding

| SEQ   | Description                                                                                                                                                                                                                                                                                                                                               |
|-------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 01,02 | The Claimant’s user agent attempts to access a resource on the relying party.                                                                                                                                                                                                                                                                             |
| 03    | The Relying Party presents the list of supported Verifiers to the Claimant.                                                                                                                                                                                                                                                                               |
| 04,05 | The Claimant selects a Verifier.                                                                                                                                                                                                                                                                                                                          |
| 06,07 | The Relying Party sends an HTML form back to the browser in the HTTP response (HTTP status 200). The HTML form contains a SAML `<AuthnRequest>` message encoded as the value of a hidden form control named SAMLRequest.                                                                                                                                  |
| 08    | The Verifier determines whether the Claimant has an existing logon security context that meets the default or requested authentication policy requirements. If not, the Verifier interacts with the browser to challenge the Claimant to provide valid credentials.                                                                                       |
| 09…11 | The Verifier communicates with the Authenticator(s) to authenticate the Claimant. The Claimant provides valid credentials and the Verifier creates a local logon security context for the Claimant.                                                                                                                                                       |
| 12,13 | The Verifier creates an artifact containing the source ID for the relying party site and a reference to the `<Response>` message (the MessageHandle). The HTTP Artifact binding allows the choice of either HTTP redirection or an HTML form POST as the mechanism to deliver the artifact to the relying party. The figure shows the use of redirection. |
| 14    | The Relying Party determines the SAML requester by examining the artifact (the exact process depends on the type of artifact) and issues and send a `<ArtifactResolve>` request containing the artifact to the Verifier. This exchange is performed using a synchronous SOAP message exchange over the back-channel.                                      |
| 15,16 | The Verifier extracts the MessageHandle from the artifact and requests the assertion or assertion attributes message associated with the artifact.                                                                                                                                                                                                        |
| 17    | The Verifier returns the assertion with a SAML `<ArtifactResponse>` message as SOAP message via the back-channel to the Relying Party.                                                                                                                                                                                                                    |
| 18…21 | The Relying Party verifies the identity assertion retrieved with the `<ArtifactResponse>`. If the assertion is valid and the Claimant is authenticated, the Relying Party returns the requested resource to the Claimant’s user agent.                                                                                                                    |

Table 3: Authentication-Sequence with SAML 2 Artifact Binding

Relying Parties MAY renew SAML Identity Assertions for the duration of the Verifier’s idle time of 2 hours after the
assertion lifetime has expired without requiring a new authentication of the Claimant. To fulfill this requirement, the
Verifier SHALL publish a web service endpoint, which implements a Security Token Service as defined in the WS-Security
Standard[^1].

#### Renew

<div style="width: 80%;">
{% include SAML-Renew.svg %}
</div>

Figure 2: Renewal of a SAML-Assertion

| SEQ | Description                                                                                                                                                                                                                                   |
|-----|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 01  | The Relying Party uses the Identity Assertion of the Claimant in a `<RequestSecurityToken>` request as defined to the WS-Security Standard and sends it to the Verifier as SOAP version 1.1 request via the back-channel.                     |
| 02  | The Verifier validates the signature of the request and the signature of the assertion conveyed in the request.                                                                                                                               |
| 03  | The Verifier generates a new SAML Identity Assertion with a new expiration semantics according to chapter 6.3.                                                                                                                                |
| 04  | The Verifier embeds the generated SAML Identity Assertion in the `<RequestSecurityTokenResponse>` according to the WS-Security Standard. Subsequently the Verifier sends this token as SOAP version 1.1 response message via the backchannel. |

Table 4: Renewal of a SAML-Response-Assertion with new expiration semantics

#### Logout

<div style="width: 80%;">
{% include SAML-Logout.svg %}
</div>

Figure 3: SAML 2.0 Logout Sequence

| SEQ   | Description                                                                                                                                                                                                |
|-------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 01    | The Claimant initiates a logout in the user agent of the Relying Party application. The Relying Party sends a SAML 2 `<LogoutRequest>` message to the Verifier using the SAML 2 http POST or SOAP Binding. |
| 02,03 | The Verifier terminates the session and responds to the initial `<LogoutRequest>` with a `<LogoutResponse>` using the SAML 2 http POST or SOAP Binding.                                                    |
| 04    | The Relying Party terminates the user session.                                                                                                                                                             |

Table 5: SSO Logout Sequence

The following requirements are based upon SAML Profiles 2.0[^2] Chapter 4.4 and are customized for the Swiss EPR.

The `<LogoutRequest>` and `<LogoutResponse>` transactions SHALL be protected to prevent attackers from unauthorized use.
Verifier and Relying Parties shall fulfill the following requirements:

- Relying Parties SHALL cryptographically sign the `<LogoutRequest>` messages and the Verifier SHALL validate the
  signature with the public key of a pre-registered X.509 certificate.

- The X.509 certificate used by Relying Parties for signatures of the `<LogoutRequest>` message SHALL be issued by a
  managed Certificate Authority (CA) that is operated according to documented processes detailed in a Certificate Policy
  (CP) and Certificate Practice Statement (CPS). The CA's processes should meet the requirements of class 1 certificates
  defined within the eCH-0048 PKI Certificate Classes standard (Version 2.0).

### Protocol Requirements

#### Front-channel Communication

The User Agent and the Verifier SHALL communicate through an authenticated protected channel using TLS 1.2 or higher.
The User Agent can either authenticate itself with TLS Client authentication or using digital signature mechanisms on a
message level.

The Verifier SHALL identify and authenticate itself with X.509 certificates which are issued by a trusted certificate
service provider according to ZertES; SR 943.03 and listed by the Swiss Accreditation Service (SAS).

Relying Parties and Authenticators which communicate with the Verifier through an intermediary user agent SHALL use
digital signatures for message level authentication. The X.509 certificates used for signatures SHALL be issued by a
managed Certificate Authority (CA) that is operated according to documented processes detailed in a Certificate Policy
(CP) and Certificate Practice Statement (CPS). The CA’s processes SHALL meet the requirements of class 1 certificates
defined within the eCH-0048 PKI Certificate Classes standard (Version 2.0).

#### Back-channel Communication

The Verifier SHALL communicate with Relying Parties through an authenticated and protected back-channel (e.g., IPsec,
TLS 1.2 or higher) for artefact resolution, token renew and logout. The Verifier SHALL identify and authenticate itself
with TLS authentication or, when sending logout requests with message level authentication using X.509 certificates
issued by a class 2 TLS certificate issued by a trusted certificate service provider according to ZertES; SR 943.03 and
listed by the Swiss Accreditation Service (SAS).

The Verifier SHALL NOT use redirects through an intermediary user agent (e.g., Web Browser) to communicate with Relying
Parties for artefact resolution, token renew and logout.

Relying Parties SHALL use message level authentication (e.g., digital signature) to identify and authenticate. Relying
Parties SHALL use X.509 certificates issued by a managed Certificate Authority (CA) that is operated according to
documented processes detailed in a Certificate Policy (CP) and Certificate Practice Statement (CPS) to identify and
authenticate themselves for artefact resolution, token renew and logout. The CA's processes SHALL meet the requirements
of class 1 certificates defined within the eCH-0048 PKI Certificate Classes standard (Version 2.0).

### Messages

#### Authentication Request

The `<AuthnRequest>` message SHALL be used by the Relying Party to initiate the authentication sequence.

The `<AuthnRequest>` message SHALL be cryptographically signed by the Relying Party and the Verifier SHALL validate the
signature. The signature SHALL be asymmetric using X.509 certificates issued by a managed Certificate Authority (CA)
that is operated according to documented processes detailed in a Certificate Policy (CP) and Certificate Practice
Statement (CPS). The CA's processes should meet the requirements of class 1 of the eCH-0048 PKI Certificate Classes
standard (Version 2.0).

The signature SHALL either be validated with the public key of a pre-registered X.509 certificate, or the embedded
certificate. If the public key of the embedded certificate is used, the Verifier SHALL verify, that the certificate
matches the pre-registered one.

#### Authentication Response

The Authentication Response message SHALL be used by the Verifier as response to the `<AuthnRequest>` message to convey
the artifact after authenticating the Claimant/Subscriber.

The Artifact conveyed with Authentication Response message SHALL

- Be for one-time-use only,

- Comply with saml-core-2.0-os chapter 3.5 (see fn.17),

- Comply with saml-profiles-2.0-os chapter 5[^3].

The *SourceID *of the Artifact SHALL be the crypthographic hash of the *entityID* declared in the metadata made
available by the Identity Provider. The crypthographic hash function SHALL be known to resist up to date attacks.

The Authentication response message SHALL be signed using recommended cryptographic signature standards. The signature
SHALL be validated by the relying party. The X.509 certificate used for signatures by the Verifier SHALL be issued by a
trusted certificate service provider according to ZertES; SR 943.03 and listed by the Swiss Accreditation Service (SAS).

#### Artifact Resolve

The `<ArtifactResolve>` message SHALL be used by the Relying Party to resolve the artifact received with the
`<AuthenticationRequest>` message to the SAML 2.0 Identity Assertion via the back-channel.

The `<ArtifactResolve>` message SHALL be cryptographically signed by the Relying Party and the Verifier SHALL validate
the signature. The signature SHALL be asymmetric using X.509 certificates issued by a managed Certificate Authority (CA)
that is operated according to documented processes detailed in a Certificate Policy (CP) and Certificate Practice
Statement (CPS). The CA's processes should meet the requirements of class 1 certificates defined within the eCH-0048 PKI
Certificate Classes standard (Version 2.0).

The signature SHALL either be validated with the public key of a pre-registered X.509 certificate, or the embedded
certificate embedded. If the public key of the embedded certificate is used, the Verifier SHALL verify, that the
certificate matches the pre-registered one.

#### Artifact Response

The `<ArtifactResponse>` message SHALL be used by the Verifier or Credential Service Provider to resolve the artifact
received with the `<ArtifactResolve>` message to the SAML 2.0 Identity Assertion.

The Artifact response message SHALL be signed using recommended cryptographic signature standards. The signature SHALL
be validated by the relying party. The X.509 certificate used for signatures by the Verifier SHALL be issued by a
trusted certificate service provider according to ZertES; SR 943.03 and listed by the Swiss Accreditation Service (SAS).

#### Assertion

The SAML 2.0 Assertion SHALL be used by the Verifier or Credential Service Provider to convey the identity data of an
authenticated Claimant/Subscriber to the requesting Relying Party.

The SAML 2.0 Assertion SHALL contain the following attributes:

- First name with attribute name *http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname.*

- Family name with attribute name http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname.

- Gender with attribute name *gender*.

- Date of birth with attribute name *dateofbirth*.

The attribute set MAY contain the GLN for healthcare professionals and assistants. If present, the GLN SHALL be
contained in an `<Attribute>` element with the *Name* attribute set to "GLN".

The `<NameID>` in the SAML 2.0 Assertion SHALL be persistent and SHALL be unique for the combination of the Subscriber,
the Community and the Identity Provider to reduce the risk of cross application identification. The `<NameID>` SHALL be
confidential and never presented to the Claimant, the User Agent or third party systems.

The SAML 2.0 Assertions SHALL include a `<SessionIndex>` as element of the `<AuthenticationStatement>` to enable per
session logout requests as defined in Section 4.1.4.2 of the SAML Profiles 2.0 specification (see fn. 18).

SAML 2.0 Assertions SHALL only be considered as valid within the time limits specified in the `<NotBefore>` and
`<NotOnOrAfter>` attributes. Assertions SHALL expire 5 minutes after the assertion has been issued.

The data types used in SAML 2.0 Assertions SHALL be according to W3C XML Schema 1.0.

SAML 2.0 Assertions SHOULD use audience restriction techniques to allow a Relying Party to recognize whether or not it
is the intended target of an issued assertion.

The SAML 2.0 Assertions SHALL be cryptographically signed and the Relying Party SHALL validate the signature. The
signature SHALL be asymmetric using X.509 certificates issued by a trusted certificate service provider according to
ZertES; SR 943.03 and listed by the Swiss Accreditation Service (SAS).

#### Renew Request

Relying Parties MAY renew SAML Identity Assertions for the duration of the Verifier idle time after the assertion
lifetime has expired without requiring a new authentication of the Claimant. To fulfill this requirement, the Verifier
SHALL publish a web service compliant with the Web Services Trust standard (see fn. 16).

Relying Parties SHALL use an Identity Assertion of the Claimant in a `<RequestSecurityToken>` request as defined to the
Web Services Security standard[^4] and send it to the Verifier as SOAP version 1.1 request via the back-channel.

The Web Service security header of the SOAP envelope SHALL contain a security timestamp element as described in chapter
10 of the Web Services Security specification (see fn. 19). The security timestamp element SHALL be covered by the XML
signature.

The security timestamp element SHALL contain a `<Created>` element whose value SHALL be the instant that the renew
request is serialized for transmission as described in chapter 10 of the Web Services Security specification (see fn.
19). The security timestamp element SHALL contain an `<Expires>` element as described in chapter 10 of the Web Services
Security specification (see fn. 19).

The Web Service security header of the SOAP envelope SHALL contain a binary token element as described in chapter 6.3 of
the Web Services Security specification (see fn. 19). The binary token element SHALL have an encoding type attribute set
to EncodingType="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary". The
binary token element SHALL have a value type attribute set to
ValueType="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-x509-token-profile-1.0#X509v3". The binary token
element MAY have an `<Id>` attribute.

The Renew Request SHALL be cryptographically signed and the Verifier SHALL validate the signature. The signature SHALL
be asymmetric using X.509 certificates issued by a managed Certificate Authority (CA) that is operated according to
documented processes detailed in a Certificate Policy (CP) and Certificate Practice Statement (CPS). The CA's processes
should meet the requirements of class 1 certificates defined within the eCH-0048 PKI certificate classes standard
(Version 2.0).

The Web Service security header of the SOAP envelope SHALL contain a signature element compliant to the XML signature
specification and described in chapter 8 of the Web Service Security specification (see fn. 19). The signature method
element SHALL reference a digest algorithm known to resist up to date attacks. The signature element SHALL contain a key
info element with one child element conveying a security token reference conformal to the XML signature specification
and described in chapter 7 of the Web Service Security specification (see fn. 19). The security token reference element
SHALL convey the issuer name and serial number to identify the certificate. The SOAP body element of the request SHALL
have an `<Id>` attribute which is referenced in the key info element of the SOAP security header as described above.

The Verifier SHALL

- Validate the signature of the request.

- Verify the request timestamp, discard any message whose security semantics have passed their expiration and respond
  with a fault code (`<MessageExpired>`).

- Verify the digest algorithm used with the request. The Verifier SHALL NOT accept deprecated digest algorithms, which
  do not resit up to date attacks.

- Validate the signature of the previous Identity Assertion conveyed with the `<RequestSecurityToken>` request.

#### Renew Response

The Renew Response message SHALL be used by the Verifier or Credential Service Provider to convey an updated SAML
Identity Assertion in the `<RequestSecurityTokenResponse>` according to the WS-Security Standard (see fn.19) using SOAP
version 1.1.

The Renew response message SHALL be signed using recommended cryptographic signature standards. The signature SHALL be
validated by the relying party. The X.509 certificate used for signatures by the Verifier SHALL be issued by a trusted
certificate service provider according to ZertES; SR 943.03 and listed by the Swiss Accreditation Service (SAS).

#### Logout Request

The `<LogoutRequest>` message SHALL be used by the Relying Party to notify the Verifier that a Claimant/Subscriber
logged out in the Relying Party application.

SAML `<LogoutRequest>` messages SHALL include at least one `<SessionIndex>` as defined in Section 4.4.3.1 of the SAML
Profiles 2.0 specification.

The `<LogoutRequest>` message SHALL be cryptographically signed by the sender and the receiver SHALL validate the
signature. The signature SHALL either be validated with the public key of a pre-registered X.509 certificate, or the
embedded certificate. If the public key of the embedded certificate is used, the Verifier SHALL verify, that the
certificate matches the pre-registered one. The X.509-certificates used for signatures SHALL be issued by a managed
Certificate Authority (CA) that is operated according to documented processes detailed in a Certificate Policy (CP) and
Certificate Practice Statement (CPS). The CA's processes should meet the requirements of class 1 certificates defined
within the eCH-0048 PKI Certificate Classes standard (Version 2.0).

Relying Parties SHALL sign `<LogoutRequest>` messages using X.509 certificates issued by a managed Certificate Authority
(CA) that is operated according to documented processes detailed in a Certificate Policy (CP) and a Certificate Practice
Statement (CSP). The CA’s process should meet the requirements of class 1 certificates defined within the eCH-0048 PKI
Certificate Classes standard (Version 2.0).

Verifier SHALL validate the signature of `<LogoutRequest>` messages.

#### Logout Response

The `<LogoutResponse>` message SHALL be used by the Verifier to confirm session termination to the initiating Relying
Party.

Verifier SHALL sign `<LogoutResponse>` messages. The X.509 certificate used for signatures by the Verifier SHALL meet
recommended cryptographic standards and must follow certificate lifecycle best practices detailed in a certificate
policy and certificate practice statement.

Verifier SHALL verify the signature of `<LogoutResponse>` messages.