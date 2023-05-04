This section specifies Swiss national extensions to Mobile Care Services Discovery (mCSD).
mCSD is [published](https://profiles.ihe.net/ITI/mCSD/index.html) as an IHE ITI Trial Implementation profile.

### Scope

In the Swiss EPR, the mCSD profile ensures that different systems can search for healthcare organizations and/or
professionals.

### Use Cases

A mHealth application wants to search for healthcare organizations and/or healthcare professionals. It can perform an
[ITI-90](iti-90.html) request with search parameters to get a list of matched resources.

It offers an alternative to the HPD ITI-58 transaction.

### Actors and Transactions, Content Specifications

### Actor Options

The Swiss national extension does not implement the 'Location Distance Option'.

### Required Actor Grouping

Q: What's the MHD equivalent of Authenticate Node [ITI-19]?
No grouping required by mCSD.

### Security Consideration

### Mapping LDAP-FHIR

With the LDAP examples.

![LDAP examples](https://lh6.googleusercontent.com/UmHlcRwLbFti3B_nf9PSjPsxfPWdsAA5JDBPm1sA6OfFu5CTTOR_AHaMhTBF5qWNeDpSFkOTWREf-RCfg6Jq3xPq7wwNAFkL1r51HQygorTOQQGeDJUQw592NbDXnpdrI4wEb6Jw)
