# CH EPR FHIR
The national IHE extensions documented in this FHIR implementation guide shall be used in conjunction with the definitions of integration profiles, actors and transactions provided in Volumes 1 through 3 of the IHE IT Infrastructure Technical Framework.

### Structure Definitions

To support **conformance** to the IHE profiles, the following validation mechanisms are added in this implementation guide:
* The CH EPR FHIR profiles check the conformity to the corresponding IHE profile using constraints if it cannot be derived (`conformsTo`)
* The examples are validated against both profiles (CH EPR FHIR & IHE) (listed in `meta.profile`)
