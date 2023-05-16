### DSTU3 Informative Ballot 2023 
* added ITI-78 / Mobile Demographics Query to transactions [#52](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/52)

### Open Issues
See open issues on [GitHub](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/)

* [IUA handling of client authentication](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/19)
* [IUA Refresh token handling](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/20)
* [IUA ihe_saml token option supported for the generic mHealth Option](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/21)
* [IUA ihe-jwt token option handling in XDS environment](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/22)
* [MHD extension for RMU](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/25) 

### DSTU2 Informative Ballot 2022 - Resolved Issues
* Changes due to the adjustments in the new version of the derived [IHE ITI MHD](https://profiles.ihe.net/ITI/MHD/) IG [#47](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/47)/[#50](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/50):
   * Update canonical URLs to 'https://profiles.ihe.net/ITI/MHD/' (https instead of http) 
   * Change package id from 'ihe.mhd.fhir' to 'ihe.iti.mhd'
   * Provide Document Bundle [ITI-65]: according to MHD should the entryUUID not be added by the Document Source (need to be added by the DocumentResponder)
      * Remove List.identifier requirements (http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/ch-mhd-submissionset-comprehensive) 
      * Remove List.identifier with 'use = official' (examples 2-7-BundleProvideDocument, 2-7-DocRefMedicationCard, 2-7-DocSubMedicationCard)
      * Remove DocumentReference.identifier requirements (http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/ch-mhd-documentreference-comprehensive)
      * Remove DocumentReference.identifier (example 2-7-BundleProvideDocument)
      * Remove 'use = official' from DocumentReference.identifier (example Bundle-FindDocumentReferences)
   * SearchParameter 'https://profiles.ihe.net/ITI/MHD/SearchParameter/List-SourceId' changed from type 'reference' to 'token' (MHD Document Consumer (client)/MHD Document Responder (server)) 
* Changes due to the adjustments in the new version of the derived [IHE ITI PIXm](https://profiles.ihe.net/ITI/PIXm/index.html) IG [#58](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/58):
   * Update canonical URLs to 'https://profiles.ihe.net/ITI/PIXm/' (https instead of http)
   * Change package id from 'IHE.ITI.PIXm' to 'ihe.iti.pixm'
* Update sequence diagrams (appendix) [#51](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/51)
* Typos [#49](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/49)/[#51](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/51)
* Add new IG fragments (IP Statements, Cross Version Analysis, Dependency Table, Globals Table) [#53](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/53)
* Add missing element 'experimental' to CS/VS [#54](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/54)
* Add missing element 'caseSensitive' to CS [#55](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/55)
* Remove reference to process flow with sequence diagram [#46](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/46)

### DSTU1 Informative Ballot 2021 - Resolved Issues
- MHD Find DocumentReferences - attachment.url not a full URL [#27](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/27)
- CH MHD DocumentManifest/DocumentReference profiles - Various issues [#28](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/28)
- Adjusted Description CH Extension Author AuthorRole [#29](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/29)
- PIXm Patient Identifier Cross-reference Manager (server) - JSON Representation [#30](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/30)
- Typos [#31](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/31)
- Add download link for npm package on home page [#32](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/32)
- Correct fullUrl and add id in searchset [#36](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/36)
- Record Audit Event [ITI-20] [#38](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/38)
- Get Access Token, correct EPR-SPID example [#39](https://github.com/ehealthsuisse/ch-epr-mhealth/issues/39)
