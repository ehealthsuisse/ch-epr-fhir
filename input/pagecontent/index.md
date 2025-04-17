### Introduction

The national extensions documented in this implementation guide shall be used in conjunction with the definitions of integration 
profiles, actors and transactions provided in Volumes 1 through 3 of the IHE IT Infrastructure Technical Framework.

This implementation guide with national extensions of IHE integration profiles was authored in order to fulfil the Swiss
regulations of the Ordinance on the Electronic Patient Record (EPRO, SR 816.11). The EPRO and the
EPRO-DFI are published in Official Compilation of Federal Legislation (AS) (available in [German](https://www.admin.ch/opc/de/classified-compilation/20111795/index.html), [French](https://www.admin.ch/opc/fr/classified-compilation/20111795/index.html)
and [Italian](https://www.admin.ch/opc/it/classified-compilation/20111795/index.html)).

<div markdown="1" class="stu-note">

[Significant changes, open and closed issues.](changelog.html)

</div>

**Download**: You can download this implementation guide in [NPM format](https://confluence.hl7.org/display/FHIR/NPM+Package+Specification) from [here](package.tgz).

### Overview

#### Introduction

This national extension is motivated by the intention to provide FHIR based profiles for the Swiss EPR by extending the IHE FHIR based mobile profiles. The IHE FHIR based mobile profiles use technologies (REST, OAuth, etc.) which are widely spread in the developer community and may be used for Web Applications, for example in web based primary systems or portals.

This national extension strictly separates the authentication and authorization of the applications use to access the EPR on behalf of the user and the authentication and authorization of the user itself. By using this separation this national extension closely follows the underlying IUA Trial Implementation and OAuth 2.1: 
* Client authentication - an application identifies and authenticates to an authorization server.
* Client authorization - an application is authorized by the user or system policy to access data and documents on behalf of the user.
* User authentication - a natural person identifies and authenticates using an Identity Provider with the authenticators registered for the natural person.
* User authorization - provision of an access token which includes the information required to perform authorization decisions and policy enforcement.     

The scope of this extension covers the following use cases:
1.	Client authentication and authorization; 
2.	User authentication and authorization; 
3.	Read data and documents from the EPR;
4.	Write data and documents to the EPR; 
5.	Write logs to the EPR ATNA Audit Record Repository.
6.  Read audit trails for a patient according the EPR requirements.

This extension covers two options:
1. Generic EPR API option – This option addresses primary systems or portals using the basic EPR flows replacing the XDS.b related and PIX/PDQ V3 profiles with the FHIR based profiles;
2. SMART on FHIR – This option addresses modular portals or primary systems that want to connect to the Swiss EPR using SMART on FHIR.

#### Profiles, actors and transactions

The following figure shows the profiles, actors and transactions specified or referenced in this national extension:

<div>{% include overview.svg %}</div>

### Conformance Expectations

The key words *MUST*, *MUST NOT*, *REQUIRED*, *SHALL*, *SHALL NOT*, *SHOULD*, *SHOULD NOT*, 
*RECOMMENDED*, *MAY*, and *OPTIONAL* in this document are to be interpreted as described in
[[RFC2119](https://www.ietf.org/rfc/rfc2119.txt)].

This implementation guide uses `Must Support` in StructureDefinitions with the definition found in [Appendix Z](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.10-profiling-conventions-for-constraints-on-fhir). This is equivalent to the IHE use of **R2** as defined in [Appendix Z](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.10-profiling-conventions-for-constraints-on-fhir).

#### Scope of precisions
The extensions, restrictions and translations specified apply to the following IHE IT Infrastructure (ITI) Integration profiles:

* [SMART on FHIR](http://www.hl7.org/fhir/smart-app-launch/)
* [IUA](https://profiles.ihe.net/ITI/IUA/index.html)
* [PDQm](https://profiles.ihe.net/ITI/PDQm/index.html)
* [PIXm](https://profiles.ihe.net/ITI/PIXm/index.html)
* [MHD](https://profiles.ihe.net/ITI/MHD/index.html)
* [mCSD](https://profiles.ihe.net/ITI/mCSD/index.html)
* [RESTful ATNA](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf)

#### National integration profiles

The following national integration profiles are included in this implementation guide:

* [PPQm](ppqm.html)
* [CH:ATC](ch-atc.html)

### Design considerations 

The Swiss EPR is a federated system with multiple communities publishing documents for a patient. A patient has a reference community but documents can be published for a patient in other communities too. Each patient has one active national identifier (EPR-SPID) which shall be used to correlate the patient between the different communities. This impacts the FHIR API in the following way:

##### logical reference for patients and health care professionals, contained resources

1. No addressable patient resources: All references to patients are made by the identifier EPR-SPID since there is no national master patient which could be referenced. This is the reason that IHE PIXm and PDQm with the $match transaction have been selected and not IHE MHDS/PMIR. Systems are not allowed to store the EPR-SPID, and need to feed their local identifier (localID) and EPR-SPID to the community to resolve the localID to the EPR-SPID later on. Therefore FHIR APIs require the support of the patient logical identifier as a query parameter (e.g. MHD, CH:PPQm) and the resources are profiled that a logical reference with the EPR-SPID identifier have to be provided.
2. The same principle applies for health care professionals, they are identified by the GLN number and references to them need to include also the the logical reference from other resources (e.g. DocumentReference).
3. Information which has to be provided and has no own identity in the Swiss EPR (e.g. as local patient demographics in document publishing) are represented as contained resources. 

#### authentication and authorization

Annex 8 allows two different standards for user authentication with SAML 2.0 and OpenID Connect (JWT). 
For Authorization IUA and XUA are supported. In addition client identification in IUA identifies the client application by message signature 
or identifies the client application network node by mTLS. 
This implementation guide defines how they can be combined with the security considerations on the different transactions.

##### interoperability specification

This Implementation Guide profiles elements, cardinalities and bindings that are required by the use cases, law and annexes of the Swiss EPR, to ensure that the systems are interoperable. The specification defines the requirements on the API and exchange messages required by law. Other elements, cardinalities and bindings are left as-is. E.g., a solution can add additional support with search parameters (which the FHIR specifications allows) or add additional transactions/profiles, as long as the law and annexes of the Swiss EPR are respected.

### IP Statements
This document is licensed under Creative Commons "No Rights Reserved" ([CC0](https://creativecommons.org/publicdomain/zero/1.0/)).

HL7®, HEALTH LEVEL SEVEN®, FHIR® and the FHIR <img src="icon-fhir-16.png" style="float: none; margin: 0px; padding: 0px; vertical-align: bottom"/>&reg; are trademarks owned by Health Level Seven International, registered with the United States Patent and Trademark Office.

This implementation guide contains and references intellectual property owned by third parties ("Third Party IP"). Acceptance of these License Terms does not grant any rights with respect to Third Party IP. The licensee alone is responsible for identifying and obtaining any necessary licenses or authorizations to utilize Third Party IP in connection with the specification or otherwise.

{% include ip-statements.xhtml %}

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### Dependency Table

{% include dependency-table.xhtml %}

### Globals Table

{% include globals-table.xhtml %}
