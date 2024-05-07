This section corresponds to transaction [CH:MHD-1]. Transaction [CH:MHD-1] is used by the Document Source and Document Recipient Actors. 

### Scope

The Update Limited Document Metadata [CH-MHD-1] transaction is used to update Limited
document metadata from the Document Consumer to the Document Responder.

### Actor Roles

**Actor:** Document Source   
**Role:** Prepares and issues an update to a DocumentReference resource   
**Actor:** Document Recipient    
**Role:** Accepts requests for updates to a DocumentReference resource    

### Referenced Standards

1. [Mobile access to Health Documents (MHD), Rev. 4.2.1 – Trial-Implementation,  August 2, 2023](https://profiles.ihe.net/ITI/MHD/index.html) 
2. This MHD Profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include MHD_ActorDiagram_CH-1.svg %}</div>

#### Update Limited Document Metadata Request Message

The Update Limited Document Metadata Request Message provides the ability to submit updated attributes for a DocumentReference resource in a community.

##### Trigger Events

The Update Limited Document Metadata Request Message is triggered when an Document Source needs to transmit updated DocumentEntry metadata.

##### Message Semantics

A Document Source initiates a FHIR request using Update as defined at http://hl7.org/fhir/http.html#update on a DocumentReference Resource.

A Document Source shall to send a request for either the JSON or the XML format as defined in FHIR. A Document Recipient shall to support the JSON and the XML format.

The Document Source shall be capable of accepting elements specified in profile [CH MHD DocumentReference Comprehensive](StructureDefinition-ch-mhd-documentreference-comprehensive.html).
The DocumentReference elements which are allowed to be updated are defined in Annex 5.1 1.12.1. The [Mappings tab](StructureDefinition-ch-mhd-documentreference-comprehensive-mappings.html#mappings-for-xds-metadata-equivalent-http-ihe-net-xds), indicates the mapping between DocumentReference elements and the XDS elements defined in Annex 5.1 1.12.1.

##### Expected Actions

The Document Recipient shall provide a [CapabilityStatement](CapabilityStatement-CH.MHD.DocumentRecipient.html) with the capabilities interaction and indicate that update is available on the DocumentReference.

The Update Responder shall process the Update Limited Document Metadata Request message and return the updated DocumentReference.

Any error that occurs during the processing of the Update Limited Document Metadata Request message shall cause the entire transaction to fail and 
no change made to the existing DocumentReference. The DocumentReference Responder shall return the status and any error codes incurred during the processing of
the request in its response message. 

1. Verify the submitted and existing DocumentReference have the same values for the identifiers. If these values are not identical, an OperationOutcome with the error code ***XDSMetadataIdentifierError*** should be returned.
2. Verify the submitted and existing DocumentReference reference the same Patient. If these values are not identical, an OperationOutcome with the error code ***XDSPatientIDReconciliationError*** should be returned.
3. Check the submitted DocumentReference and determine if it contains only changes to modifiable attributes, as described in Annex 5.1 1.12.1. If not, an OperationOutcome with the error code ***UnmodifiableMetadataError*** should be returned.

##### Response Message
See http://hl7.org/fhir/http.html#update for response.

##### Example

TODO

### Security Consideration

TLS SHALL be used. This national extension enforces authentication and authorization of access to the
Document Recipient using the IUA profile with extended access token. Consequently
the _Update Limited Document Metadata_ [CH:MHD-1] request must authorize using the [[ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72)
transaction of the IUA profile.

The `traceparent` header is required, as described in [Trace Context header](tracecontext.html).

#### Security Audit Considerations

##### Document Source Audit

The **Document Source** shall to record an
[Audit Event for Provide Bundle Transaction at Source](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.ProvideBundle.Audit.Source.html).
[Audit Example for a Provide Bundle Transaction from source perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditProvideBundle-source.html).

TODO

##### Document Recipient Audit

TODO

The **Document Recipient** shall to record an
[Audit Event for Provide Bundle Transaction at Recipient](https://profiles.ihe.net/ITI/MHD/StructureDefinition-IHE.MHD.ProvideBundle.Audit.Recipient.html).
[Audit Example for a Provide Bundle Transaction from recipient perspective](https://profiles.ihe.net/ITI/MHD/AuditEvent-ex-auditProvideBundle-recipient.html).
