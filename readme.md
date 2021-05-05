# CH EPR mHealth
The national IHE extensions documented in this FHIR implementation guide shall be used in conjunction with the definitions of integration profiles, actors and transactions provided in Volumes 1 through 3 of the IHE IT Infrastructure Technical Framework.

## Relation to IHE profiles since version v0.1.3 (currently as CI build and work in progress)

### Structure Definitions

To support **conformance** to the IHE profiles, the following validation mechanisms are added in this implementation guide:
* The CH EPR mHealth profiles check the conformity to the corresponding IHE profile using constraints if it cannot be derived (`conformsTo`)
* The examples are validated against both profiles (CH EPR mHealth & IHE) (listed in `meta.profile`)
