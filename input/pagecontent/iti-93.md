### Scope

The Mobile Patient Identity Feed transaction sends a FHIR Bundle of new and updated Patient Resources.

### Actor Roles

**Actor:** Supplier played by Patient Identity Source   
**Role:** Registers data of a specific patient in the Patient Identifier Cross-reference Manager.   
**Actor:** Consumer played by Patient Identifier Cross-reference Manager   
**Role:** Stores the patient data provided with the request and assigns it to or creates a master patient record and a MPI-PID.   

### Referenced Standards

[Patient Identifier Cross-reference for Mobile (PIXm), Rev. 2.1 – Trial Implementation, December 5, 2019](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_PIXm.pdf)
[Patient Master Identity Registry (PMIR) – Revision 1.1 – December 5, 2019](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_PMIR.pdf)   

### Messages

<div>{% include PMIR_ActorDiagram_ITI-93.svg %}</div>

### Trigger Events

A Supplier triggers a Mobile Patient Identity Feed request to a Consumer when patients are created, updated,
merged, or deleted.

### Message Semantics

The same message semantic apply as in 3.93.4.1.2 Message Semantics.

The patient data (see [Patient example](Patient-PatientPIXmFeed.html)) shall be conformant to the CH:PIXm Patient profile with the canonical url
[http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/ch-pixm-patient](StructureDefinition-ch-pixm-patient.html). 
If the patient is already registered in a community, the MPI-PID SHALL be provided as an identifier. The EPR-SPID 
as an identifier MAY be added. The birthname can be added with the ISO 21090 qualifier extension, the religion MUST
not be added.

### Expected Actions Consumer played by Patient Identifier Cross-reference Manager

If the MPI-PID is provided as an identifier the Patient Identity Manger SHALL use the MPI-PID to correlate
the patient in the community.

### Message Example

See [Bundle example](Bundle-BundlePIXmFeed.html) (and the corresponding [profile](StructureDefinition-ch-pixm-bundle.html)) for the Mobile Patient Identity Feed **request**.   
See [Bundle example](Bundle-BundlePIXmResponse.html) (and the corresponding [profile](StructureDefinition-ch-pixm-bundle-response.html)) for the Mobile Patient Identity Feed **response**.

### Security Consideration
TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Patient Identifier Cross-reference Manager using IUA profile with basic access token. Consequently
the Mobile Patient Identity Feed [ITI-93] request must authorize using the Incorporate Access Token
[ITI-72] transaction of the IUA profile.