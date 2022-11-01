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
* [PIXm](https://profiles.ihe.net/ITI/PIXm/index.html)
* [MHD](https://profiles.ihe.net/ITI/MHD/index.html)
* [RESTful ATNA](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf)

### Overview

#### Introduction

This national extension is motivated by the intention to ease integration of mobile applications to the Swiss EPR by extending the IHE FHIR based mobile profiles. This national extension to IHE profiles is intended for mobile applications running on mobile devices, but not limited to. The IHE FHIR based mobile profiles use technologies (REST, OAuth, etc.) which are widely spread in the developer community and may be used for native applications and Web Applications, for example in web based primary systems.

The scope of this extension covers the following use cases:
1.	Client authentication and authorization; 
2.	User Authentication; 
3.	Read documents from the EPR;
4.	Write documents to the EPR; 
5.	Write logs to the EPR ATNA Audit Record Repository.   

This extension covers two options:
1. Generic mHealth option – This option adresses primary systems or mobile applications using the basic EPR flows but replace the XDS.b related and PIX V3 profiles with the FHIR based profiles;
2. SMART on FHIR – This option adresses mobile apps or modular primary systems that want to connect to the Swiss EPR using SMART on FHIR.

#### Profiles, actors and transactions

The following figure shows the profiles, actors and transactions specified or referenced in this national extension:

<div>{% include overview.svg %}</div>