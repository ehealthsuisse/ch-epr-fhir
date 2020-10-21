There are **no additional requirements** for the Swiss EPR extension for the Swiss EPR of the Retrieve Document
[ITI-68] transaction defined in the MHD Profile which is published in the IHE ITI Trial Implementation
“Mobile Access to Health Documents”.

### Scope

The Retrieve Document [ITI-68] transaction is used by the Document Consumer to retrieve a
document from the Document Responder. 

### Actor Roles

**Actor:** Document Consumer   
**Role:** Requests a document from the Document Responder.   
**Actor:** Document Responder   
**Role:** Serves the document to the Document Consumer.   

### Referenced Standards

[Mobile access to Health Documents (MHD) With XDS on FHIR Rev. 3.1 – 2019-03-06](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_MHD.pdf)   

This MHD Profile is based on Release 4 of the emerging [HL7® FHIR®](https://www.hl7.org/fhir/index.html) standard.

### Messages

{% include img.html img="MHD_ActorDiagram_ITI-68.plantuml.png" width="40%" %}

### Trigger Events

The Document Consumer wants to obtain a document. 

### Message Semantics
The Document Consumer sends a HTTP GET **request** to the server. The Document Consumer
request may be to retrieve the document content referenced by a
`DocumentReference.content.attachment.url`. 

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Patient Identity Manager using IUA profile with basic access token. Consequently
the Retrieve Document [ITI-68] request must authorize using the Incorporate Authorization Token [ITI-72]
transaction of the IUA profile.