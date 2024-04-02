### Introduction

The national extensions documented in this implementation guide shall be used in conjunction with the definitions of integration 
profiles, actors and transactions provided in Volumes 1 through 3 of the IHE IT Infrastructure Technical Framework.

This implementation guide with national extensions of IHE integration profiles was authored in order to fulfil the Swiss
regulations of the Ordinance on the Electronic Patient Record (EPRO, SR 816.11). The EPRO and the
EPRO-DFI are published in Official Compilation of Federal Legislation (AS) (available in [German](https://www.admin.ch/opc/de/classified-compilation/20111795/index.html), [French](https://www.admin.ch/opc/fr/classified-compilation/20111795/index.html)
and [Italian](https://www.admin.ch/opc/it/classified-compilation/20111795/index.html)).

<div markdown="1" class="stu-note">

[Significant changes, open and closed Issues](openissues.html)

</div>

**Download**: You can download this implementation guide in [NPM format](https://confluence.hl7.org/display/FHIR/NPM+Package+Specification) from [here](package.tgz).

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

#### Related profiles, actors and transactions

The FHIR API specifications to read audit trails is defined in a separate national Integration Profile
(_CH:ATC, SR816.11, Annex 5, Extension 2_) with the supporting [Implementation Guide](https://fhir.ch/ig/ch-atc/index.html).

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

This extension covers two options:
1. Generic EPR API option – This option adresses primary systems or portals using the basic EPR flows replacing the XDS.b related and PIX/PDQ V3 profiles with the FHIR based profiles;
2. SMART on FHIR – This option adresses modular portals or primary systems that want to connect to the Swiss EPR using SMART on FHIR.

#### Profiles, actors and transactions

The following figure shows the profiles, actors and transactions specified or referenced in this national extension:

<div>{% include overview.svg %}</div>

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
