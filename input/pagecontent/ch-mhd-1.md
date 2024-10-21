This section corresponds to transaction [CH:MHD-1]. Transaction [CH:MHD-1] is used by the Document Source and Document Recipient Actors. 

### Scope

The Update Document Metadata [CH-MHD-1] transaction is used to update document metadata from the Document Consumer to the Document Responder.

### Actor Roles

**Actor:** Document Source   
**Role:** Prepares and issues an update to a DocumentReference resource   
**Actor:** Document Recipient    
**Role:** Accepts requests for updates to a DocumentReference resource    

### Referenced Standards

1. [Mobile access to Health Documents (MHD), Rev. 4.2.2 – Trial-Implementation, 2024-05-18](https://profiles.ihe.net/ITI/MHD/index.html) 
2. This MHD Profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

<div>{% include MHD_ActorDiagram_CH-1.svg %}</div>

#### Update Document Metadata Request Message

The Update Document Metadata Request Message provides the ability to submit updated attributes for a DocumentReference resource in a community.

##### Trigger Events

The Update Document Metadata Request Message is triggered when an Document Source needs to transmit updated DocumentReference metadata.

##### Message Semantics

A Document Source initiates a FHIR request using Update as defined at http://hl7.org/fhir/http.html#update on a DocumentReference Resource.

A Document Source shall send a request for either the JSON or the XML format as defined in FHIR. A Document Recipient shall support the JSON and the XML format.

The Document Source shall be capable of accepting elements specified in profile [CH MHD DocumentReference Comprehensive](StructureDefinition-ch-mhd-documentreference-comprehensive.html).
The DocumentReference elements which are allowed to be updated are defined in Annex 5.1 1.12.1. The [Mappings tab](StructureDefinition-ch-mhd-documentreference-comprehensive-mappings.html#mappings-for-xds-metadata-equivalent-http-ihe-netxds), indicates the mapping between DocumentReference elements and the XDS elements defined in Annex 5.1 1.12.1.

##### Example

```http
PUT [base]/DocumentReference/1c8d1f74-1686-4188-9c35-0c5727c771cc HTTP/1.1
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00

{
  "resourceType": "DocumentReference",
  "id": "1c8d1f74-1686-4188-9c35-0c5727c771cc",
  "contained": [
    {
      "resourceType": "Patient",
      "id": "pat",
      "identifier": [
        {
          "use": "usual",
          "type": {
            "coding": [
              {
                "system": "http://terminology.hl7.org/CodeSystem/v2-0203",
                "code": "MR"
              }
            ]
          },
          "system": "urn:oid:2.16.756.888888.3.1",
          "value": "8734"
        }
      ]
    }
  ],
  "extension": [
    {
      "url": "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-deletionstatus",
      "valueCoding": {
        "system": "urn:oid:2.16.756.5.30.1.127.3.10.18",
        "code": "urn:e-health-suisse:2019:deletionStatus:deletionNotRequested"
      }
    },
    {
      "url": "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/ch-ext-author-authorrole",
      "valueCoding": {
        "system": "urn:oid:2.16.756.5.30.1.127.3.10.6",
        "code": "HCP",
        "display": "Healthcare professional"
      }
    }
  ],
  "masterIdentifier": {
    "system": "urn:ietf:rfc:3986",
    "value": "urn:oid:1.3.6.1.4.1.12559.11.13.2.1.2951"
  },
  "identifier": [
    {
      "system": "urn:ietf:rfc:3986",
      "value": "urn:uuid:50383ae5-49e5-4dea-b0e6-660cb9e7b91f"
    }
  ],
  "status": "current",
  "type": {
    "coding": [
      {
        "system": "http://snomed.info/sct",
        "code": "721912009",
        "display": "Medication summary document (record artifact)"
      }
    ]
  },
  "category": [
    {
      "coding": [
        {
          "system": "http://snomed.info/sct",
          "code": "422735006",
          "display": "Summary clinical document (record artifact)"
        }
      ]
    }
  ],
  "subject": {
    "reference": "http://example.org/Patient/FranzMusterNeedsAbsoluteUrl"
  },
  "date": "2020-06-29T11:58:00+00:00",
  "description": "Changed Description for -MedicationCard",
  "securityLabel": [
    {
      "coding": [
        {
          "system": "http://snomed.info/sct",
          "code": "17621005",
          "display": "Normal (qualifier value)"
        }
      ]
    }
  ],
  "content": [
    {
      "attachment": {
        "contentType": "text/xml",
        "language": "de-CH",
        "url": "http://example.com/xdsretrieve?uniqueId=urn:uuid:413eb0f7-aa72-4405-86a4-7793a23fcc27&repositoryUniqueId=2.999.756.42.1",
        "creation": "2020-06-29T11:58:00+00:00"
      },
      "format": {
        "system": "http://ihe.net/fhir/ihe.formatcode.fhir/CodeSystem/formatcode",
        "code": "urn:ihe:pharm:pml:2013",
        "display": "Pharmacy PML"
      }
    }
  ],
  "context": {
    "facilityType": {
      "coding": [
        {
          "system": "http://snomed.info/sct",
          "code": "264358009",
          "display": "General practice premises (environment)"
        }
      ]
    },
    "practiceSetting": {
      "coding": [
        {
          "system": "http://snomed.info/sct",
          "code": "394802001",
          "display": "General medicine (qualifier value)"
        }
      ]
    },
    "sourcePatientInfo": {
      "reference": "#pat"
    }
  }
}
```


##### Expected Actions

The Document Recipient shall provide a [CapabilityStatement](CapabilityStatement-CH.MHD.DocumentRecipient.html) with the capabilities interaction and indicate that update is available on the DocumentReference.

The Update Responder shall process the Update Document Metadata Request message and return the updated DocumentReference.

Any error that occurs during the processing of the Update Document Metadata Request message shall cause the entire transaction to fail and 
no change made to the existing DocumentReference. The DocumentReference Responder shall return the status and any error codes incurred during the processing of
the request in its response message. 

1. Verify the submitted and existing DocumentReference have the same values for the identifiers. If these values are not identical, an OperationOutcome with the error code [XDSMetadataIdentifierError](OperationOutcome-MhdOperationOutcomeErrorXdsMetadataIdentifier.html) should be returned.
2. Verify the submitted and existing DocumentReference reference the same Patient. If these values are not identical, an OperationOutcome with the error code [XDSPatientIDReconciliationError](OperationOutcome-MhdOperationOutcomeErrorXDSPatientIDReconciliationError.html) should be returned.
3. Check the submitted DocumentReference and determine if it contains only changes to modifiable attributes, as described in Annex 5.1 1.12.1. If not, an OperationOutcome with the error code [UnmodifiableMetadataError](OperationOutcome-MhdOperationOutcomeErrorUnmodifiableMetadataError.html) should be returned.

###### Federated Cross Community Access Option

{% include iti-mhd-fxca-update.html %}

If the Document Recipient  supports the Federated Cross Community Access Option the Document Recipient must be able to identify if a document metadata update 
targets another community. If this is the case, it will need to forward the request to the target community, otherwise the request can be handled directly. If the remote community cannot be reached an error needs to be generated by the Document Recipient and the Document Source must be able to process this error.

##### Response Message
See http://hl7.org/fhir/http.html#update for response.


### Security Consideration

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with
server certificates.

The transaction SHALL use client authentication and authorization using extended authorization token as defined
in the [IUA profile](https://profiles.ihe.net/ITI/IUA). The extended authorization token SHALL be conveyed as
defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72)
transaction.

The Document Recipient actor SHALL be grouped with the Authorization Decision Consumer actor of the CH:ADR profile
defined in Extension 2.1 to Annex 5 of the ordinances and perform an Authorization Decision Request [CH:ADR] for
every update document metadata [CH:MHD-1] request.

The Document Recipient actor SHALL enforce a `traceparent` header to enable inspection of cross community
transactions as defined in section [Trace Context header](tracecontext.html).

#### Security Audit Considerations

##### Document Source Audit

The **Document Source** shall record an
[Audit Event for Update Document Metadata Transaction at Source](StructureDefinition-ch-mhd-updatedocumentmetadata-audit-source.html).

##### Document Recipient Audit


The **Document Recipient** shall record an
[Audit Event for Update Document Metadata Transaction at Recipient](StructureDefinition-ch-mhd-updatedocumentmetadata-audit-recipient.html).
