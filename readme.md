# CH EPR mHealth
The national IHE extensions documented in this FHIR implementation guide shall be used in conjunction with the definitions of integration profiles, actors and transactions provided in Volumes 1 through 3 of the IHE IT Infrastructure Technical Framework.

## Relation to IHE profiles since version v0.1.3 (currently as CI build and work in progress)

### Structure Definitions

To support **conformance** to the IHE profiles, the following validation mechanisms are added in this implementation guide:
* The CH EPR mHealth profiles check the conformity to the corresponding IHE profile using constraints (`conformsTo`)
* The examples are validated against both profiles (CH EPR mHealth & IHE) (listed in `meta.profile`)

CH EPR mHealth Structure Definition | Relation/Action | IHE Structure Definition (Source)
--- | --- | --- 
CH PIXm IN Parameters | TBD | TBD
CH PIXm OUT Parameters | TBD | TBD
CH PMIR Bundle Message | TBD | TBD
CH EPR mHealth Patient Profile for CH:PIXm | TBD | TBD
CH EPR mHealth Provider Organization Profile for CH:PIXm | TBD | TBD
CH PIXm Bundle Message Response | TBD | TBD
CH PIXm MessageHeader Response | TBD | TBD
CH MHD Provide Document Bundle Comphrensive | TBD | TBD
IHE_MHD_Provide_Comprehensive_DocumentBundle | TBD | TBD
CH MHD Comprehensive List (SubmissionSet)
[CH MHD DocumentReference Comprehensive](http://build.fhir.org/ig/ehealthsuisse/ch-epr-mhealth/StructureDefinition-ch-mhd-documentreference-comprehensive.html) | `conformsTo` & `meta.profile` | [MHD DocumentReference Comprehensive](http://build.fhir.org/ig/IHE/ITI.MHD/branches/master/StructureDefinition-IHE.MHD.Comprehensive.DocumentReference.html) (https://github.com/IHE/ITI.MHD)
CH MHD Provide Document Bundle Comphrensive Response | TBD | TBD
CH MHD Comprehensive SubmissionSet Bundle | TBD | TBD
CH MHD DocumentReference Comprehensive Bundle | TBD | TBD


### Operation Definitions

CH EPR mHealth Operation Definition | Relation/Action | IHE Operation Definition (Source)
--- | --- | --- 
[CH.PMIR](http://build.fhir.org/ig/ehealthsuisse/ch-epr-mhealth/OperationDefinition-CH.PMIR.html) | as a template and adapted to Swiss requirements | [https://github.com/JohnMoehrke/ITI.PIXm](https://github.com/JohnMoehrke/ITI.PIXm/blob/master/input/resources/operationdefinition-IHE_PIXm_pix.xml) ([FHIR IG (CI Build)](http://build.fhir.org/ig/JohnMoehrke/ITI.PIXm/branches/master/OperationDefinition-IHE_PIXm_pix.html)) (as of Aug 7, 2020)

### Capability Statements

CH EPR mHealth Capability Statement | Relation/Action | IHE Capability Statement (Source)
--- | --- | --- 
[CH.mHealth.App](http://build.fhir.org/ig/ehealthsuisse/ch-epr-mhealth/CapabilityStatement-CH.mHealth.App.html) | - | -
[CH.PMIR.Consumer](http://build.fhir.org/ig/ehealthsuisse/ch-epr-mhealth/CapabilityStatement-CH.PMIR.Consumer.html) | as a template and adapted to Swiss requirements | [https://github.com/JohnMoehrke/ITI.PIXm](https://github.com/JohnMoehrke/ITI.PIXm/blob/master/input/resources/capabilitystatement-IHE_PIXm_Consumer.xml) ([FHIR IG (CI Build)](http://build.fhir.org/ig/JohnMoehrke/ITI.PIXm/branches/master/CapabilityStatement-IHE_PIXm_Consumer.html)) (as of Aug 7, 2020)
[CH.PMIR.Source](http://build.fhir.org/ig/ehealthsuisse/ch-epr-mhealth/CapabilityStatement-CH.PMIR.Source.html) | - | -
[CH.MHD.DocumentSource](http://build.fhir.org/ig/ehealthsuisse/ch-epr-mhealth/CapabilityStatement-CH.MHD.DocumentSource.html) | as a template and adapted to Swiss requirements | [Document Source (publisher)](http://build.fhir.org/ig/IHE/ITI.MHD/branches/master/CapabilityStatement-IHE.MHD.DocumentSource.html)
[CH.MHD.DocumentConsumer](http://build.fhir.org/ig/ehealthsuisse/ch-epr-mhealth/CapabilityStatement-CH.MHD.DocumentConsumer.html) | as a template and adapted to Swiss requirements | [Document Consumer (client)](http://build.fhir.org/ig/IHE/ITI.MHD/branches/master/CapabilityStatement-IHE.MHD.DocumentConsumer.html)
[CH.mHealth.MobileAccessGateway](http://build.fhir.org/ig/ehealthsuisse/ch-epr-mhealth/CapabilityStatement-CH.mHealth.MobileAccessGateway.html) | - | -
[CH.PMIR.Manager](http://build.fhir.org/ig/ehealthsuisse/ch-epr-mhealth/CapabilityStatement-CH.PMIR.Manager.html) | as a template and adapted to Swiss requirements | [https://github.com/JohnMoehrke/ITI.PIXm](https://github.com/JohnMoehrke/ITI.PIXm/blob/master/input/resources/capabilitystatement-IHE_PIXm_Manager.xml) ([FHIR IG (CI Build)](http://build.fhir.org/ig/JohnMoehrke/ITI.PIXm/branches/master/CapabilityStatement-IHE_PIXm_Manager.html)) (as of Aug 7, 2020)
[CH.MHD.DocumentRecipient](http://build.fhir.org/ig/ehealthsuisse/ch-epr-mhealth/CapabilityStatement-CH.MHD.DocumentRecipient.html) | as a template and adapted to Swiss requirements | [Document Recipient](http://build.fhir.org/ig/IHE/ITI.MHD/branches/master/CapabilityStatement-IHE.MHD.DocumentRecipient.html)
[CH.MHD.DocumentResponder](http://build.fhir.org/ig/ehealthsuisse/ch-epr-mhealth/CapabilityStatement-CH.MHD.DocumentResponder.html) | as a template and adapted to Swiss requirements | [Document Responder (server)](http://build.fhir.org/ig/IHE/ITI.MHD/branches/master/CapabilityStatement-IHE.MHD.DocumentResponder.html)

## Source Information until v0.1.2
The profiles of the FHIR implementation guide CH EPR mHealth are **derived** or **copied and adapted** from existing IHE profiles. Therefore they have been **imported** into the implementation guide. The sources of the structure definitions, operation definitions and capability statements and their dependencies are listed below.

* https://github.com/IHE/fhir
* https://github.com/IHE/ITI.MHD ([FHIR IG (CI Build)](http://build.fhir.org/ig/IHE/ITI.MHD/branches/master/index.html))
* https://github.com/JohnMoehrke/ITI.PIXm ([FHIR IG (CI Build)](http://build.fhir.org/ig/JohnMoehrke/ITI.PIXm/branches/master/index.html))


### Structure Definitions

#### PIXm: IHE Structure Definitions
The IHE profiles come from IHE Services (Sept 2020).

* IHE.PIXm.Parameters

#### PIXm: CH EPR mHealth Structure Definitions
* ch-pixm-in-parameters
* ch-pixm-out-parameters **is derived from** (`baseDefinition`) IHE.PIXm.Parameters

#### PMIR: IHE Structure Definitions
The IHE profiles are **imported** from https://github.com/IHE/fhir (as of Aug 13, 2020).

* IHE.PMIR.Bundle
   * IHE.PMIR.MessageHeader
   * IHE.PMIR.BundleHistory   
* IHE.PMIR.Patient.Merge
* IHE.PMIR.Patient.RelatedPerson
* IHE.PMIR.Subscription
   * IHE.PMIR.Subscription.request

#### CH:PIXm: CH EPR mHealth Structure Definitions
* ch-pixm-bundle **is derived from** (`baseDefinition`) IHE.PMIR.Bundle
* ch-pixm-patient
   * ch-epr-mhealth-humanname
   * ch-epr-mhealth-birthname
   * ch-pixm-provider-organization
* ch-pim-bundle-response
   * ch-pim-messageheader-response

#### MHD: IHE Structure Definitions
The IHE profiles are referenced from the public comment version https://profiles.ihe.net/ITI/MHD/index.html, Package ihe.mhd.fhir#4.0.0-comment 

#### MHD: CH EPR mHealth Structure Definitions
* ch-mhd-providedocumentbundle-comprehensive **is copied from** IHE.MHD.ProvideDocumentBundle.Comprehensive **and adapted to Swiss requirements** 
   * ch-mhd-comprehensive-documentmanifest **is copied from** IHE.MHD.Comprehensive.DocumentManifest **and adapted to Swiss requirements**
      * ch-ext-author-authorrole
   * ch-mhd-provide-documentreference-comprehensive **is copied from** IHE.MHD.Provide.Comprehensive.DocumentReference **and adapted to Swiss requirements**
      * ch-ext-deletionstatus
      * ch-mhd-query-documentreference-comprehensive **is copied from** IHE.MHD.Query.Comprehensive.DocumentReference **and adapted to Swiss requirements**
* ch-mhd-providedocumentbundle-comprehensive-response

#### Validation
To support **conformance** to the IHE profiles, the following validation mechanisms are added in this Implementation Guide:

* The examples are validated against both profiles (CH EPR mHealth, IHE) (listed in meta.profile)
* The profiles (CH EPR mHealth) check the conformity to the corresponding IHE profile using constraints (conformsTo)

### Operation Definitions

#### CH:PIXm: IHE Operation Definitions
The IHE operation definitions are **imported** from https://github.com/JohnMoehrke/ITI.PIXm ([FHIR IG (CI Build)](http://build.fhir.org/ig/JohnMoehrke/ITI.PIXm/branches/master/index.html)) (as of Aug 7, 2020).

* IHE.PIXm.pix

#### CH:PIXM: CH EPR mHealth Operation Definitions
* CH.PIXm **is copied from** IHE.PIXm.pix **and adapted to Swiss requirements**


### Capability Statements

* CH.mHealth.App
* CH.mHealth.MobileAccessGateway

#### CH:PIXM: IHE Capability Statements
The IHE capability statements for PMIR are **imported** from https://github.com/JohnMoehrke/ITI.PIXm ([FHIR IG (CI Build)](http://build.fhir.org/ig/JohnMoehrke/ITI.PIXm/branches/master/index.html)) (as of Aug 7, 2020).
* IHE.PIXm.Consumer
* IHE.PIXm.Manager

#### PIXm: CH EPR mHealth Capability Statements
* CH.PIXm.Consumer **is copied from** IHE.PIXm.Consumer **and adapted to Swiss requirements**
* CH.PIXm.Source
* CH.PIXm.Manager **is copied from** IHE.PIXm.Manager **and adapted to Swiss requirements**

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
