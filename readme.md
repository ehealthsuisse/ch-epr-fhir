# CH EPR mHealth
The national IHE extensions documented in this FHIR implementation guide shall be used in conjunction with the definitions of integration profiles, actors and transactions provided in Volumes 1 through 3 of the IHE IT Infrastructure Technical Framework.


## Building the Diagrams
[PlantUML](http://plantuml.com/) is used to generate the sequence diagrams. Execute the shell script ./do-it.sh


## Source Information
The profiles of the FHIR implementation guide CH EPR mHealth are **derived** or **copied and adapted** from existing IHE profiles. Therefore they have been **imported** into the implementation guide. The sources of the structure definitions, operation definitions and capability statements and their dependencies are listed below.


### Structure Definitions

#### PMIR: IHE Structure Definitions
The IHE profiles are **imported** from https://github.com/IHE/fhir (as of Aug 13, 2020).

* structuredefinition-IHE.PMIR.Bundle
   * structuredefinition-IHE.PMIR.MessageHeader
   * structuredefinition-IHE.PMIR.BundleHistory   
* structuredefinition-IHE.PMIR.Patient.Merge
* structuredefinition-IHE.PMIR.Patient.RelatedPerson
* structuredefinition-IHE.PMIR.Subscription
   * structuredefinition-IHE.PMIR.Subscription.request

#### PMIR: CH EPR mHealth Structure Definitions
* structuredefinition-ch-pmir-bundle **is derived from** (`baseDefinition`) IHE.PMIR.Bundle
* structuredefinition-ch-pmir-patient
   * structuredefinition-ch-epr-mhealth-humanname
   * structuredefinition-ch-epr-mhealth-birthname
   * structuredefinition-ch-pmir-provider-organization

#### MHD: IHE Structure Definitions
The IHE profiles are **imported** from https://github.com/IHE/ITI.MHD ([FHIR IG (CI Build)](http://build.fhir.org/ig/IHE/ITI.MHD/branches/master/index.html)) (as of Aug 7, 2020).

* IHE.MHD.ProvideDocumentBundle.Comprehensive 
   * IHE.MHD.Comprehensive.List
      * IHE.MHD.Minimal.List
   * IHE.MHD.Provide.Comprehensive.DocumentReference + IHE.MHD.Query.Comprehensive.DocumentReference
      * IHE.MHD.Provide.Minimal.DocumentReference
   * IHE.MHD.Comprehensive.DocumentManifest
      * IHE.MHD.Minimal.DocumentManifest

#### MHD: CH EPR mHealth Structure Definitions
* structuredefinition-ch-mhd-providedocumentbundle-comprehensive **is copied from** IHE.MHD.ProvideDocumentBundle.Comprehensive **and adapted to Swiss requirements** 
   * structuredefinition-ch-mhd-comprehensive-documentmanifest **is copied from** IHE.MHD.Comprehensive.DocumentManifest **and adapted to Swiss requirements**
      * structuredefinition-ch-ext-author-authorrole
   * structuredefinition-ch-mhd-provide-comprehensive-documentreference **is copied from** IHE.MHD.Provide.Comprehensive.DocumentReference **and adapted to Swiss requirements**
      * structuredefinition-ch-ext-deletionstatus
      * structuredefinition-ch-mhd-query-comprehensive-documentreference **is copied from** IHE.MHD.Query.Comprehensive.DocumentReference **and adapted to Swiss requirements**

#### Validation
To support **conformance** to the IHE profiles, the following validation mechanisms are added in this Implementation Guide:

* The examples are validated against both profiles (CH EPR mHealth, IHE) (listed in meta.profile)
* The profiles (CH EPR mHealth) check the conformity to the corresponding IHE profile using constraints (conformsTo)


### Operation Definitions

#### PMIR: IHE Operation Definitions
The IHE operation definitions are **imported** from https://github.com/IHE/fhir (as of Aug 13, 2020).

* operationdefinition-IHE.PIXm.pix

#### PMIR: CH EPR mHealth Operation Definitions
* operationdefinition-CH.PMIR **is copied from** IHE.PIXm.pix **and adapted to Swiss requirements**

