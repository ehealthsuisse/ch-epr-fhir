This section describes the national extension for the Health Dossier to the [Get Access Token [ITI-71]](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71) client credential 
grant type transaction defined in the IUA profile published in the IHE IT Infrastructure Technical Framework Trial 
Implementation “Internet User Authorization”.

### Scope

The transaction is used by an IUA Authorization Client (e.g., portal, primary system or digital health app 
to pass claims to the IUA Authorization Server and to retrieve an access token which authorizes access to protected
resources of the Health Dossier.

Depending on the claims made by the IUA Authorization Client, two different flavors of access tokens SHALL be provided
by the IUA Authorization Server:

- Basic Access Token – IUA compliant access token authorizing access to the EPR end-points which are NOT protected by
  the EPR role and attribute based authorization (e.g., for queries to the PDQm endpoints).
- Extended Access Token – IUA compliant access token for the EPR endpoints which are protected by the EPR role and
  attribute based authorization (e.g., for the MHD endpoints).

### Actor Roles

**Actor:** IUA Authorization Client  
**Role:** Communicates claims and optional IdP Token to the IUA Authorization Server and receives JWT access token.      
**Actor:** IUA Authorization Server  
**Role:** Identifies and authenticates the IUA Authorization Client, verifies signatures and claims, authorizes the access 
on behalf of the user and responds a JWT Access Token to the IUA Authorization Client
to be incorporated into the transactions to access protected resources.

### Referenced Standards

1. [IHE ITI Technical Framework Supplement Internet User Authorization (IUA) Revision 2.5](https://profiles.ihe.net/ITI/IUA/index.html)
2. [SMART Application Launch Framework Implementation Guide Release 2.2.0](http://www.hl7.org/fhir/smart-app-launch/)
3. [OpenID Connect Core 1.0 incorporating errata set 2](https://openid.net/specs/openid-connect-core-1_0.html)
4. [RFC 9421: HTTP Message Signatures](https://www.rfc-editor.org/info/rfc9421/).


### Messages

This section specifies the national extensions for the client credential grant flow of the IUA Get Access Token 
[ITI-71] transaction.

<div>{% include IUA_ActorDiagram_ITI-71-cc.svg %}</div>
<figcaption ID="10">Figure: Sequence diagram of the transaction.</figcaption>

<br/>

| Step | Action                                                                                                   | Remark                      | 
|------|----------------------------------------------------------------------------------------------------------|-----------------------------|
| 00   | The IUA Authorization Client sends an Get Access Token Request to the IUA Authorization Server endpoint. | See [Message Semantics](#message-semantics) | 
| 01   | The IUA Authorization Server responds with the access token in the HTML body element.                    | See [Message Semantics](#message-semantics-1)|
{:class="table table-bordered"}

<figcaption ID="11">Table: Actions in the HTTP sequence of the transaction.</figcaption>

<br/>

#### Get Access Token Request

##### Trigger Events

A clinical archive system aims to access the EPR to write documents, or a user authenticates in the portal, primary 
system or in a digital health app to access data and Documents in the EPR. 

##### Message Semantics

The IUA Authorization Client SHALL send an IUA compliant OAuth 2.1 Token Request for the client credential grant
type with Swiss extensions:
- grant_type (required): The value of the parameter shall be `client_credentials`.
- client_id (required): The ID the IUA Authorization Client is registered at the IUA Authorization Server.
- scope (required): The scope claimed by the IUA Authorization Client, as defined in the table below.
- resource (optional): Single valued identifier of the IUA Resource Server API endpoint to be accessed.
- requested_token_type (optional): If present, the value shall be `urn:ietf:params:oauth:token-type:jwt`.
<br/>

The Token Request SHALL use the following extension defined in the client-confidential-asymmetric authentication profile
of the [FHIR Backend Service](https://hl7.org/fhir/smart-app-launch/backend-services.html#backend-services) specification. 
- client_assertion_type (required): The value shall be `urn:ietf:params:oauth:client-assertion-type:jwt-bearer`.
- client_assertion (required): JWT as defined in [SMART App Launch, Client Authentication](https://hl7.org/fhir/smart-app-launch/client-confidential-asymmetric.html#client-authentication-asymmetric-public-key).
<br/>

The Token Request SHALL use the following Swiss extension:
- person_id (optional/required): EPR-SPID identifier of the patient’s record and the patient assigning authority formatted in CX syntax, required for requesting extended access token.
- principal (optional/required): The name of the healthcare professional an assistant or a clinical archive system may act on behalf of.
- principal_id (optional/required): The GLN of the healthcare professional an assistant or a clinical archive system may act on behalf of.
- group (optional): The name of the organization or group a healthcare professional or assistant may act on behalf of.
- group_id (optional): The OID of the organization or group a healthcare professional or assistant is acting on behalf of.
- id_token (optional/required): Signed JWT associated with the current user's authenticated session at the Identity Provider,
  the [Identity Token](openid-connect.html#identity-token) as specified in [OpenID Connect](openid-connect.html). 
<br/>

The scope parameter of the request MAY claim the following attributes:

- There SHALL be a scope with name `purpose_of_use` in FHIR [token format](https://www.hl7.org/fhir/search.html#token)). 
  The token SHALL convey the coded value of the current transaction’s purpose of use. Allowed values are `NORM` (normal access), 
  `EMER` (emergency access) from code system `2.16.756.5.30.1.127.3.10.5` of the CH:EPR value set 
  (e.g.: `purpose_of_use=urn:oid:2.16.756.5.30.1.127.3.10.5|NORM`).
- There SHALL be a scope with name `subject_role` in FHIR [token format](https://www.hl7.org/fhir/search.html#token)). 
  The token SHALL convey the coded value of the subject’s role. Allowed values are `PAT` (patient), `REP` (representative),
  `LEGREP` (legal representative), `HCP` (healthcare professional), `ASS` (assistant), `TCU` (technical user, clinical
  archive) or `ADM` (administration) from the code system [CH Health Dossier Role](CodeSystem-HealthDossierRole.html)
  `2.16.756.5.30.1.127.3.10.19` (e.g.: `subject_role=urn:oid:2.16.756.5.30.1.127.3.10.19|HCP`).
- IUA Authorization Clients may claim other scopes as defined in the 
  [SMART on FHIR specification](https://www.hl7.org/fhir/smart-app-launch/scopes-and-launch-context.html).

Note: The parameters need to be url encoded, see message examples.

##### Expected Actions

The IUA Authorization Server SHALL validate the claims as described in the following sections. If the validation 
succeeds, the IUA Authorization Server SHALL respond with the [Token Response](#get-access-token-response) 
defined below. In case the validation fails, the IUA Authorization Server SHALL respond with HTTP 401 Unauthorized or 
HTTP 403 Forbidden error.

When receiving a Token Request, the IUA Authorization Server SHALL: 
- verify the http message signature as specified in [RFC 9421: HTTP Message Signatures](https://www.rfc-editor.org/info/rfc9421/).
- verify the client authentication JWK as described in [SMART App launch Client Authentication](https://hl7.org/fhir/smart-app-launch/client-confidential-asymmetric.html#signature-verification).
- verify, that the IUA Authorization Client was registered during onboarding with the `client_id`.

###### Patients
When receiving a Token Request with `subject_role` set to `PAT`, the IUA Authorization Server SHALL:
- validate the identity token send in the `id_token` claim as described in 
  OpenID Connect [ID token validation](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation).
- verify that the identity token is signed by one of the identity provider accepted for the EPR.
- read the subject identifier `sub` of the id token and resolve it to the SPID of the patient.

###### Representatives
When receiving a Token Request with `subject_role` set to `REP` or `LEGREP`, the IUA Authorization Server SHALL:
- validate the identity token send in the `id_token` claim as described in
  OpenID Connect [ID token validation](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation).
- verify that the identity token is signed by one of the identity provider accepted for the EPR.
- read the subject identifier `sub` of the id token and resolve it to the ID of the representative.

###### Healthcare Professionals 
When receiving a Token Request with `subject_role` set to `HCP`, the IUA Authorization Server SHALL: 
- validate the identity token send in the `id_token` claim as described in
  OpenID Connect [ID token validation](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation).
- verify that the identity token is signed by one of the identity provider accepted for the EPR.
- If the `id_token` contains the GLN of the healthcare professional, read the GLN from the `id_token`. 
  Otherwise, read the subject identifier `sub` of the id token and resolve it to the GLN of the healthcare professional. 
- verify the healthcare professional is registered with the same GLN in the provider directory. 
- query the provider directory and resolve the GLN of the healthcare professional to all groups or institutions 
  including all superior groups or institutions up to the root level.

###### Assistants
When receiving a Token Request with `subject_role` set to `ASS`, the IUA Authorization Server SHALL:
- validate the identity token send in the `id_token` claim as described in
  OpenID Connect [ID token validation](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation).
- verify that the identity token is signed by one of the identity provider accepted for the EPR.
- If the `id_token` contains the GLN of the assistant, read the GLN from the `id_token`.
  Otherwise, read the subject identifier `sub` of the id token and resolve it to the GLN of the assistant.
- verify the assistant is registered with the same GLN in the provider directory.
- verify the assistant is authorized to act on behalf of the healthcare professional declared in the 
  `principal_id` claim.
- if a `group_id` claim is present, the Authorization Server SHALL verify that the healthcare 
  professional in the `principal_id` claim is a member of the group or institution claimed in the `group_id` attribute 
  of the request. If true, the Authorization Server SHALL resolve the claimed group or institution to all 
  superior groups and institutions up to the root level.
- if no `group_id` claim is present, the authorization server SHALL resolve the GLN of the healthcare 
  professional claimed in the `principal_id` to all groups or institutions the healthcare professional is member 
  of, including all superior groups or institutions up to the root level.

###### Clinical archive systems
When receiving a Token Request from a clinical archive system with `subject_role` set to `TCU`, the
IUA Authorization Server SHALL:
- verify that the system has been registered during onboarding as a clinical archive system with a principal.
- verify that the `principal_id` matches the GLN of the legal responsible person registered during onboarding.

###### Administrators 
When receiving a Token Request with `subject_role` set to `ADM`, the IUA Authorization Server SHALL:
- validate the identity token send in the `id_token` claim as described in
  OpenID Connect [ID token validation](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation).
- verify that the identity token is signed by one of the identity provider accepted for the EPR.
- read the subject identifier `sub` of the id token and resolve it to the ID of the administrator.
- verify the administrator is registered with the same ID in the provider directory.

##### Message Example

A token request of a patient send from a portal or digital health app may look like:

```
POST /token HTTP/1.1
Host: epr.auth-server.com
Content-Type: application/x-www-form-urlencoded
Content-length:313
Content-Digest:sha-512=:FmBZ...omitted for brevity...hO7g==:
Signature-Input:sig1=("@method" "@target-uri" "content-digest");created=1764073861;expires=1764073921;keyid="ec-signing-key";tag="fapi-2-request"
Signature:sig1=:FTUm8...omitted for brevity...KEsOw==:

grant_type=client_credentials
&client_id=<client_id>
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion=<signed JWT>
&scope=purpose_of_use=urn:oid:2.16.756.5.30.1.127.3.10.5|NORM subject_role=urn:oid:2.16.756.5.30.1.127.3.10.19|PAT
&id_token=<signed identity token>
```

A token request of a healthcare professional for an extended access token may look like:

```
POST /token HTTP/1.1
Host: epr.auth-server.com
Content-Type: application/x-www-form-urlencoded
Content-length:376
Content-Digest:sha-512=:FmBZ...omitted for brevity...hO7g==:
Signature-Input:sig1=("@method" "@target-uri" "content-digest");created=1764073861;expires=1764073921;keyid="ec-signing-key";tag="fapi-2-request"
Signature:sig1=:FTUm8...omitted for brevity...KEsOw==:

grant_type=client_credentials
&client_id=<client_id>
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion=<signed JWT>
&id_token=<signed identity token>
&scope=purpose_of_use=urn:oid:2.16.756.5.30.1.127.3.10.5|NORM subject_role=urn:oid:2.16.756.5.30.1.127.3.10.19|HCP
&person_id=761337610411353650^^^&2.16.756.5.30.1.127.3.10.3&ISO 
```

A token request of a clinical archive system for an extended access token may look like:

```
POST /token HTTP/1.1
Host: epr.auth-server.com
Content-Type: application/x-www-form-urlencoded
Content-length:340
Content-Digest:sha-512=:FmBZ...omitted for brevity...hO7g==:
Signature-Input:sig1=("@method" "@target-uri" "content-digest");created=1764073861;expires=1764073921;keyid="ec-signing-key";tag="fapi-2-request"
Signature:sig1=:FTUm8...omitted for brevity...KEsOw==:

grant_type=client_credentials
&client_id=<client_id>
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion=<signed JWT>
&principal=<the-principal-name>
&principal_id=<the-principal-id>
&scope=purpose_of_use=urn:oid:2.16.756.5.30.1.127.3.10.5|NORM subject_role=urn:oid:2.16.756.5.30.1.127.3.10.19|TCU
&person_id=761337610411353650^^^&2.16.756.5.30.1.127.3.10.3&ISO
```


#### Get Access Token Response

##### Message Semantics

The response SHALL either convey a Basic Access Token in JWT format which grants basic access to the EPR (i.e., to
access patient demographic data), or an Extended Access Token to access resources protected by the role and attribute based EPR
authorization (i.e., read and write documents).

###### JSON Web Token Option

The IUA Authorization Server and IUA Resource Server SHALL support the IUA JWT extension with claims as defined in
the following table:

| JWT Claim (Extension)   | Optionality (Basic/ Extended)   | Remark                                                                    |
|-------------------------|---------------------------------|---------------------------------------------------------------------------|
| subject_name            | R/R                             | The username as text.                                                     | 
| subject_organization    | O/O                             | The name of the user’s organization or institution as text.               |
| subject_organization_id | O/O                             | The OID of the user’s organization in URN notation.                       |
| subject_role            | O/R                             | Code indicating the user role from the [CH Health Dossier Role](CodeSystem-HealthDossierRole.html) code system. |
| purpose_of_use          | O/R                             | Code indicating the purpose of use from the EPR Purpose Of Use Value Set. |
| person_id               | O/R                             | SHALL be the EPR-SPID of the patients EPR.                                |
{:class="table table-bordered"}

<figcaption id='jwttiua'>Table: Attributes of the IUA Get Access Token response in the ihe_iua extension.</figcaption>  

###### The JWT ch_epr extension

The IUA Authorization Server and IUA Resource Server SHALL support this extension to convey the user's EPR identifier
in the JWT access token of the Get Access Token Response. It's attributes are:

- user_id (required): The EPR subject identifier as defined in the table below.
- user_id_qualifier (required): The subject identifier qualifier as defined in the table below.

<br/>

| user role               | user_id  | user_id_qualifier                             |
|-------------------------|----------|-----------------------------------------------|
| Patient (`PAT`)                   | EPR-SPID | urn:e-health-suisse:2015:epr-spid             |
| Healthcare Professional (`HCP`)   | GLN      | urn:gs1:gln                                   |
| Assistant (`ASS`)                 | GLN      | urn:gs1:gln                                   |
| Representative (`REP`)            | IdP-ID   | urn:e-health-suisse:representative-id         |
| Legal Representative (`LEGREP`)   | IdP-ID   | urn:e-health-suisse:representative-id         |
| Administration (`ADM`)            | IdP-ID   | urn:e-health-suisse:administrator-id          |
{:class="table table-bordered"}

<figcaption>Table: user_id and user_id_qualifier of EPR user.</figcaption>

<br/>

###### The JWT ch_group extension

Groups are the objects used in the access management of the Health Dossier. Patients and representatives may assign access
rights to groups which typically are sub-organizations of the institutions, but may also cross institution boundaries,
e.g., a tumor board with healthcare professionals from more than one institution.

The IUA Authorization Server and IUA Resource Server SHALL support this extension in the JWT access token for a list of
groups
a subject of role healthcare professional is a member of. For users of role assistant, the groups SHALL be the groups of
the healthcare professional the assistant is acting on behalf of.

Groups SHALL be wrapped in an `extensions` object with key `ch_group` with a JSON array containing one JSON object
per group with the following attributes:

- id (required): The id of the group. Required for users of role healthcare professional and assistant.
  The id SHALL be an OID in the format of a URN.
- name (required): Name of the group. Required for users of role healthcare professional and assistant.
  The name SHALL be a string.

###### The JWT ch_delegation extension

Delegation is used in the access management of the Health Dossier to indicate that a user of role Assistant is acting on
behalf of a healthcare professional. The IUA Authorization Server and IUA Resource Server SHALL support this extension
in the JWT access token to identify the healthcare professional (principal) the assistant is acting on behalf of.

Principals SHALL be wrapped in an `extensions` object with key `ch_delegation` and a JSON value object with attributes:
- principal (optional) Name of the healthcare professional an assistant is acting on behalf of.
- principal_id (optional) GLN of the healthcare professional an assistant is acting on behalf of.

##### Expected Actions

The IUA Authorization Client SHALL use the access token as defined in the [IUA Incorporate Access Token](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72)
transaction, when performing requests to resources of the Health Dossier.

##### Message Example

A basic JWT access token returned by the IUA Authorization Server and to be used to retrieve patient data may look like:

```json
{
  "iss": "http://issuerAdress.ch",
  "sub": "UserId-bfe8a208-b9d0-4012-b2f5-168b949fc3cb",
  "aud": "http://ResourceServerURL.ch",
  "exp": 1587294580,
  "nbf": 1587294460,
  "iat": 1587294460,
  "jti": "c5436729-3f26-4dbf-abd3-2790dc7771a",
  "extensions": {
    "ihe_iua": {
      "subject_name": "Martina Musterarzt"
    },
    "ch_epr": {
      "user_id": "2000000090092",
      "user_id_qualifier": "urn:gs1:gln"
    }
  }
}
```

An extended JWT access token to be used to access patient documents SHALL have the additional attributes of
the `purpose_of_use`, `subject_role` and the EPR-SPID of the patient. It may look like:

```json
{
  "iss": "http://issuerAdress.ch",
  "sub": "UserId-bfe8a208-b9d0-4012-b2f5-168b949fc3cb",
  "aud": "http://mhdResourceServerURL.ch",
  "exp": 1587294580,
  "nbf": 1587294460,
  "iat": 1587294460,
  "jti": "c5436729-3f26-4dbf-abd3-2790dc7771a",
  "extensions": {
    "ihe_iua": {
      "subject_name": "Martina Musterarzt",
      "person_id": "761337610411353650^^^&2.16.756.5.30.1.127.3.10.3&ISO",
      "subject_role": {
        "system": "urn:oid:2.16.756.5.30.1.127.3.10.19",
        "code": "HCP"
      },
      "purpose_of_use": {
        "system": "urn:oid:2.16.756.5.30.1.127.3.10.5",
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

An extended JWT access token to be used to access by an assistant acting behalf of a healthcare professional for a
patient SHALL have the additional extension `ch_delegation`:

```json
{
  "iss": "http://issuerAdress.ch",
  "sub": "UserId-bfe8a208-b9d0-4012-b2f5-168b949fc3cb",
  "aud": "http://mhdResourceServerURL.ch",
  "exp": 1587294580,
  "nbf": 1587294460,
  "iat": 1587294460,
  "jti": "c5436729-3f26-4dbf-abd3-2790dc7771a",
  "extensions": {
    "ihe_iua": {
      "subject_name": "Dagmar Musterassistent",
      "person_id": "761337610411353650^^^&2.16.756.5.30.1.127.3.10.3&ISO",
      "subject_role": {
        "system": "urn:oid:2.16.756.5.30.1.127.3.10.19",
        "code": "ASS"
      },
      "purpose_of_use": {
        "system": "urn:oid:2.16.756.5.30.1.127.3.10.5",
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

IUA Authorization Clients, IUA Authorization Servers and IUA Resource Server actors SHALL support the JWS (signed)
alternative of the JWT token as specified in the IUA Trial Implementation. To ensure the authenticity and integrity,
the IUA Authorization Server SHALL sign the JWT token with its private key and IUA Resource Servers SHALL verify
the signature of the JWT token with the Authorization Server's public key. The JWE alternative SHALL not be used.

When receiving requests of transactions where the EPR-SPID is provided in the IUA token and in the transaction body,
the IUA Resource Servers SHALL verify that both have the same value.

The actors SHALL support the `traceparent` header handling, as defined in [Appendix: Trace Context](tracecontext.html).

#### Authenticity

To ensure the authenticity of the request, the IUA Authorization Server SHALL add a signed JWT to the request as defined in [SMART App Launch Client Authentication: Asymmetric](https://hl7.org/fhir/smart-app-launch/client-confidential-asymmetric.html#authenticating-to-the-token-endpoint).  
IUA Authorization Servers SHALL validate the client authentication JWT by verifying the signature and the claims.

#### Integrity

To ensure the integrity of token requests, IUA Authorization Clients SHALL sign requests to the
token endpoint of the IUA Authorization Server with the clients' private key as defined in
`RFC 9421 HTTP Message Signatures`. The signature SHALL cover the entire request content. The IUA Authorization Server 
SHALL verify the requests signature with the clients public key exchanged during the client registration process.

The requests signature SHALL cover the following components of the http message as defined in 
`RFC 9421 HTTP Message Signatures`:

- method (required): The http protocol name the value of it SHALL be `POST`.
- target-uri (required): The URI of the IUA Authorization server.
- content-digest (required): The digest of the http message as defined in `RFC 9530 Digest Fields`.
- created (required): Creation time as a UNIX timestamp value of type Integer.
- expires (required): Expiration time as a UNIX timestamp value of type Integer which SHALL be at max 60 seconds after
  the creation time.
- keyid (optional): The identifier for the key material as a String value.
- tag (optional): An application-specific tag for the signature as a String value which MAY be used to transfer
  additional information.

Token requests SHALL use a http header with name `Signature-Input` the value of it SHALL be one or more metadata
sets with a key uniquely identifying the message signatures within the HTTP message as defined in
`RFC 9421 HTTP Message Signatures`.

There SHALL be at least one signature metadata set created by the IUA Authorization Client, e.g.:

```
Signature-Input: sig1=("@method" "@target-uri" "content-digest");created=1764073861;expires=1764073921;keyid="snIZq-_NvzkKV-IdiM348BCz_RKdwmufnrPubsKKyio";tag="fapi-2-request"
```

Token requests SHALL use a http header with name `Signature` the value of it SHALL be one or more message signatures
generated from the signature context of the target message with a key which uniquely identify the message signature
as defined in RFC 9421 `HTTP Message Signatures`. There SHALL be at least one signature created by the
IUA Authorization Client, e.g.:

```
Signature: sig1=:9FaAZovdKmr9LVmwnzyfRED1ws1dX1mZLIgIPTOyBTNi0HkNoLxVipp8ZyGGx6+XP+7WVRh1wNQk9xjunHhZOw==:
```

Token requests SHALL use a http header with name `Content-Digest` the value of it SHALL be the content digest of the
request message with a key indicating the algorithm used as defined in `RFC 9530 Digest Fields`, e.g.:

```
Content-Digest: sha-512=:Lh6fzO9XALiY46o5xVyN9yZloKZ6pLJV0kz+VirU5b6rQd2ii7vrTt4gxe32HRuLtNYG2Kl7CnGwQjjDxQk4yA===:
```

IUA Authorization Server SHALL verify the signature of the token requests as specified in
`RFC 9421 HTTP Message Signatures`.

IUA Authorization Servers SHALL NOT implement any algorithm using a shared key (for example _HMAC_), and they SHALL
implement at least the algorithm `RSASSA-PKCS1-v1_5 Using SHA-256`.

#### Security Audit Considerations

There is no audit event required for this transaction.

### Additional notes

The authors of this specification are aware, that the authenticity of the Get Access Token Request is double-checked, 
first by validating the http signature of the request and second, when validating the signature of the client-asymmetric 
authentication JWT. While the http signature is required to ensure the integrity (i.e., to verify that the request is 
not tampered), the client-asymmetric authentication is kept to be compliant with the 
[FHIR Backend Service](https://hl7.org/fhir/smart-app-launch/backend-services.html) specification and all specifications
which rely upon (e.g., the specification for the [EU Health Data Space](https://hl7.eu/fhir/health-data-api/))