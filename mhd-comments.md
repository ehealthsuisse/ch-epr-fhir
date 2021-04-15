Issue for ch-epr-mhealth:
MHD_055: List.source does not allow for Organization which is needed for SubmissionSet.author. So created an extension (SourceOrg) to hold the SubmissionSet sourceId as a Reference(Organization).

Issues for MHD:

- package name 4.0.0-comment does not work with IG Publisher for dependent packages: Failed to resolve package ihe.mhd.fhir#4.0.0-comment from server: http://packages.fhir.org and  Error reading http://ihe.net/fhir/ihe.mhd.fhir/4.0.0-comment/package.tgz The issue is that current tooling does not accept suffix -comment. Use current as version instead.

- For MHD Rev. 3.2 – 2020-08-28 it was specified for Folder that "When the List.identifier carries the entryUUID, then the List.identifier.use shall be ‘official’. When the List.identifier carries the uniqueId, then the List.identifier.use shall be ‘usual’.", I propose this concept should be token over MHD List, because otherwise the identifers cannot be differentiated.

- There is no List ITI-66 response profile defined

- https://profiles.ihe.net/ITI/MHD/ITI-66.html: Document Consumer Requests a List Resources, matching the supplied set of criteria, from the Document Responder
  -> should it be  Requests List Resources (in 67 it is mentioned: Requests a list of DocumentReference Resources, matching the supplied set of criteria, from the Document Responder. )

- The Document Consumer executes an HTTP GET against the Document Responder List endpoint. 
-> Is the HTTP GET explicitly required, could it not be also a POST?


- Clarify https://profiles.ihe.net/ITI/MHD/4.0.0-comment/a_issues.html
  CP-ITI-1119: Made clear that Document Source must not populate any entryUUID.
  -> THis is not clear needs to be clarified

- https://profiles.ihe.net/ITI/MHD/4.0.0-comment/StructureDefinition-IHE.MHD.Comprehensive.ProvideBundle.html
entry:SubmissionSet		1..1	BackboneElement	the SubmissionSet
.... resource cardinality move from 0..1 to 1..1 in Submiss


- Error message for Provide a Document  Bundle
Slicing cannot be evaluated: Profile based discriminators must have a type with a profile (Bundle.entry:Documents.resource in profile http://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Comprehensive.ProvideBundle)
Bundle/2-7-BundleProvideDocument: Bundle.entry[0] (l12/c10)	error	Slicing cannot be evaluated: Profile based discriminators must have a type with a profile (Bundle.entry:Patient.resource in profile http://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Comprehensive.ProvideBundle)