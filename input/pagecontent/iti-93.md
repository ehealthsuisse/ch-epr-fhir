### Scope

The Mobile Patient Identity Feed transaction sends a FHIR Bundle of new and updated Patient Resources.

### Actor Roles

**Actor:** Supplier played by Patient Identity Source   
**Role:** Registers data of a specific patient in the Patient Identity Manager.   
**Actor:** Consumer played by Patient Identity Manager   
**Role:** Stores the patient data provided with the request and assigns it to or creates a master patient record and a MPI-PID.   

### Referenced Standards

[Patient Master Identity Registry (PMIR) – Revision 1.1 – December 5, 2019](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_PMIR.pdf)   
Approved CP 1197-04 PMIR – Update to Message Semantics for ITI-93 Mobile Patient Identity Feed   
Approved CP 1198-01 PMIR – Clarify Patient Identity Manager return in merge/delete case

### Messages

<div>{% include PMIR_ActorDiagram_ITI-93.svg %}</div>

### Trigger Events

A Supplier triggers a Mobile Patient Identity Feed request to a Consumer when patients are created, updated,
merged, or deleted.

### Message Semantics

The same message semantic apply as in 3.93.4.1.2 Message Semantics of the CP-ITI-1197.

The patient data (see [Patient example](Patient-PatientPmirFeed.html)) shall be conformant to the CH-PMIR Patient profile with the canonical url
[http://fhir.ch/ig/ch-epr-mhealth/StructureDefinition/ch-pmir-patient](StructureDefinition-ch-pmir-patient.html). 
If the patient is already registered in a community, the MPI-PID SHALL be provided as an identifier. The EPR-SPID 
as an identifier MAY be added. The birthname can be added with the ISO 21090 qualifier extension, the religion MUST
not be added.

### Expected Actions Consumer played by Patient Identity Manager

If the MPI-PID is provided as an identifier the Patient Identity Manger SHALL use the MPI-PID to correlate
the patient in the community.

### Message Example

See [Bundle example](Bundle-BundlePmirFeed.html) (and the corresponding [profile](StructureDefinition-ch-pmir-bundle.html)) for the Mobile Patient Identity Feed **request**.   
See [Bundle example](Bundle-BundlePmirResponse.html) (and the corresponding [profile](StructureDefinition-ch-pmir-bundle-response.html)) for the Mobile Patient Identity Feed **response**.

### Security Consideration
TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Patient Identity Manager using IUA profile with basic access token. Consequently
the Mobile Patient Identity Feed [ITI-93] request must authorize using the Incorporate Access Token
[ITI-72] transaction of the IUA profile.