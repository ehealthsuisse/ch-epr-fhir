Their are no additional requirements for the Swiss EPR extension for the Swiss EPR of the Retrieve Document
[ITI-68] transaction defined in the MHD Profile which is published in the IHE ITI Trial Implementation
“Mobile Access to Health Documents”.

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Patient Identity Manager using IUA profile with basic access token. Consequently
the Retrieve Document [ITI-68] request must authorize using the Incorporate Authorization Token [ITI-72]
transaction of the IUA profile.