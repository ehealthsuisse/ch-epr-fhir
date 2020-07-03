Their are no additional requirements for the Swiss EPR of the Find Document Manifests [ITI-66] transaction
defined in the MHD Profile published in the IHE ITI Trial Implementation “Mobile Access to Health Documents”.
The SubmissionSet.Author.AuthorRole mapping to DocumentManifest has to be supported.

### Message Example

```
GET [base]/DocumentManifest?patient.identifier=urn:oid:2.999|11111111 HTTP/1.1
Accept: application/fhir+json
```

See [Document Manifest](DocumentManifest-2-7-DocManMedicationCard.html)

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Patient Identity Manager using IUA profile with basic access token. Consequently
the Finde Document Manifest [ITI-66] request must authorize using the Incorporate Authorization Token [ITI-
72] transaction of the IUA profile.