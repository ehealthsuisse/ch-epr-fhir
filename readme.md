# CH EPR mHealth
The national IHE extensions documented in this FHIR implementation guide shall be used in conjunction with the definitions of integration profiles, actors and transactions provided in Volumes 1 through 3 of the IHE IT Infrastructure Technical Framework.


## Building the Diagrams
[PlantUML](http://plantuml.com/) is used to generate the sequence diagrams. Execute the shell script ./do-it.sh


## Source Information
The profiles of the FHIR implementation guide CH EPR mHealth are derived from existing IHE profiles. Therefore they have been imported into the implementation guide. The sources of the profiles and their dependencies are listed below.

### PMIR

#### IHE Structure Definitions
The IHE profiles are imported from https://github.com/IHE/fhir.
* structuredefinition-IHE.PMIR.Bundle
   * structuredefinition-IHE.PMIR.MessageHeader
   * structuredefinition-IHE.PMIR.BundleHistory   
* structuredefinition-IHE.PMIR.Patient.Merge
* structuredefinition-IHE.PMIR.Patient.RelatedPerson
* structuredefinition-IHE.PMIR.Subscription
   * structuredefinition-IHE.PMIR.Subscription.request

#### CH EPR mHealth Structure Definitions
* structuredefinition-ch-pmir-bundle **is derived from** IHE.PMIR.Bundle
   * structuredefinition-ch-pmir-patient
      * structuredefinition-ch-epr-mhealth-humanname
      * structuredefinition-ch-epr-mhealth-birthname
      * structuredefinition-ch-pmir-provicer-organization


### MHD

#### IHE Structure Definitions
The IHE profiles are imported from https://github.com/IHE/ITI.MHD ([FHIR IG (CI Build)](http://build.fhir.org/ig/IHE/ITI.MHD/branches/master/index.html)).

* IHE.MHD.ProvideDocumentBundle.Comprehensive 
   * IHE.MHD.Comprehensive.List
      * IHE.MHD.Minimal.List
   * IHE.MHD.Provide.Comprehensive.DocumentReference + IHE.MHD.Query.Comprehensive.DocumentReference
      * IHE.MHD.Provide.Minimal.DocumentReference
   * IHE.MHD.Comprehensive.DocumentManifest
      * IHE.MHD.Minimal.DocumentManifest


#### CH EPR mHealth Structure Definitions
* structuredefinition-ch-mhd-providedocumentbundle-comprehensive **is adapted from** IHE.MHD.ProvideDocumentBundle.Comprehensive
   * structuredefinition-ch-mhd-comprehensive-documentmanifest **is adapted from** IHE.MHD.Comprehensive.DocumentManifest
      * structuredefinition-ch-ext-author-authorrole
   * structuredefinition-ch-mhd-provide-comprehensive-documentreference **is adapted from** IHE.MHD.Provide.Comprehensive.DocumentReference
      * structuredefinition-ch-ext-deletionstatus
      * structuredefinition-ch-mhd-query-comprehensive-documentreference **is adapted from** IHE.MHD.Query.Comprehensive.DocumentReference







