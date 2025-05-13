### DSTU5 Informative Ballot 2025 

#### Open Issues

* Unknown code '26' in the CodeSystem 'http://terminology.hl7.org/CodeSystem/object-role' version '1.0.0': waiting to be added, see [#190](https://github.com/ehealthsuisse/ch-epr-fhir/issues/190)
* in review: ITI-71: Conflict between OAuth2 scope and ITI-71 scope [#245](https://github.com/ehealthsuisse/ch-epr-fhir/issues/245)  

#### Resolved Issues

* CH:ATC: Updated references and minor textual corrections in CH:ATC, ITI-81 and Volume 3 [#323](https://github.com/ehealthsuisse/ch-epr-fhir/issues/323), [#324](https://github.com/ehealthsuisse/ch-epr-fhir/issues/324), [#326](https://github.com/ehealthsuisse/ch-epr-fhir/issues/326), [#327](https://github.com/ehealthsuisse/ch-epr-fhir/issues/327)
* fix mCSD capability statement expected actions for update, delete [#310](https://github.com/ehealthsuisse/ch-epr-fhir/issues/310)
* add SCT edition in the expansion parameters [#256](https://github.com/ehealthsuisse/ch-epr-fhir/issues/256)
* Wrong optionality of the attribute Consent.provision.period [#255](https://github.com/ehealthsuisse/ch-epr-fhir/issues/255)
* integrate CH:ATC into this implementation guide [#257](https://github.com/ehealthsuisse/ch-epr-fhir/issues/257)
* Wrong AuditEvent action for the CH:MHD-1 transaction [#270](https://github.com/ehealthsuisse/ch-epr-fhir/issues/270)
* Upgrade to IHE mCSD v4.0.0-comment [#278](https://github.com/ehealthsuisse/ch-epr-fhir/issues/278)
* Update the PPQm-3 and PPQm-5 AuditEvents to BALP v1.1.3 [#278](https://github.com/ehealthsuisse/ch-epr-fhir/issues/278)
* Upgrade to IHE PDQm v3.1.0 [#281](https://github.com/ehealthsuisse/ch-epr-fhir/issues/281)
* MHD: document the use of `DocumentReference.content.attachment.url` [#276](https://github.com/ehealthsuisse/ch-epr-fhir/issues/276)
* MHD: invalid mapping of the creation time, remove date [#299](https://github.com/ehealthsuisse/ch-epr-fhir/issues/299)
* MHD: define the mapping of referenceIdList to context.related [#294](https://github.com/ehealthsuisse/ch-epr-fhir/issues/294)
* Remove targetId from the ITI-83 response [#269](https://github.com/ehealthsuisse/ch-epr-fhir/issues/269)
* Use a logical reference (EPR-SPID) to the patient in MHD [#269](https://github.com/ehealthsuisse/ch-epr-fhir/issues/269)
* Remove `DocumentReference.date` from the MHD profile [#274](https://github.com/ehealthsuisse/ch-epr-fhir/issues/274)
* Fix dependency to hl7.terminology [#290](https://github.com/ehealthsuisse/ch-epr-fhir/issues/290)
* IUA: Incorporate Access Token [ITI-72] not mentioned in the IUA profile [#249](https://github.com/ehealthsuisse/ch-epr-fhir/issues/249)
* IUA: Add Authenticate User transaction [#302](https://github.com/ehealthsuisse/ch-epr-fhir/issues/302) and upgrade versions [#300](https://github.com/ehealthsuisse/ch-epr-fhir/issues/300)   
* PPQm: Allow additional search criteria in CH:PPQ-5 [#289](https://github.com/ehealthsuisse/ch-epr-fhir/issues/289)
* ATNA: precise use of STX:HTTPS IUA [#307](https://github.com/ehealthsuisse/ch-epr-fhir/issues/307), [#267](https://github.com/ehealthsuisse/ch-epr-fhir/issues/267), [#265](https://github.com/ehealthsuisse/ch-epr-fhir/issues/265)
* CH MHD-1: wrong actor Document Recipient, should be Document Responder [#317](https://github.com/ehealthsuisse/ch-epr-fhir/issues/317)
* mCSD: add Bundle profile and allow only transaction in bundle [#315](https://github.com/ehealthsuisse/ch-epr-fhir/issues/315)
* PIXm: fix cardinality of the main user agent in ITI-104 Manager Update audit event [#330](https://github.com/ehealthsuisse/ch-epr-fhir/issues/330)

### DSTU4 Informative Ballot Release 2024-12-18 

#### Open Issues

* Unknown code '26' in the CodeSystem 'http://terminology.hl7.org/CodeSystem/object-role' version '1.0.0': waiting to be added, see [#190](https://github.com/ehealthsuisse/ch-epr-fhir/issues/190)
* in review: ITI-71: Conflict between OAuth2 scope and ITI-71 scope [#245](https://github.com/ehealthsuisse/ch-epr-fhir/issues/245)  

#### Resolved Issues

* IUA: fixed the supported scopes and grant_types in IUA Get Authorization Server Metadata [ITI-103] transaction [#292](https://github.com/ehealthsuisse/ch-epr-fhir/issues/292) and [#293](https://github.com/ehealthsuisse/ch-epr-fhir/issues/293). 
* IUA: fixed parameter naming in Get Access Token [ITI-71] transaction [#291](https://github.com/ehealthsuisse/ch-epr-fhir/issues/291).
* IUA: The Get Access Token Request [ITI-71] authorization code flow is extended with the option, to send an identity assertion (SAML or OpenID Connect) in the token request message, required to support SAML authentication [#258](https://github.com/ehealthsuisse/ch-epr-fhir/issues/258).
* IUA: The requirement to use mTLS in the Get Access Token Request [ITI-71] is removed. Client identification is now based on the client id, client secret and the signature of the request [#258](https://github.com/ehealthsuisse/ch-epr-fhir/issues/258).
* IUA: The use case descriptions are updated [#258](https://github.com/ehealthsuisse/ch-epr-fhir/issues/258).
* IUA: Moved all parameter not known by the authorization server from the scope to an extension of the Get Access Token \[ITI-71\] transaction to match the requirements of the underlying OAuth 2.1 specification [#245](https://github.com/ehealthsuisse/ch-epr-fhir/issues/245)
* switch deprecated discriminator type 'pattern' to 'value' [#239](https://github.com/ehealthsuisse/ch-epr-fhir/issues/239)
* set status for extensions, profiles and datatypes to active [#244](https://github.com/ehealthsuisse/ch-epr-fhir/issues/244)
* mCSD: add the feed transaction (CH:mCSD-1) [#158](https://github.com/ehealthsuisse/ch-epr-fhir/issues/158)
* mCSD: require only one identifier for organizations [#210](https://github.com/ehealthsuisse/ch-epr-fhir/issues/210)
* mCSD: set the system for LDAP DNs and add a slice to identifiers [#209](https://github.com/ehealthsuisse/ch-epr-fhir/issues/209)
* mCSD: add the community as example [#200](https://github.com/ehealthsuisse/ch-epr-fhir/issues/200)
* PIXm: allow requesting the EPR-SPID as only targetSystem in PIXm queries [#223](http://github.com/ehealthsuisse/ch-epr-fhir/issues/223)
* PDQm: fix the name search parameter [#212](https://github.com/ehealthsuisse/ch-epr-fhir/issues/212)
* PDQm: replace the ITI-78 transaction with the ITI-119 transaction [#224](https://github.com/ehealthsuisse/ch-epr-fhir/issues/224)
* MHD: fix minimal cardinality of extension slice in the SubmissionSet [#211](https://github.com/ehealthsuisse/ch-epr-fhir/issues/211)
* MHD: specify usage of token search parameters in ITI-67 [#221](https://github.com/ehealthsuisse/ch-epr-fhir/issues/221)
* MHD: make the DocumentReference title mandatory [#219](https://github.com/ehealthsuisse/ch-epr-fhir/issues/219)
* MHD: update the MHD version and date in references [#213](https://github.com/ehealthsuisse/ch-epr-fhir/issues/213)
* Audit: add example of AuditEvent with Trace Context [#186](https://github.com/ehealthsuisse/ch-epr-fhir/issues/186)
* Uniformize the _traceparent_ requirement wording on transaction pages [#236](https://github.com/ehealthsuisse/ch-epr-fhir/issues/236)

### DSTU4 Informative Ballot 2024 - Resolved Issues
* Relax Document Reference masterIdentifier requirements [#199](https://github.com/ehealthsuisse/ch-epr-fhir/issues/199)
* Adapt IHE profiles for the Trace Context support [#153](https://github.com/ehealthsuisse/ch-epr-fhir/issues/153)
* Remove XDS on FHIR option requirement for MHD [#193](https://github.com/ehealthsuisse/ch-epr-fhir/issues/193)
* clarified the use of the redirect-uri as callback URL [#189](https://github.com/ehealthsuisse/ch-epr-fhir/issues/189)
* new sequence diagram for publication hcp and tcu [#192](https://github.com/ehealthsuisse/ch-epr-fhir/issues/192)
* No Usage of contact (PersonalRelationship in V3), consistency between PIXV3, PDQV3 and PIXm, PDQm [#191](https://github.com/ehealthsuisse/ch-epr-fhir/issues/191)
* MHD Find Document Lists transaction [ITI-66] not applicable for EPR [#180](https://github.com/ehealthsuisse/ch-epr-fhir/issues/180)

### DSTU4 Informative Ballot 2024

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
