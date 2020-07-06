Their are no additional requirements for the Swiss EPR extension for the for the Swiss EPR of the Find
Document References [ITI-67] transaction defined in the MHD Profile published in the IHE ITI Trial Implementation
“Mobile Access to Health Documents”.

### Message Example

```
GET [base]/DocumentReference?patient.identifier=urn:oid:2.999|11111111 HTTP/1.1
Accept: application/fhir+json
```

See [DocumentReference example](DocumentReference-2-7-DocRefMedicationCard.html) as response to the Find Document Reference request.

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Patient Identity Manager using IUA profile with basic access token. Consequently
the Find Document References [ITI-67] request must authorize using the Incorporate Authorization Token
[ITI-72] transaction of the IUA profile.