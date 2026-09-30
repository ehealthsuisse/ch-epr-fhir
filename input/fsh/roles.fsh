// Roles and participants of the electronic health dossier (E-GD).
//
// The eHealth role code system of the EPR (`urn:oid:2.16.756.5.30.1.127.3.10.6`, ChEhealthCodesystemRole in CH Term)
// still carries the two administrator roles DADM (Document Administrator) and PADM (Policy Administrator), and it has
// no code for the legal representative. As long as CH Term cannot be changed, the full role list of the E-GD is
// defined here.
//
// TODO: the OID `2.16.756.5.30.1.127.3.10.19` of the code system below is NOT registered yet. It has to be registered
// with eHealth Suisse before this implementation guide is published, and the code system should move to CH Term once it
// can be maintained there.
//
// `.19` is the first free number above the highest one assigned in the branch `2.16.756.5.30.1.127.3.10`.

CodeSystem: HealthDossierRole
Id: HealthDossierRole
Title: "CH Health Dossier Role"
Description: "The roles of the electronic health dossier (E-GD). Successor of the eHealth role code system of the EPR
(`urn:oid:2.16.756.5.30.1.127.3.10.6`): the two administrator roles Document Administrator (`DADM`) and Policy
Administrator (`PADM`) are replaced by the single role `ADM`, and the legal representative (`LEGREP`) is added."
* ^url = "urn:oid:2.16.756.5.30.1.127.3.10.19"
* ^caseSensitive = true
* ^experimental = false
* ^content = #complete

* #PAT "Patient" "The holder of an electronic health dossier."
* #PAT ^designation[+].language = #de-CH
* #PAT ^designation[=].value = "Patientin oder Patient"

* #REP "Representative" "A person designated by the holder as their representative, with the rights the holder has
granted them (Art. 11 para. 5 EGDG)."
* #REP ^designation[+].language = #de-CH
* #REP ^designation[=].value = "Vertretung"

* #LEGREP "Legal representative" "A person exercising the rights of a holder who is a minor or who lacks capacity of
judgement (Art. 12 EGDG). Unlike a representative designated by the holder (`REP`), the rights follow from the law and
not from a grant by the holder."
* #LEGREP ^designation[+].language = #de-CH
* #LEGREP ^designation[=].value = "Gesetzliche Vertretung"

* #HCP "Healthcare professional" "A health professional treating the holder."
* #HCP ^designation[+].language = #de-CH
* #HCP ^designation[=].value = "Gesundheitsfachperson"

* #ASS "Assistant" "A person a health professional or a health institution calls on to process data on their behalf
(Art. 26 EGDG)."
* #ASS ^designation[+].language = #de-CH
* #ASS ^designation[=].value = "Hilfsperson"

* #TCU "Technical user" "A technical user acting without a natural person behind the request."
* #TCU ^designation[+].language = #de-CH
* #TCU ^designation[=].value = "Technischer Benutzer"

* #ADM "Administration" "A person processing data or setting access permissions on the mandate of the holder. Replaces
the two administrator roles of the EPR, Document Administrator (`DADM`) and Policy Administrator (`PADM`): Art. 15
para. 1 EGDG entrusts the data processing (Art. 11 para. 1-3 and 5 EGDG) and the data correction (Art. 8 para. 1 let. b
EGDG) to one and the same mandate, without separating the two."
* #ADM ^designation[+].language = #de-CH
* #ADM ^designation[=].value = "Administration"


ValueSet: HealthDossierParticipant
Id: HealthDossierParticipant
Title: "CH Health Dossier Participant"
Description: "The participants of a transaction on the electronic health dossier: the roles of the E-GD together with
the group of health professionals (`GRP`). Replaces the value set EprParticipant, which still carried the two
administrator roles `DADM` and `PADM`."
* ^experimental = false

* include codes from system HealthDossierRole
* $ehealthAgentRole#GRP "Group"


ValueSet: HealthDossierAuthorRole
Id: HealthDossierAuthorRole
Title: "CH Health Dossier Author Role"
Description: "The role of the author of a document or of a submission set. Successor of the CH Term value sets
DocumentEntry.originalProviderRole (Annex 3 EPDV-EDI §2.14) and SubmissionSet.Author.AuthorRole (§2.16): the Document
Administrator (`DADM`) is replaced by `ADM`, and `LEGREP` is added. Unlike HealthDossierParticipant this value set does
not contain the group of health professionals (`GRP`), which cannot be the author of a document."
* ^experimental = false

* include codes from system HealthDossierRole
