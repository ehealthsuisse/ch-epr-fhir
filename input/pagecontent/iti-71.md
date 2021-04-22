This section describes the national extension for the Swiss EPR to the Get Access Token [ITI-71] transaction defined in the IUA profile published in the IHE IT Infrastructure Technical Framework Trial Implementation “Internet User Authorization”. In this transaction, the OAuth Authorization Code grant type option is enforced for security reasons
### Scope

The transaction is used by an mHealth App to pass claims to the IUA Authorization Server and to retrieve access token to be used for authorization of the apps access to write data to and retrieve data from the Swiss EPR.  

Depending on the claims made by the mHealth App, two different flavors of access tokens are provid-ed by the IUA Authorization Server: 

- Basic Access Token – IUA conformal access token authorizing access to the EPR end-points which are NOT protected by the EPR role and attribute based authorization (i.e. for the CH:PIXm endpoints). 
- Extended Access Token – IUA conformal access token for the EPR endpoints which are protected by the EPR role and attribute based authorization (i.e. for the MHD endpoints).

An mHealth app in the SMART Standalone Launch sequence SHALL perform the transaction first to get basic access to the Swiss EPR. This requires user authentication as well as the user consent, al-lowing the mHealth app to access the Swiss EPR and perform transactions on behalf of the user. The IUA Authorization Server MAY present a User Interface for the user to authenticate and provide user consent, or by validating against data stored at app registration time.

Once the mHealth App is authorized, it may launch other embedded mHealth apps (or views) using the SMART EHR Launch Sequence. In this case, the embedded app inherits the basic access authorization from the launching app  and may retrieve extended access token for EPR endpoints protected by the EPR role and attribute based authorization (e.g. to retrieve Documents).

### Actor Roles

**Actor:** IUA Authorization Client  
**Role:** Communicates launch information and claims to the IUA Authorization Server and receives JWT ac-cess token or XUA Authorization Assertion.   
**Actor:** IUA Authorization Server  
**Role:** Role  Verifies claims and authentication information, retrieves and validates the user consent for the mHealth app to act on behalf of the user  and responds a JWT or XUA compliant access token to the IUA Authorization Client.  

### Referenced Standards

This national extension does not reference additional standards to the standards referenced in the Get Access Token [ITI-71] transaction of the IUA Trial Implementation.   
### Messages

<div>{% include IUA_ActorDiagram_ITI-71.svg %}</div>

<figcaption>OAuth 2.1 authorization code grant flow of the of the IUA Get Access Token transaction</figcaption>  

| Step                                                                                                               | Parameter             | Opt (Basic/ Extended). | Reference     | Remark                                                                                                                                                                                                                             |
|--------------------------------------------------------------------------------------------------------------------|-----------------------|------------------------|---------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| The mHealth app sends a HTTP GET request to the IUA Authorization Server endpoint.                                 | response_type         | R                      | IUA           | The value must be code.                                                                                                                                                                                                            |
|                                                                                                                    | client_id             | R                      | IUA           | The ID, the client is registered at the IUA Authorization Server.                                                                                                                                                                  |
|                                                                                                                    | redirect_uri          | R                      | IUA           | The  IUA Authorization Server redirects the user-agent to the client's redirection endpoint previously established with the authorization server during the client registration process or when making the authorization request.  |
|                                                                                                                    |                       |                        | SMART on FHIR | Used as callback URL, the IUA Authorization Server will send the authorization code to.The URL SHALL match one of the client's pre-registered redirect URIs.                                                                       |
|                                                                                                                    |                       |                        |               | The attribute is optional in IUA, required in the SMART on FHIR Launch Framework.                                                                                                                                                  |
|                                                                                                                    | state                 | R                      | IUA           |                                                                                                                                                                                                                                    |
|                                                                                                                    | scope                 | R                      | IUA           | Attributes the app claims (see detailed description below).                                                                                                                                                                        |
|                                                                                                                    |                       |                        | SMART on FHIR |                                                                                                                                                                                                                                    |
|                                                                                                                    | aud                   | R                      | SMART on FHIR | The audience URL the token will be used for.                                                                                                                                                                                       |
|                                                                                                                    | launch                | O/R                    | SMART on FHIR | If present, the launch parameter indicates that the app (or the view) was launched from an EHR or mHealth app context which has already been authorized to access the Swiss EPR (e.g. SMART on FHIR based primary system).         |
|                                                                                                                    | code_challenge        | R                      | IUA           | transformed version of code_verifier with code_challenge_method                                                                                                                                                                    |
|                                                                                                                    | code_challenge_method | R                      | IUA           | SHALL be “S256”.                                                                                                                                                                                                                   |
| The authorization server performs a HTTP GET on the callback URL (redirect_uri) conveying the authorization code.  | code                  | R                      | IUA           | The authorization code generated by the Authorization Server.                                                                                                                                                                      |
|                                                                                                                    | state                 | R                      | IUA           | An unguessable value used by the client to track the state between the authorization request and the callback.                                                                                                                     |
| The app performs an HTTP POST with parameter                                                                       | client_id             | R                      | IUA           | The ID the client is registered at the IUA Authorization Server.                                                                                                                                                                   |
| as a form-encoded HTTP entity body, passing its                                                                    | redirect_uri          | R                      | IUA           | The URI to redirect the apps user agent to.                                                                                                                                                                                        |
| client_id and client_secret as an HTTP Basic authorization header.                                                 | grant_type            | R                      | IUA           | Value shall be “authorization_code”.                                                                                                                                                                                               |
|                                                                                                                    | code                  | R                      | IUA           | The authorization code.                                                                                                                                                                                                            |
|                                                                                                                    | code_verifier         | R                      | IUA           | The original code verifier string.                                                                                                                                                                                                 |
| The Authorization Server responds with the access token in the HTML body element.                                  | access_token          | R                      | IUA           | A string containing the access token. The format of the access token string depends on the supported JWT Token or SAML Token.The Authorization Token in JWT format or a XUA Authorization Assertion.                               |
|                                                                                                                    | token_type            | R                      | IUA           | The value of the parameter shall be Bearer.                                                                                                                                                                                        |
|                                                                                                                    | scope                 | R                      | IUA           | The scope granted by the Authorization Server.                                                                                                                                                                                     |
|                                                                                                                    | expires_in            | R                      | IUA           | Maximum duration of 5 minutes                                                                                                                                                                                                      |
|                                                                                                                    |                       |                        |               |                                                                                                                                                                                                                                    |
|                                                                                                                    | refresh_token         | O                      | IUA           | TBD how to handle refresh tokens                                                                                                                                                                                                   |

<figcaption ID="5">Description of the HTTP conversation of the transaction.</figcaption>  
  
### Trigger Events

A user launches an mHealth app or a specific application view to access data and documents from the Swiss EPR. 

### Message Semantics

#### Request

The following table summarizes the requirements on the scope parameter used to convey the claims: 

| Scope                     | Optionality (Basic/ Extended). | Reference            | Remark                                                                                                                                                                    |
|---------------------------|--------------------------------|----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| launch                    | O/R                            | SMART on FHIR        | Permission to obtain launch context when the app is launched from an EHR. Required for apps or views launched from an EHR or an mHealth app which was authorized before.  |
| purpose_of_use=token   | O/R                            | See sections below.  | Value taken from code system 2.16.756.5.30.1.127.3.10.5 of the CH: EPR value set.                                                                                         |
| subject_role=token        | O/R                            | See sections below.  | Only the values for the Role of Healthcare Professionals, Assistants, Patients and Representatives are allowed.                                                           |
| person_id=value           | O/R                            | See sections below.  | EPR-SPID identifier of the patient’s record and the patient assigning authority formatted in CX syntax.                                                                   |
| principal=token           | O/O                            | See sections below.  | Name of the healthcare professional an assistant is acting on behalf of.                                                                                                  |
| principal_id=token        | O/O                            | See sections below.  | GLN of the healthcare professional an assistant is acting on behalf of.                                                                                                   |
| group=value               | O/O                            | See sections below.  | Name of the organization or group an assistant is acting on behalf of.                                                                                                    |
| group_id=value            | O/O                            | See sections below.  | OID of the organization or group an assistant is acting on behalf of.                                                                                                     |
| access_token_format=value | O/O                            |                      | Either ihe-jwt or ihe-saml as value. Will return this token_flavor. If scope is not provided defaults to ihe-jwt.                                                         |

<figcaption ID="6">Overview of the request’s scope parameter. For the explanation see the following sections.</figcaption>  
  

Token format according FHIR [token type](https://www.hl7.org/fhir/search.html#token).

The scope parameter of the request MAY claim the following attributes:
- There may be a scope with name “launch”. If present, it indicates the permission to obtain launch context for apps (or views) launched in SMART EHR Launch mode. The scope SHALL be used by all apps (or views) launched from a mHealth app which was authorized before.
- There MAY be a scope with name "purpose_of_use=token". If present, the token SHALL convey the coded value of the current transaction’s purpose of use. Allowed values are NORM (normal access) and EMER (mergency access) from code system 2.16.756.5.30.1.127.3.10.5 of the CH:EPR value set. e.g. purpose_of_use=urn:oid:2.16.756.5.30.1.127.3.10.5|NORM
- There MAY be a scope with name "subject_role=token". If present, the token SHALL convey the coded value of the subject’s role. The value SHALL be either HCP (healthcare professional), ASS (assistant), REP (representative) or PAT (patient) from code system 2.16.756.5.30.1.127.3.10.6 of the CH:EPR value set. e.g.: subject_role=urn:oid:2.16.756.5.30.1.127.3.10.6|HCP
- There MAY be a scope with name "person_id=value". If present, the value shall convey the EPR-SPID identifier of the patient’s record and the patient assigning authority formatted in CX syntax. e.g: person_id=305000^^^&amp;2.16.756.5.30.1.109.6.5.3.1.1&amp;ISO

Depending on the value of the role scope additional scopes are required, as described in the following sections.

##### Heathcare Professional Extension
In the healthcare professional extension, the scope subject_role  SHALL be the code HCP from code system 2.16.756.5.30.1.127.3.10.6 of the CH:EPR value set.

##### Assistant Extension
In the assistant extension, the scope subject_role SHALL be the code ASS from code system 2.16.756.5.30.1.127.3.10.6 of the CH:EPR value set. There SHALL be a scope with name princi-pal_id=value. The value SHALL convey the GLN of the healthcare professional an assistant is acting on behalf of. There SHALL be a scope with name principal=value. The value SHALL convey the name of the healthcare professional an assistant is acting on behalf of.
There MAY be one or more scopes with name group_id=value and corresponding group=value. If pre-sent each value SHALL convey the ID and name of the subject’s organization or group as registered in the EPR HPD. The ID MUST be an OID in the format of an URN.

##### 	Patient Extension
In the patient extension, the scope subject_role SHALL be the code PAT from code system 2.16.756.5.30.1.127.3.10.6 of the CH:EPR value set. The value of the purpose of use scope SHALL be the code NORM from code system 2.16.756.5.30.1.127.3.10.5 of the CH:EPR value set.

##### 	Representative Extension
In the representative extension, the scope subject_role SHALL be the code REP from code system 2.16.756.5.30.1.127.3.10.6 of the CH:EPR value set. The token of the purpose_of_use scope SHALL be the code NORM from code system 2.16.756.5.30.1.127.3.10.5 of the CH:EPR value set.


####	Response
The response SHALL either convey an basic acces token in JWT format, granting basic access to the EPR (i.e. to access patient data), or an extended access token to access re-sources protected by the role and attribute based EPR authorization (i.e. read and write documents).

##### JSON Web Token Option

From the 3.71.4.2.2.1.1 JWT IUA extension subject_name, subject_role, purpose_of_use, nation-al_provider_identifier, person_id shall be supported by the Authorization Server and Resource Server.
The claim content for the JWT IUA extensions shall correspond to the content defined in the XUA specification (see 1.6.4.2 Get X-User Assertion, A5E1).

| JWT Claim (Extension)        | Optionality | XUA Attribute EPR                                  | Remark                                                                                                                                                                    |
|------------------------------|-------------|----------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| subject_name                 | O/R         | urn:oasis:names:tc:xspa:1.0:subject:subject-id     | Plain text’s user name.                                                                                                                                                   |
| subject_role                 | O/R         | urn:oasis:names:tc:xacml:2.0:subject:role          | IUA defines this as an array of code objects indicating the user role. In the Swiss EPR only one coded value conveying the role taken from the EPR Role Code Value Set.   |
| purpose_of_use               | O/R         | urn:oasis:names:tc:xspa:1.0:subject:purposeofuse   | Code object indicating the purpose of use. In the Swiss EPR the value SHALL be taken from the EPR Purpose Of Use Value Set.                                               |
| national_provider_identifier | O/R         |                                                    | SHALL be the GLN of the healthcare or assistant.                                                                                                                          |
| person_id                    | O/R         | urn:oasis:names:tc:xacml:2.0:resource:resource-id  | SHALL be the EPR-SPID of the patients EPR.                                                                                                                                |

<figcaption>Attributes of the IUA Get Access Token response in the JWT extension ihe_iua.</figcaption>  
  
##### The JWT ch_group extension 

The Authorization Server and Resource Server SHALL support the following extensions to the JWT access token for a list of groups a subject acting on behalf of:
-	name: Name of the organization/group. The name MUST be a string. 
-	id: The oid of the organization/group.The id MUST be an OID in the format of an URN

The ch_group extension claims shall be wrapped in an "extensions" object with key 'ch_group’ and a JSON Array containing the json objects with properties name and id. The id MUST be an OID in the format of an URN. 

| ch_group Array element | Optionality | XUA Attribute EPR                                   | Remark                                                                                                                                          |
|------------------------|-------------|-----------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| name                   | O/R         | urn:oasis:names:tc:xspa:1.0:subject:organization    | In XUA it is an array of text description of the groups/organizations, in the JWT extension it is an array of groups with properties name, id.  |
| id                     | O/R         | urn:oasis:names:tc:xspa:1.0:subject:organization-id | In XUA it is an array of ids of the groups/organizations, in the JWT extension it is an array of group name, group id.                          |

<figcaption>Attributes of the IUA Get Access Token response in the JWT extension ch_group.</figcaption>  

##### The JWT ch_assistant extension 

The Authorization Server and Resource Server shall support the following extensions to the JWT access token:
-	principal (optional) Name of the healthcare professional an assistant is acting on behalf of.
-	principal_id (optional) GLN of the healthcare professional an assistant is acting on behalf of.

The ch_assistant extension claims shall be wrapped in an "extensions" object with key 'ch_assistant' and a JSON value object containing the claims. 
The claim content for the JWT CH:EPR extensions shall correspond to the content defined in the XUA specification (see 1.6.4.2 Get X-User Assertion, A5E1).

| JWT Claim (Extension) | Optionality | XUA Attribute EPR                  | Remark                                                                   |
|-----------------------|-------------|------------------------------------|--------------------------------------------------------------------------|
| principal             | O/R         | urn:e-health-suisse:principal-name | Name of the healthcare professional an assistant is acting on behalf of. |
| principal_id          | O/R         | urn:e-health-suisse:principal-id   | GLN of the healthcare professional an assistant is acting on behalf of.  |

<figcaption>Attributes of the IUA Get Access Token response in the JWT extension ch_assistant.</figcaption>  


### Expected Actions IUA Authorization Client
The IUA Authorization Client SHALL support the HTTP conversation of the OAUTH 2.1 Authorization Code grant as follows: 

When launched, the IUA Authorization Client SHALL perform HTTP GET request with the URL query parameter as defined in [Table](#5) and with the scope claims described in [Table](#6). 

If the IUA Authorization Client receives the request from the IUA Authorization Server on the callback URL conveying the authorization code, it SHALL perform the HTTP POST request with the client_id and client_secret in the HTTP authorization header to resolve the authorization code to the access token.  

The IUA Authorization Client SHALL use the access token as defined in IUA Incorporate Access Token transaction, when performing requests to resources of the Swiss EPR .  

### Expected Actions IUA Authorization Server 
The IUA Authorization Server SHALL support the HTTP conversation of the OAUTH 2.1 Authorization Code grant as follows:

If the IUA Authorization Server receives a request, it SHALL authenticate the user by redirecting the request to a XUA Authentication Provider. The XUA Authentication provider authenticates the user based on its internal session management (i.e. by checking the requests cookies or other methods) or by validating the user authentication means and returns the identity token to the IUA Authorization Server. 

In case of authentication failure, the IUA Authorization Server must respond with HTTP error code 401 ‘Not authorized’.

The IUA Authorization Server SHALL verify the user consent for the mHealth app either by presenting the user a dialog to confirm the required consent, or by validating preregistered contracts.

If the app (or view) is launched as an SMART EHR Launch, the IUA Authorization Server SHALL validate the launch scope parameter, by verifying that the user consent is registered with this launch parameter value. In case of failure, it SHALL respond with HTTP error code 401 ‘Not authorized’.

Depending on the scope claimed, the IUA Authorization Server SHALL either build an basic access authorization token allowing basic access to the EPR (i.e. to access patient data), or an extended access to access resources protected by the role and attribute based EPR authorization (i.e. read and write documents).

The business rules for the IUA Authorization Server for the Healthcare Professional, Assistant, Patient and Representative Extension SHALL be the same as for Annex5 1.6.4.2.4.4 Expected Actions X-Assertion Provider Extensions.

If successful the IUA Authorization Server shall generate an OAuth 2.1 authorization code and per-form a callback to the URL defined in the request, using the OAuth authorization code as URL query parameter with key ‘code’.

The IUA Authorization Server SHALL stores the access token and the assigned authorization code and respond the access token on request to the Authorization Client. 

### Message Example

#### Request

The first step of the request conversion is a HTTP GET which may look like for a basic access token: 

```
GET authorize?
    response_type=code&
    client_id=app-client-id&
    http%3A%2F%2Flocalhost%3A9000%2Fcallback&
    launch=xyz123&
    scope=launch+user%2F%2A.%2A+openid+fhirUser&state=98wrghuwuogerg97&aud=https%3A%2F%2Fehr%2Ffhir&code_challenge=ZmVjMmIwMWYyYTNjZWJiNTgyNTgxYzlmOGYyMWM0MWI3YmZhMjQ4YjU5MDc3Mzk4MDBmYTk0OThlNzZiNjAwMw&code_challenge_method=S256 HTTP/1.1

Host: localhost:9001
```

for an extended access token where at least purpose_of_use (NORM), subject_role (HCP) and person_id are added to the scope:

```
GET authorize?
    response_type=code&
    client_id=app-client-id&
    http%3A%2F%2Flocalhost%3A9000%2Fcallback&
    launch=xyz123&
    scope=launch+user%2F*.*+openid+fhirUser+purpose_of_use%3Durn%3Aoid%3A2.16.756.5.30.1.127.3.10.5%7CNORM+subject_role%3Durn%3Aoid%3A2.16.756.5.30.1.127.3.10.6%7CHCP+person_id%3D761337610411353650%5E%5E%5E%26amp%3B2.16.756.5.30.1.127.3.10.3%26amp%3BISO%0A&code_challenge=ZmVjMmIwMWYyYTNjZWJiNTgyNTgxYzlmOGYyMWM0MWI3YmZhMjQ4YjU5MDc3Mzk4MDBmYTk0OThlNzZiNjAwMw&code_challenge_method=S256 HTTP/1.1

Host: localhost:9001
```

The second step of the request conversion is a HTTP GET Callback conveying the authorization code and may look like: 

```
GET /callback?code=8V1pr0rJ&state=98wrghuwuogerg97 HTTP/1.1 

Host: localhost:9000
```

The third step of the request conversion is a HTTP POST sending the authorization code to retrieve the authorization token in the response which may look like: 

```
POST /token HTTP/1.1 
Host: localhost:9001

Accept: application/json
Content-type: application/x-www-form-encoded
Authorization: Basic bXktYXBwOm15LWFwcC1zZWNyZXQtMTIz
grant_type=authorization_code&redirect_uri=http%3A%2F%2Flocalhost%3A9000%2Fcallback&code=98wrghuwuogerg97&code_verifier=qskt4342of74bkncmicdpv2qd143iqd822j41q2gupc5n3o6f1clxhpd2x11
```

#### Response

A JWT access token returned by the IUA Authorization Server and to be used to retrieve patient data may look like: 

```json
{
  "iss": "http://issuerAdress.ch",
  "sub": "UserId-bfe8a208-b9d0-4012-b2f5-168b949fc3cb",
  "aud": "http://pixmResourceServerURL.ch",
  "exp": 1587294580000,
  "nbf": 1587294460000,
  "iat": 1587294460000,
  "jti": "c5436729-3f26-4dbf-abd3-2790dc7771a",
  "extensions" : {  
    "ihe_iua" : {  
      "subject_name": "Martina Musterarzt",
      "national_provider_identifier": "2000000090092"
    }
}
```

A extend JWT access token to be used to access patient documents SHALL have the additional attributes of the purpose of use, subject role, the EPR-SPID of the patient and may look like:

```json
{
  "iss": "http://issuerAdress.ch",
  "sub": "UserId-bfe8a208-b9d0-4012-b2f5-168b949fc3cb",
  "aud": "http://mhdResourceServerURL.ch",
  "exp": 1587294580000,
  "nbf": 1587294460000,
  "iat": 1587294460000,
  "jti": "c5436729-3f26-4dbf-abd3-2790dc7771a",
  "extensions" : {  
    "ihe_iua" : {  
      "subject_name": "Martina Musterarzt",
      "national_provider_identifier": "2000000090092",
      "person_id": "761337610411353650^^^&amp;2.16.756.5.30.1.127.3.10.3&amp;ISO",
      "subject_role": [
        {
          "system": "urn:oid:2.16.756.5.30.1.127.3.10.6",
          "code": "HCP"
        }
      ],
      "purpose_of_use": {
          "system": "urn:uuid:2.16.756.5.30.1.127.3.10.5",
          "code": "NORM",
      }
    }, 
    "ch_group" : [
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

A JWT access token to be used to access by an assistant acting behalf on a healthcare professional for a patient SHALL have the additional extension ch_assistant:

```json
{
  "iss": "http://issuerAdress.ch",
  "sub": "UserId-bfe8a208-b9d0-4012-b2f5-168b949fc3cb",
  "aud": "http://mhdResourceServerURL.ch",
  "exp": 1587294580000,
  "nbf": 1587294460000,
  "iat": 1587294460000,
  "jti": "c5436729-3f26-4dbf-abd3-2790dc7771a",
  "extensions" : {  
    "ihe_iua" : {  
      "subject_name": "Dagmar Musterassistent",
      "national_provider_identifier": "2000000090108",
      "person_id": "761337610411353650^^^&amp;2.16.756.5.30.1.127.3.10.3&amp;ISO",
      "subject_role": [
        {
          "system": "urn:oid:2.16.756.5.30.1.127.3.10.6",
          "code": "HCP"
        }
      ],
      "purpose_of_use": {
          "system": "urn:uuid:2.16.756.5.30.1.127.3.10.5",
          "code": "NORM",
      }
    }, 
    "ch_group" : [
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
    "ch_assistant": {
      "principal": "Martina Musterarzt", 
      "principal_id": "2000000090092" 
    }
  }
}
```

### Security Consideration

As specified in the IUA profile, the IUA Authorization Client and Authorization Server actors SHALL support the JWS (signed) alternative of the JWT token. Any actor that supports this transaction MAY support the JWE (unsigned but encrypted) alternative of the JWT token. 
