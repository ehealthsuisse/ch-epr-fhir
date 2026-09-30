This section specifies Swiss national extensions to the Mobile Access to Health Documents (MHD), which is [published](https://profiles.ihe.net/ITI/MHD/index.html) as an IHE ITI Trial Implementation profile.

The national extension adds two transactions from the Document Source to the Document Responder, [Update Document Metadata [CH:MHD-1]](ch-mhd-1.html) and [Purge Document [CH:MHD-2]](ch-mhd-2.html).

### Scope  
An Health App can query, retrieve or publish data to/from the Health Dossier API using the transaction of the MHD profile. 
An Health App can update the metadata of a published document and purge a published document with this national extension.  

###	Use Cases  
The national extension supports the following Use Cases:

#### Publication of documents
A patient, a healthcare professional, an assistant acting on behalf of a healthcare professional, or a technical user (e.g. the clinical archive system of a health institution) publishes a document in the health dossier of the patient. The Health App submits the document together with its metadata through the Health Dossier API. How the document is published is described in [ITI-65](iti-65.html).

#### Search and download of documents
A patient, a healthcare professional, an assistant acting on behalf of a healthcare professional searches the health dossier of the patient for documents, e.g. by type, date or with a full-text search, and downloads a document found. The result only contains the documents the requester is authorized to access. How documents are searched is described in [ITI-67](iti-67.html) and how a document is downloaded in [ITI-68](iti-68.html).

#### Healthcare professional corrects a published document
A patient, a healthcare professional, an assistant acting on behalf of a healthcare professional, or a technical user (e.g. the clinical archive system of a health institution) has published a document that contains incorrect data. The correction is made by publishing a new version of the document with the correct data; the incorrect document is neither overwritten nor removed, it remains accessible in the health dossier so that the correction stays traceable for the patient. How the corrected document is published is described in [ITI-65](iti-65.html#correction-of-a-published-document).

#### Healthcare professional deletes a document published for the wrong person
A patient, a healthcare professional, an assistant acting on behalf of a healthcare professional, or a technical user (e.g. the clinical archive system of a health institution) has published a document in the health dossier of the wrong person. Such a document is not corrected by a new version but has to be deleted, and the healthcare professional which published it has to delete it itself. How the document is deleted is described in [CH:MHD-2](ch-mhd-2.html).

#### Patient changes confidentiality code of a document
A patient wants to change the confidentiality code of one of his documents. The patient updates the confidentiality code in the Health App and the Health App submits the updated metadata through the Health API. How the confidentiality code is updated is described in [CH:MHD-1](ch-mhd-1.html#metadata-which-may-be-updated).

#### Patient adds a personal note to a document
A patient and the healthcare professional which published a document do not agree on the correctness of the data in that document. The patient can then record a personal note on the document. The note is recorded with the metadata of the document, the document itself and its data stay unchanged and no new version of the document is published. How the note is recorded is described in [CH:MHD-1](ch-mhd-1.html#recording-a-personal-note).

#### Patient deletes a document
A patient wants to delete a document of their health dossier. How the document is deleted is described in [CH:MHD-2](ch-mhd-2.html).

###	Actors and Transactions  

<div>
{%include MHD_actor_diagram.svg %}
</div>
This figure shows the actors directly involved in the _Mobile Access to Health Documents_ Profile and the relevant 
transactions between them.

The Find Document Lists [[ITI-66]](https://profiles.ihe.net/ITI/MHD/ITI-66.html) transaction defined in [MHD](https://profiles.ihe.net/ITI/MHD/index.html) SHALL not be made available in this context.

### Actor options  

Options that can be selected for each actor in this profile, are listed in the table below. 

{:class="table table-bordered"}
| Actor              | Options                                                                                   | Optionality |
|--------------------|-------------------------------------------------------------------------------------------|-------------|
| Document Source    | [Health Dossier Metadata](#health-dossier-metadata-option)<br>[ITI-65 FHIR Documents Publish](#iti-65-fhir-documents-publish-option) | R<br>R |
| Document Recipient | [Health Dossier Metadata](#health-dossier-metadata-option)<br>[ITI-65 FHIR Documents Publish](#iti-65-fhir-documents-publish-option) | R<br>R |
| Document Consumer  | [Full-Text Search](#full-text-search-option)                                              | O           |
| Document Responder | [Full-Text Search](#full-text-search-option)                                              | R           |

<figcaption ID="1">Table 1: Actor options.</figcaption>

<br/>


#### Health Dossier Metadata Option

Metadata as defined in [CH MHD DocumentReference](StructureDefinition-ch-mhd-documentreference.html) SHALL be supported by the Document Source and Document Recipient.

#### ITI-65 FHIR Documents Publish Option

The [ITI-65 FHIR Documents Publish Option](https://profiles.ihe.net/ITI/MHD/index.html) SHALL be supported by the Document Source and Document Recipient, so that a FHIR document can be published as a Document Bundle resource in raw format without converting to a base64 encoded binary. How a FHIR document is published is described in [ITI-65](iti-65.html#publishing-a-fhir-document).

#### Full-Text Search Option

The [Full-Text Search Option](https://profiles.ihe.net/ITI/MHD/1332_actor_options.html#13327-full-text-search-option) SHALL be supported by the Document Responder and MAY be supported by the Document Consumer, so that the textual content of the documents can be searched with the `full-text` search parameter in [ITI-67](iti-67.html#full-text-search-option).

### Required Actor Groupings  
This national extension enforces authentication and authorization for access control. Therefore actors of this profile SHALL be grouped with actors of other profiles according to the following table: 


{:class="table table-bordered"}
| Actor                                         | Required Grouping         | Optionality | Remark                                                             |
|-----------------------------------------------|---------------------------|-------------|--------------------------------------------------------------------|
| Document Recipient                            | IUA Resource Server       | R           | -                                                                  |
| Document Responder                            | IUA Resource Server       | R           | -                                                                  |
| Document Source                               | IUA Authorization Client  | R           | `TCU` allowed for [ITI-65](iti-65.html)  |
| Document Consumer                             | IUA Authorization Client  | R           | `TCU` not allowed |

<figcaption ID="2">Table 2: Grouping of MHD actors required by this national extension.</figcaption>

<br/>

###	Process Flow
For the process flow of this profile and its interplay with the other profiles see [sequence diagrams](sequencediagrams.html). 

### Security Consideration
This national extension enforces authentication and authorization of access to the Document Recipient and Document Responder using the IUA profile as described in [IUA](iti-71.html#expected-actions-1).
