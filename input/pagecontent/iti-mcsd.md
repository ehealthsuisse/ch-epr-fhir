This section specifies Swiss national extensions to Mobile Care Services Discovery (mCSD).
mCSD is [published](https://profiles.ihe.net/ITI/mCSD/index.html) as an IHE ITI Trial Implementation profile.

###	Scope

In the Swiss EPR, the mCSD profile ensures that different systems can search for healthcare organizations and/or 
professionals.

###	Use Cases

A mHealth application wants to search for healthcare organizations and/or healthcare professionals. It can perform an 
[ITI-90](iti-90.html) request with search parameters to get a list of matched resources.

A mHealth application wants to duplicate the registry of healthcare organizations and professionals to perform local 
operations on it. It can perform an [ITI-91](iti-91.html) request with a parameter to get the list of changes to the 
registry since the given date and time.

###	Actors and Transactions, Content Specifications

### Actor Options

The Swiss national extension does not implement the 'Location Distance Option'.

### Required Actor Grouping

Q: What's the MHD equivalent of Authenticate Node [ITI-19]?
No grouping required by mCSD.

###	Security Consideration

### Mapping LDAP-FHIR

With the LDAP examples.

![LDAP examples](https://lh6.googleusercontent.com/UmHlcRwLbFti3B_nf9PSjPsxfPWdsAA5JDBPm1sA6OfFu5CTTOR_AHaMhTBF5qWNeDpSFkOTWREf-RCfg6Jq3xPq7wwNAFkL1r51HQygorTOQQGeDJUQw592NbDXnpdrI4wEb6Jw)

- Community A is not a HCRegulatedOrganization(?), but exists as Relationship.owner. Should it be an Organization too?
- uid=CommunityA:00000001000,OU=HCRegulatedOrganization: Spital X is an Organization.
- uid=CommunityA:00000001004,OU=HCRegulatedOrganization: Spital X - Medicina d'urgenza e di salvataggio is either an 
Organization or a HealthcareService.
- uid=CommunityA:00000003002,OU=HCProfessional: Dr. Peter Pan is a Practitioner.
- CN=CommunityA:00000001004,OU=Relationship: The relationship between Peter Pan and Spital X - Medicina d'urgenza e di 
salvataggio is a PractitionerRole.
- CN=CommunityA:00000001000,OU=Relationship: The relationship between Spital X and subservices is not a 
- PractitionerRole. We may use Organization.partOf. A HealthcareService can't be part of another HealthcareService.
- CN=CommunityA:00000001009,OU=Relationship: The relationship between Community A and Spital X is ?

### Todo

Do we use the full DN as identifier somewhere?
The community seems to be important, and was given in the DN. We currently don't have this information in the FHIR 
resources. In ITI-91, we may also want it (because of `<authRequest principal="community1"/>` in CH:PIDD).
