### DSTU1 Release 2026-08-xx

#### Resolved Issues
* Integrated the ch-epr-fhir issues [#456](https://github.com/ehealthsuisse/ch-epr-fhir/issues/456), [#458](https://github.com/ehealthsuisse/ch-epr-fhir/issues/458) and [#460](https://github.com/ehealthsuisse/ch-epr-fhir/issues/460)
* IUA
  * Refactored the specification to use the IUA client credential flow for portals, primary systems and digital health apps and convey 
    the Identity Token in in the *id_token* field of the token request. 
  * Add support for client-asymmetric authentication specified in FHIR Backend Service authentication section and is used in the European Health Data Space and UMZH Connect.  
  * Removed the SMART on FHIR standalone and EHR launch option. 
  * Removed the specification of the TCU option, the separate token flow for technical users, since TCU requests are
    now usual client credential requests without an identity token of a user. The `TCU` role and the onboarding checks
    for clinical archive systems in [ITI-71](iti-71.html#clinical-archive-systems) remain. 
  * Updated the `subject_role` scope and claim in [ITI-71](iti-71.html) to the code system
    [CH Health Dossier Role](CodeSystem-HealthDossierRole.html) (`2.16.756.5.30.1.127.3.10.19`) with all roles
    (`PAT`, `REP`, `LEGREP`, `HCP`, `ASS`, `TCU`, `ADM`), corrected `LREP` to `LEGREP` and the role of the assistant
    in the JWT example to `ASS`.
  * Corrected the `purpose_of_use` system in the JWT examples of [ITI-71](iti-71.html) from
    `urn:uuid:2.16.756.5.30.1.127.3.10.5` to `urn:oid:2.16.756.5.30.1.127.3.10.5`.
  * Replaced the CH:XUA Authenticate User transaction with the user authentication specified in
    [OpenID Connect](openid-connect.html): the IUA Authorization Client authenticates the user at the Identity Provider
    as Relying Party and conveys the identity token in the `id_token` parameter of [ITI-71](iti-71.html); updated the
    IUA actor diagram accordingly.
  * Changed the [ITI-71](iti-71.html) token request example of a clinical archive system from a basic to an extended
    access token with `person_id`, since the clinical archive knows the EPR-SPID and no longer queries it with PIXm ITI-83.
  * Replaced the remarks referring to the removed Workflow Initiator Option and Technical User Option in the required
    actor groupings with the transactions a technical user (`TCU`) may use: ITI-65 and CH:MHD-2 of the MHD Document
    Source and ITI-20, not allowed for all other IUA Authorization Clients. Added the rule to reject `TCU` access tokens
    for other transactions in [Enforcement of Access Rules](accesscontrol.html#technical-users).
  * Updated the `user_id` table of the JWT `ch_epr` extension in [ITI-71](iti-71.html): merged the Document
    Administrator and Policy Administrator into Administration (`ADM`) with the qualifier
    `urn:e-health-suisse:administrator-id`, added the Legal Representative (`LEGREP`) with the qualifier
    `urn:e-health-suisse:representative-id`, and corrected the swapped administrator qualifiers.
  * [ITI-65](iti-65.html#documententryoriginalproviderrole): the originalProviderRole SHALL NOT be changed with
    CH:MHD-1 (instead of the XDS Metadata Update actors Update Initiator and Document Administrator), added legal
    representatives and the administration, and linked the AuthorRole and originalProviderRole to the value set
    [CH Health Dossier Author Role](ValueSet-HealthDossierAuthorRole.html) instead of the CH Term value sets.
* Corrections
  * The audit event examples of the MHD, PIXm, PDQm, mCSD and PPQm transactions carry the role of the healthcare
    professional in the code system [CH Health Dossier Role](CodeSystem-HealthDossierRole.html)
    (`urn:oid:2.16.756.5.30.1.127.3.10.19`) instead of the EPR code system `urn:oid:2.16.756.5.30.1.127.3.10.6`.
  * The ATNA audit event examples name the server-side actor (audit source and destination agent) after the serving
    system instead of `Community A`: `Health Dossier` for MHD, `MPI` for PIXm and PDQm, `HPD` for mCSD, `Policy Repository` for PPQm.
  * Removed the mTLS alternative from the security considerations of [ITI-90](iti-90.html) and [ITI-20](iti-20.html),
    the transactions are authorized with a basic access token.
  * Fixed the broken links to the message semantics and to the SMART on FHIR scopes in [ITI-71](iti-71.html).
  * The MHD Document Responder is grouped with the IUA Resource Server (was IUA Authorization Client), see
    [MHD](iti-mhd.html#required-actor-groupings).
  * Corrected the scope of [CH:MHD-1](ch-mhd-1.html) (Document Source instead of Document Consumer) and removed a
    duplicated sentence.
  * Distinct titles for the PPQm code systems and value sets with the same title.
* OpenID Connect
  * Added the OpenID Connect page (Annex 8) specifying the authorization code flow, identity token, UserInfo and RP-initiated logout for EPR Identity Providers.
* Sequence diagrams
  * Removed the SMART on FHIR sequence diagrams for patients and healthcare professionals (EHR launch).
  * Removed the mTLS option, the IUA JWT token option is now the regular IUA flow with the extended access token.
  * Removed the ITI-83 PIXm query from the clinical archive diagram, the clinical archive knows the EPR-SPID.
  * Removed the loop over confidentiality codes when publishing documents.
  * Removed the unused diagram sources for the SMART on FHIR standalone launch with the identity provider.
* mCSD
  * [Examples](iti-mcsd.html#examples): removed the link to the eHealth Suisse test data (Community A and B) and
    cropped the picture of the example structure to the health institutions and health professionals, the
    communities are no longer shown.
  * Removed the community information from the mCSD examples: the Organization example of Community A and its note
    that the community itself is not returned, since health institutions and health professionals are no longer
    related to a community.
  * Removed the LDAP identifiers (`urn:ietf:rfc:4514`, the DN of the HPD entry) from the profiles
    [CH mCSD Organization](StructureDefinition-CH.mCSD.Organization.html),
    [CH mCSD Practitioner](StructureDefinition-CH.mCSD.Practitioner.html) and
    [CH mCSD PractitionerRole](StructureDefinition-CH.mCSD.PractitionerRole.html), from all mCSD examples and from the
    LDAP schema mappings, together with the profile LdapIdentifier and the NamingSystem LDAP. Removed the considerations
    for implementing mCSD with an LDAP backend (HPD) from [ITI-130](iti-130.html). The informative mapping to the LDAP
    schema of the HPD in the profiles is kept.
* PDQm
  * Defined mapping for eCH-0215 / 213 (https://github.com/ehealthsuisse/ch-health-dossier/issues/7)
  * Added support for identifying a patient by the minimal demographics and the AHVN13 in ITI-119 to retrieve the EPR-SPID (https://github.com/ehealthsuisse/ch-health-dossier/issues/2)
* PIXm
    * Removed ITI-83 Query (no local-id cross-referencing) 
    * Restricted ITI-104 Feed to allow only update of contact information (revise message), requires extended access token
* MHD 
  * Removing Federated Option, Proxy Option and homeCommunityId 
  * Require Minimal Data based on Health Dossier Metadata Option
  * Replaced the CH:ADR Authorization Decision Consumer grouping in ITI-65,  ITI-67, ITI-68, CH:MHD-1 and ITI-81 with the
    new [Appendix: Enforcement of Access Rules](accesscontrol.html), covering the access rules of the patient and of the
    requesting health professional or health institution
  * Added the CH MHD DocumentReference profile to the Volume 3 menu
  * Required `DocumentReference.author` (1..*) and required it to be identified either by a logical reference carrying
    the identifier of the authoring person or institution in `author.identifier` — analogous to `subject.identifier`
    carrying the EPR-SPID, typically a GLN, or an EPR-SPID for a patient author — or by a reference to a resource,
    contained or held elsewhere (invariant `ch-mhd-author-1`). 
  * Removed DocumentReference.sourcePatientInfo and authorSpeciality requirement
  * Required the ITI-65 FHIR Documents Publish Option for the Document Source and the Document Recipient, so that a
    FHIR document can be published as a FHIR document Bundle resource in the `FhirDocuments` entry of the
    [CH MHD Provide Document Bundle](StructureDefinition-ch-mhd-providedocumentbundle.html) instead of being converted
    to a base64 encoded Binary resource, see [ITI-65](iti-65.html#publishing-a-fhir-document). Required in
    [ITI-68](iti-68.html#expected-actions) that a FHIR document is returned as a native FHIR document Bundle resource
    and not wrapped in a Binary resource, in line with the European Health Data API. Added the example
    [Provide Document Bundle for a FHIR document](Bundle-BundleProvideFhirDocument.html).
  * Added the use case [Healthcare professional corrects a published document](iti-mhd.html#use-cases): a
    document with incorrect data is corrected by publishing a new version, the incorrect document is not removed and
    stays accessible; how the corrected document is published is described in
    [ITI-65](iti-65.html#correction-of-a-published-document). Added the examples
    [Provide Document Bundle for a corrected document](Bundle-BundleProvideDocumentCorrection.html)
    (`DocumentReference.relatesTo` of type `replaces`) and
    [replaced document with status superseded](DocumentReference-DocRefPdfSuperseded.html).
  * Added the transaction [Purge Document [CH:MHD-2]](ch-mhd-2.html) with the synchronous operation
    [`DocumentReference/[id]/$purge`](OperationDefinition-CHMhdPurge.html), modelled after the R6 `Patient/$purge`
    operation, which irrevocably removes a document with all versions of its metadata. It replaces requesting the
    deletion with CH:MHD-1 by setting the DeletionStatus extension to `deletionRequested`; the DeletionStatus
    extension itself is kept for now.
  * Removed the List resource (SubmissionSet) from the Document Consumer CapabilityStatement, since Find Document
    Lists [ITI-66] is not available.
  * Added the use case [Healthcare professional deletes a document published for the wrong person](iti-mhd.html#use-cases): the
    document has to be deleted, and the health professional or health institution which published it deletes it with
    [CH:MHD-2](ch-mhd-2.html).
  * Added the use case [Patient deletes a document](iti-mhd.html#use-cases): the patient can have any document of
    their health dossier deleted, the ones they recorded themselves as well as the ones a health professional or
    health institution published, with [CH:MHD-2](ch-mhd-2.html).
  * Added the use case [Patient adds a personal note to a document](iti-mhd.html#use-cases): where patient and author
    do not agree on the correctness of a document, or the author is no longer practising, the patient can record a
    personal note on the document, without a new version of the document. The note is recorded with
    [CH:MHD-1](ch-mhd-1.html#recording-a-personal-note) in the new extension
    [CH Extension Personal Note](StructureDefinition-ch-ext-personalnote.html), which carries an `Annotation` with the
    text of the note, the patient it belongs to and the time it was recorded; a document carries at most one personal
    note. It is not recorded in
    `DocumentReference.description`, which carries the comment of the author of the document. Added the example
    [DocumentReference with a personal note](DocumentReference-DocRefPdfPersonalNote.html).
  * Stated in [CH:MHD-1](ch-mhd-1.html#metadata-which-may-be-updated) which metadata may be updated by which role:
    the confidentiality code and the personal note by `PAT`, `REP`, `LEGREP` and `ADM`; every other change requires a
    new version of the document. A request updating other metadata, or metadata the role of the requester may not
    update, is rejected with an UnmodifiableMetadataError
  * [#9](https://github.com/ehealthsuisse/ch-health-dossier/issues/9): Required the
    [Full-Text Search Option](iti-mhd.html#full-text-search-option) for the Document Responder (optional for the Document Consumer);
    the Document Responder SHALL support the `full-text` search parameter in [ITI-67](iti-67.html#full-text-search-option),
    added to the MHD Document Consumer and Document Responder CapabilityStatements.
    Grouped the actor options table per actor. Needs update to the to be published MHD release.
* Roles
  * Added the CodeSystem [CH Health Dossier Role](CodeSystem-HealthDossierRole.html)
    (`urn:oid:2.16.756.5.30.1.127.3.10.19`) with the roles of the E-GD, succeeding the CH Term code system for eHealth
    roles (`urn:oid:2.16.756.5.30.1.127.3.10.6`): the two administrator roles Document Administrator (`DADM`) and
    Policy Administrator (`PADM`) are replaced by the single role `ADM` (Administration), and `LEGREP` (Gesetzliche
    Vertretung) is added for the legal representative of a minor or of a person lacking capacity of judgement, as
    distinct from a representative designated by the holder (`REP`). The OID still has to be registered with
    eHealth Suisse
  * Replaced the ValueSet `EprParticipant` with [CH Health Dossier Participant](ValueSet-HealthDossierParticipant.html),
    which combines the roles above with the group of health professionals (`GRP`), and repointed the bindings of
    `AuditEvent.agent.role` and `AuditEvent.entity.role` in the ATC audit event profiles to it
  * Rebound the extension [CH Extension Author AuthorRole](StructureDefinition-ch-ext-author-authorrole.html) to the new
    ValueSet [CH Health Dossier Author Role](ValueSet-HealthDossierAuthorRole.html), replacing the CH Term value set
    DocumentEntry.originalProviderRole; the group of health professionals (`GRP`) is not part of it, since a group
    cannot be the author of a document (the canonical url changed anyway, but it is also a breaking change)
* Fork from [CH EPR FHIR](https://fhir.ch/ig/ch-epr-fhir/5.0.0/), rename to CH Health Dossier