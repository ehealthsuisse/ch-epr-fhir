There are **no additional requirements** for the Swiss EPR of the Find Document Manifests [ITI-66] transaction
defined in the MHD Profile published in the IHE ITI Trial Implementation “Mobile Access to Health Documents”.
The SubmissionSet.Author.AuthorRole mapping to DocumentManifest has to be supported.

### Scope

The Find Document Manifests [ITI-66] transaction is used to find DocumentManifest Resources
that satisfy a set of parameters. It is equivalent to the FindSubmissionSets query in the Registry
Stored Query [ITI-18] transaction, as documented in ITI TF-2a: 3.18.4.1.2.3.7.1. The result of
the query is a Bundle containing DocumentManifest Resources that match the query parameters.

### Actor Roles

**Actor:** Document Consumer   
**Role:** Requests a list of DocumentManifest Resources, matching the supplied set of criteria, from the Document Responder.   
**Actor:** Document Responder   
**Role:** Returns DocumentManifest Resources that match the search criteria provided by the Document Consumer.   

### Referenced Standards

[Mobile access to Health Documents (MHD) With XDS on FHIR Rev. 3.1 – 2019-03-06](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_MHD.pdf)   

This MHD Profile is based on Release 4 of the emerging [HL7® FHIR®](https://www.hl7.org/fhir/index.html) standard.

### Messages

{% include img.html img="MHD_ActorDiagram_ITI-66.plantuml.png" width="40%" %}

### Trigger Events

When the Document Consumer needs to discover DocumentManifest Resources matching
various metadata parameters it issues a Find Document Manifests message. 

### Message Example

Find Document Manifest **request**:
```
GET [base]/DocumentManifest?patient.identifier=urn:oid:2.999|11111111 HTTP/1.1
Accept: application/fhir+json
```

See [Bundle example](Bundle-Bundle-FindDocumentManifests.html) (and the corresponding [profile](StructureDefinition-ch-mhd-comprehensive-documentmanifest-bundle.html)) as **response** to the Find Document Manifest request.

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Document Responder using IUA profile with extended access token. Consequently
the Finde Document Manifest [ITI-66] request must authorize using the Incorporate Access Token [ITI-
72] transaction of the IUA profile.