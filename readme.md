# CH EPR mHealth
The national IHE extensions documented in this FHIR implementation guide shall be used in conjunction with the definitions of integration profiles, actors and transactions provided in Volumes 1 through 3 of the IHE IT Infrastructure Technical Framework.


## Building the Diagrams
[PlantUML](http://plantuml.com/) is used to generate the sequence diagrams. Execute the shell script ./do-it.sh


## Source Information
The profiles of the FHIR implementation guide CH EPR mHealth are **derived** or **copied and adapted** from existing IHE profiles. Therefore they have been **imported** into the implementation guide. The sources of the structure definitions, operation definitions and capability statements and their dependencies are listed below.

* https://github.com/IHE/fhir
* https://github.com/IHE/ITI.MHD ([FHIR IG (CI Build)](http://build.fhir.org/ig/IHE/ITI.MHD/branches/master/index.html))
* https://github.com/JohnMoehrke/ITI.PIXm ([FHIR IG (CI Build)](http://build.fhir.org/ig/JohnMoehrke/ITI.PIXm/branches/master/index.html))


### Structure Definitions

#### PMIR: IHE Structure Definitions
The IHE profiles are **imported** from https://github.com/IHE/fhir (as of Aug 13, 2020).

* IHE.PMIR.Bundle
   * IHE.PMIR.MessageHeader
   * IHE.PMIR.BundleHistory   
* IHE.PMIR.Patient.Merge
* IHE.PMIR.Patient.RelatedPerson
* IHE.PMIR.Subscription
   * IHE.PMIR.Subscription.request

#### PMIR: CH EPR mHealth Structure Definitions
* ch-pmir-bundle **is derived from** (`baseDefinition`) IHE.PMIR.Bundle
* ch-pmir-patient
   * ch-epr-mhealth-humanname
   * ch-epr-mhealth-birthname
   * ch-pmir-provider-organization

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
* ch-mhd-providedocumentbundle-comprehensive **is copied from** IHE.MHD.ProvideDocumentBundle.Comprehensive **and adapted to Swiss requirements** 
   * ch-mhd-comprehensive-documentmanifest **is copied from** IHE.MHD.Comprehensive.DocumentManifest **and adapted to Swiss requirements**
      * ch-ext-author-authorrole
   * ch-mhd-provide-comprehensive-documentreference **is copied from** IHE.MHD.Provide.Comprehensive.DocumentReference **and adapted to Swiss requirements**
      * ch-ext-deletionstatus
      * ch-mhd-query-comprehensive-documentreference **is copied from** IHE.MHD.Query.Comprehensive.DocumentReference **and adapted to Swiss requirements**

#### Validation
To support **conformance** to the IHE profiles, the following validation mechanisms are added in this Implementation Guide:

* The examples are validated against both profiles (CH EPR mHealth, IHE) (listed in meta.profile)
* The profiles (CH EPR mHealth) check the conformity to the corresponding IHE profile using constraints (conformsTo)


### Operation Definitions

#### PMIR: IHE Operation Definitions
The IHE operation definitions are **imported** from https://github.com/JohnMoehrke/ITI.PIXm ([FHIR IG (CI Build)](http://build.fhir.org/ig/JohnMoehrke/ITI.PIXm/branches/master/index.html)) (as of Aug 7, 2020).

* IHE.PIXm.pix

#### PMIR: CH EPR mHealth Operation Definitions
* CH.PMIR **is copied from** IHE.PIXm.pix **and adapted to Swiss requirements**


### Capability Statements

* CH.mHealth.App
* CH.mHealth.MobileAccessGateway

#### PMIR: IHE Capability Statements
The IHE capability statements for PMIR are **imported** from https://github.com/JohnMoehrke/ITI.PIXm ([FHIR IG (CI Build)](http://build.fhir.org/ig/JohnMoehrke/ITI.PIXm/branches/master/index.html)) (as of Aug 7, 2020).
* IHE.PIXm.Consumer
* IHE.PIXm.Manager

#### PMIR: CH EPR mHealth Capability Statements
* CH.PMIR.Consumer **is copied from** IHE.PIXm.Consumer **and adapted to Swiss requirements**
* CH.PMIR.Source
* CH.PMIR.Manager **is copied from** IHE.PIXm.Manager **and adapted to Swiss requirements**

#### MHD: IHE Capability Statements
The IHE capability statments for MHD are **imported** from https://github.com/IHE/fhir (as of Aug 13, 2020).

* IHE.MHD.DocumentSource
* IHE.MHD.DocumentConsumer
* IHE.MHD.DocumentRecipient
* IHE.MHD.DocumentResponder

#### MHD: CH EPR mHealth Capability Statements
* CH.MHD.DocumentSource **is copied from** IHE.MHD.DocumentSource **and adapted to Swiss requirements**
* CH.MHD.DocumentConsumer **is copied from** IHE.MHD.DocumentConsumer **and adapted to Swiss requirements**
* CH.MHD.DocumentRecipient **is copied from** IHE.MHD.DocumentRecipient **and adapted to Swiss requirements**
* CH.MHD.DocumentResponder **is copied from** IHE.MHD.DocumentResponder **and adapted to Swiss requirements**
