There are no additional requirements for the Swiss EPR of the Find Document Lists [ITI-66] transaction
defined in the MHD Profile published in the IHE ITI Trial Implementation “Mobile Access to Health Documents”.
The SubmissionSet.Author.AuthorRole mapping to DocumentManifest has to be supported. The Document Responder
does not need to support the FindFolders Query from the XDS on FHIR Option. 

### Scope

The Find Document Lists [ITI-66] transaction is used to find List Resources
that satisfy a set of parameters. It is equivalent to the FindSubmissionSets query in the Registry
Stored Query [ITI-18] transaction, as documented in [ITI TF-2a: 3.18.4.1.2.3.7.2](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html#3.18.4.1.2.3.7.2). The result of the query is a Bundle containing List Resources that match the query parameters.

### Actor Roles

**Actor:** Document Consumer   
**Role:** Requests List Resources, matching the supplied set of criteria, from the Document Responder   
**Actor:** Document Responder   
**Role:** Returns List Resources that match the search criteria provided by the Document Consumer   

### Referenced Standards

[Mobile access to Health Documents (MHD), 2021-03-31, public comment release](https://profiles.ihe.net/ITI/MHD/4.0.0-comment/)   
This MHD Profile is based on Release 4 of the [HL7® FHIR®](https://www.hl7.org/fhir/index.html) standard.

### Messages

<div>{% include MHD_ActorDiagram_ITI-66.svg %}</div>
<div><figcaption>Interaction diagram for [ITI-66]</figcaption></div>  

### Trigger Events

When the Document Consumer needs to discover List Resources matching various metadata parameters it issues a Find Document Lists message.

### Message Example

Find Document List **request**:
```
GET [base]/List?patient.identifier=urn:oid:2.999|11111111 HTTP/1.1
Accept: application/fhir+json
```

See [Bundle example](Bundle-Bundle-FindSubmissionSets.html) (and the corresponding [profile](StructureDefinition-ch-mhd-submissionset-comprehensive-bundle.html)) as **response** to the Find Document Manifest request.

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Document Responder using IUA profile with extended access token. Consequently
the Find Document Lists [ITI-66] request must authorize using the Incorporate Access Token [ITI-
72] transaction of the IUA profile.