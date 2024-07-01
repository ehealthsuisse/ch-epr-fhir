### DSTU4 Informative Ballot 2024

* clarified the use of the redirect-uri as callback URL
* 4.0.1 technical corrector because plantuml files were not generated
major updates on the IG have been made:
* Renamed the ImplementationGuide from `ch-epr-mhealth` to `ch-epr-fhir` [#159](https://github.com/ehealthsuisse/ch-epr-fhir/issues/159)
* MHD: Require EPR-SPID as a query patient.identifier [#166](https://github.com/ehealthsuisse/ch-epr-fhir/issues/166)
* MHD: support ITI-67 creation search parameter [#170](https://github.com/ehealthsuisse/ch-epr-fhir/issues/170)
* MHD: extension to support restricted metadata update [#25](https://github.com/ehealthsuisse/ch-epr-fhir/issues/25)
* IUA: IUA JWT Extension for homeCommunityId [#165](https://github.com/ehealthsuisse/ch-epr-fhir/issues/165)
* IUA Client Registration [#146](https://github.com/ehealthsuisse/ch-epr-fhir/issues/146) and [others](https://github.com/ehealthsuisse/ch-epr-fhir/issues?q=is%3Aissue+is%3Aclosed+IUA)
* PPQm: Integrated [CH EPR PPQm](https://github.com/ehealthsuisse/ch-epr-fhir/issues/147) into this guide and introduce 304 Consent template [#164](https://github.com/ehealthsuisse/ch-epr-fhir/issues/164))
* Define AuditEvent profile to define Trace Context [#185](https://github.com/ehealthsuisse/ch-epr-fhir/issues/185)

* complete [changelog](https://github.com/ehealthsuisse/ch-epr-fhir/compare/v3.0.0...master)

The following items are under current development:
* Cross community access [#92](https://github.com/ehealthsuisse/ch-epr-fhir/issues/92)
* mCSD additional transaction for Feed [#158](https://github.com/ehealthsuisse/ch-epr-fhir/issues/158)
* Audit Examples together with IUA and adapted to EPR requirements [#186](https://github.com/ehealthsuisse/ch-epr-fhir/issues/186)

### DSTU3 Informative Ballot 2023 - Resolved Issues

* Upgrade dependencies and fix IG link labels [#103](https://github.com/ehealthsuisse/ch-epr-fhir/issues/103)
* Add links in the documentation to facilitate navigation and rework structure [#82](https://github.com/ehealthsuisse/ch-epr-fhir/issues/82)
* PIXmPatientFeed profile can't be used for PDQm responses [#115](https://github.com/ehealthsuisse/ch-epr-fhir/issues/115)
* Fixed typos [#106](https://github.com/ehealthsuisse/ch-epr-fhir/issues/106)
* PDQm Query: the telecom search parameter shall not be used [#117](https://github.com/ehealthsuisse/ch-epr-fhir/issues/117)
* PIXm Feed: update requirements to the new Amendment 1 of Annex 5 EPRO-FDHA [#111](https://github.com/ehealthsuisse/ch-epr-fhir/issues/111)
* Add CapabilityStatements for the RESTful ATNA profile [#107](https://github.com/ehealthsuisse/ch-epr-fhir/issues/107)
* The targetSystem in PIXm queries shall be the MPI-PID and the EPR-SPID [#112](https://github.com/ehealthsuisse/ch-epr-fhir/issues/112)
* Remove URN-prefix in AuditEvent.source.site [#108](https://github.com/ehealthsuisse/ch-epr-fhir/issues/108)
* Add missing mCSD CapabilityStatement imports in mHealth App and API [#70](https://github.com/ehealthsuisse/ch-epr-fhir/issues/70)
* PDQm Supplier actor name misspelled in mHealth API CapabilityStatement [#87](https://github.com/ehealthsuisse/ch-epr-fhir/issues/87)
* Missing Swiss specific PDQ V3 Error message in PDQm [#80](https://github.com/ehealthsuisse/ch-epr-fhir/issues/80)
* Disallow non-contained Patient resources in ITI-65 requests [#75](https://github.com/ehealthsuisse/ch-epr-fhir/issues/75)
* Updated sequence diagrams, standalone launch is not possible [#69](https://github.com/ehealthsuisse/ch-epr-fhir/issues/69) [#98](https://github.com/ehealthsuisse/ch-epr-fhir/issues/98)
* Removed the fhirVersion from Accept header examples [#149](https://github.com/ehealthsuisse/ch-epr-fhir/issues/149)

### DSTU3 Informative Ballot 2023 - Raised Issues

The implementation guide was under an informative ballot by HL7 Switzerland until September 30th, 2023. The following comments have been raised

General IG considerations:
* Rename Menu 'Profiles' to 'IHE Profiles' and menu 'Profiles'  [#83](https://github.com/ehealthsuisse/ch-epr-fhir/issues/83) 
* Missing links to profiles and examples [#82](https://github.com/ehealthsuisse/ch-epr-fhir/issues/82)
* Introduction [#76](https://github.com/ehealthsuisse/ch-epr-fhir/issues/76)
* Sequence Diagrams: patient get document – generic mHealth option - local ID [#69](https://github.com/ehealthsuisse/ch-epr-fhir/issues/69) and precisions [#76](https://github.com/ehealthsuisse/ch-epr-fhir/issues/76) 
* Typos, outdated links: [#81](https://github.com/ehealthsuisse/ch-epr-fhir/issues/81), [#75](https://github.com/ehealthsuisse/ch-epr-fhir/issues/75)

IUA
* Discrepancy with OAuth 2.1 specification [#79](https://github.com/ehealthsuisse/ch-epr-fhir/issues/79)
* Comments on ITI-71 [#72](https://github.com/ehealthsuisse/ch-epr-fhir/issues/72)
* Varia [#78](https://github.com/ehealthsuisse/ch-epr-fhir/issues/78)
* Metadata attributes [#77](https://github.com/ehealthsuisse/ch-epr-fhir/issues/77) and [#71](https://github.com/ehealthsuisse/ch-epr-fhir/issues/71)

PIxm/PDQm
* Missing Swiss specific PDQ V3 Error message in PDQm [#80](https://github.com/ehealthsuisse/ch-epr-fhir/issues/80)
* Various Issues [#73](https://github.com/ehealthsuisse/ch-epr-fhir/issues/73)

MHD
* Patient should not be allowed [#75](https://github.com/ehealthsuisse/ch-epr-fhir/issues/75)

RESTful ATNA 
* Various [#74](https://github.com/ehealthsuisse/ch-epr-fhir/issues/74)

mCDS
* Missing mCSD CapabilityStatement [#70](https://github.com/ehealthsuisse/ch-epr-fhir/issues/70)

### DSTU3 Informative Ballot 2023 - Start 
* added ITI-78 / Mobile Demographics Query to transactions [#52](https://github.com/ehealthsuisse/ch-epr-fhir/issues/52)
* added the mCSD profile (transaction ITI-90) [#43](https://github.com/ehealthsuisse/ch-epr-fhir/issues/43)

### Open Issues
See open issues on [GitHub](https://github.com/ehealthsuisse/ch-epr-fhir/issues/)

* [IUA handling of client authentication](https://github.com/ehealthsuisse/ch-epr-fhir/issues/19)
* [IUA Refresh token handling](https://github.com/ehealthsuisse/ch-epr-fhir/issues/20)
* [IUA ihe_saml token option supported for the generic mHealth Option](https://github.com/ehealthsuisse/ch-epr-fhir/issues/21)
* [IUA ihe-jwt token option handling in XDS environment](https://github.com/ehealthsuisse/ch-epr-fhir/issues/22)
* [MHD extension for RMU](https://github.com/ehealthsuisse/ch-epr-fhir/issues/25)
* [Adapt IHE profiles for the Trace Context support](https://github.com/ehealthsuisse/ch-epr-fhir/issues/153)

### DSTU2 Informative Ballot 2022 - Resolved Issues
* Changes due to the adjustments in the new version of the derived [IHE ITI MHD](https://profiles.ihe.net/ITI/MHD/) IG [#47](https://github.com/ehealthsuisse/ch-epr-fhir/issues/47)/[#50](https://github.com/ehealthsuisse/ch-epr-fhir/issues/50):
   * Update canonical URLs to 'https://profiles.ihe.net/ITI/MHD/' (https instead of http) 
   * Change package id from 'ihe.mhd.fhir' to 'ihe.iti.mhd'
   * Provide Document Bundle [ITI-65]: according to MHD should the entryUUID not be added by the Document Source (need to be added by the DocumentResponder)
      * Remove List.identifier requirements (http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-mhd-submissionset-comprehensive) 
      * Remove List.identifier with 'use = official' (examples 2-7-BundleProvideDocument, 2-7-DocRefMedicationCard, 2-7-DocSubMedicationCard)
      * Remove DocumentReference.identifier requirements (http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-mhd-documentreference-comprehensive)
      * Remove DocumentReference.identifier (example 2-7-BundleProvideDocument)
      * Remove 'use = official' from DocumentReference.identifier (example Bundle-FindDocumentReferences)
   * SearchParameter 'https://profiles.ihe.net/ITI/MHD/SearchParameter/List-SourceId' changed from type 'reference' to 'token' (MHD Document Consumer (client)/MHD Document Responder (server)) 
* Changes due to the adjustments in the new version of the derived [IHE ITI PIXm](https://profiles.ihe.net/ITI/PIXm/index.html) IG [#58](https://github.com/ehealthsuisse/ch-epr-fhir/issues/58):
   * Update canonical URLs to 'https://profiles.ihe.net/ITI/PIXm/' (https instead of http)
   * Change package id from 'IHE.ITI.PIXm' to 'ihe.iti.pixm'
* Update sequence diagrams (appendix) [#51](https://github.com/ehealthsuisse/ch-epr-fhir/issues/51)
* Typos [#49](https://github.com/ehealthsuisse/ch-epr-fhir/issues/49)/[#51](https://github.com/ehealthsuisse/ch-epr-fhir/issues/51)
* Add new IG fragments (IP Statements, Cross Version Analysis, Dependency Table, Globals Table) [#53](https://github.com/ehealthsuisse/ch-epr-fhir/issues/53)
* Add missing element 'experimental' to CS/VS [#54](https://github.com/ehealthsuisse/ch-epr-fhir/issues/54)
* Add missing element 'caseSensitive' to CS [#55](https://github.com/ehealthsuisse/ch-epr-fhir/issues/55)
* Remove reference to process flow with sequence diagram [#46](https://github.com/ehealthsuisse/ch-epr-fhir/issues/46)

### DSTU1 Informative Ballot 2021 - Resolved Issues
- MHD Find DocumentReferences - attachment.url not a full URL [#27](https://github.com/ehealthsuisse/ch-epr-fhir/issues/27)
- CH MHD DocumentManifest/DocumentReference profiles - Various issues [#28](https://github.com/ehealthsuisse/ch-epr-fhir/issues/28)
- Adjusted Description CH Extension Author AuthorRole [#29](https://github.com/ehealthsuisse/ch-epr-fhir/issues/29)
- PIXm Patient Identifier Cross-reference Manager (server) - JSON Representation [#30](https://github.com/ehealthsuisse/ch-epr-fhir/issues/30)
- Typos [#31](https://github.com/ehealthsuisse/ch-epr-fhir/issues/31)
- Add download link for npm package on home page [#32](https://github.com/ehealthsuisse/ch-epr-fhir/issues/32)
- Correct fullUrl and add id in searchset [#36](https://github.com/ehealthsuisse/ch-epr-fhir/issues/36)
- Record Audit Event [ITI-20] [#38](https://github.com/ehealthsuisse/ch-epr-fhir/issues/38)
- Get Access Token, correct EPR-SPID example [#39](https://github.com/ehealthsuisse/ch-epr-fhir/issues/39)
