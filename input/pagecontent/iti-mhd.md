This section specifies Swiss national extensions to the Mobile Access to Health Documents (MHD), which is [published](https://profiles.ihe.net/ITI/MHD/index.html) as an IHE ITI Trial Implementation profile.

The national extensions adds an additional transaction from the Document Source to the Document Recipient. 

### Scope  
An EPR App can query, retrieve or publish data to/from an EPR community using the transaction of the MHD profile. 
An EPR App can Update Document Metadata for a published document with this national extension.  

###	Use Cases  
In addition to the Document Sharing Use Case for MHD the national extension defines the following Use Cases:

#### Document Metadata update from a Health Care professional with a primary system
A Healthcare professional has published a document in his own community for the patient but needs to update the metadata of the document. 
The healthcare professional updates the metadata (e.g. title) in the primary systems and submits the updated metadata to the community. The
metadata which is allowed to be updated is defined in Annex 5.1 1.12.1.

#### Federated Cross Community Access
An EPR App can query and retrieve documents and data for a patient from an EPR Community independent in which community the documents / data are stored.

#### Patient changes confidentiality code of a document
A patient wants to change the confidentiality code of one of his documents. The patient updates the confidentiality code in the portal and the portal submits the updated metadata to the community where the document is stored (could be another community as where the patient has his reference community). 

###	Actors and Transactions  

<div>
{%include MHD_actor_diagram.svg %}
</div>
This figure shows the actors directly involved in the _Mobile Access to Health Documents_ Profile and the relevant 
transactions between them.

The Find Document Lists [[ITI-66]](https://profiles.ihe.net/ITI/MHD/ITI-66.html) transaction defined in [MHD](https://profiles.ihe.net/ITI/MHD/index.html) SHALL not be made available in this context.

### Actor options  

Options that can be selected for each actor in this profile,are listed in the table below. 

{:class="table table-bordered"}
| Actor                                         | Option Name         | Optionality  |
|-----------------------------------------------|---------------------------|-------------|
| Document Source                               | Comprehensive Metadata <br />Federated Cross Community Access   | R  <br /> see actor option notes    |
| Document Recipient                            | Comprehensive Metadata <br />Federated Cross Community Access    | R <br /> see actor option notes |
| Document Consumer                             | Comprehensive Metadata <br />Federated Cross Community Access   | R <br /> R  |
| Document Responder                            | Comprehensive Metadata <br />Federated Cross Community Access  | R<br /> see actor option notes  |

<figcaption ID="1">Table 1: Actor options.</figcaption>


#### Comprehensive Metadata Option

Comprehensive Metadata as defined in [1:33.2.1](https://profiles.ihe.net/ITI/MHD/1332_actor_options.html#13321-comprehensive-metadata-option). For all actors the Metadata as defined in Annex 3 SHALL be supported.

#### Federated Cross Community Access Option

The Federated Cross Community Access Option allows querying, retrieving documents and updating document metadata over multiple communities. 

##### Querying, retrieving documents and updating document metadata over multiple communities

 A community and reference community SHALL support one Document Responder with the Federated Cross Community Access and one Document Responder without the Federated Cross Community Access option. 

{% include iti-mhd-fxca-query.html %}

{% include iti-mhd-fxca-retrieve.html %}

If a Document source queries a Document Responder with the Federated Cross Community Access Option then the Document Responder must forward the query to all communities (including his own) to the Document Responder without the Federated Cross Community Access option and then aggregate and sort the results from all communities. A Document Responder must ensure, that a followup retrieve of a document must be handled by himself. If a community cannot be reached a warning needs to be added to the query results. A Document Consumer must be able to handle warnings if a Document Responder indicates that a community was not available.

With this option the Document Responder must be able to identify if a document retrieve targets another community. If this is the case, it will need to forward the request to the target community, otherwise the request can be handled directly.

##### Updating document metadata over multiple communities

{% include iti-mhd-fxca-update.html %}

 A reference community SHALL support a Document Recipient with the Federated Cross Community Access Option. With this option the Document Recipient must be able to identify if a document metadata update targets another community. If this is the case, it will need to forward the request to the target community, otherwise the request can be handled directly. If the remote community cannot be reached an error needs to be generated by the Document Recipient and the Document Source must be able to process this error.

 Note: Except for additional error handling Document Source and Consumer need not to be aware that it is a federated system with multiple communities, this is transparent and the recipient/responder need to handle the necessary correlations of the document (metadata) to the communities.
   
### Required Actor Groupings  
This national extension enforces authentication and authorization for access control. Therefore actors of this profile must be grouped with actors of other profiles according to the following table: 


{:class="table table-bordered"}
| Actor                                         | Required Grouping         | Optionality |
|-----------------------------------------------|---------------------------|-------------|
| Document Recipient                            | IUA Resource Server       | R           |
| Document Responder                            | IUA Authorization Client  | R           |
| Document Source                               | IUA Authorization Client  | R           |
| Document Consumer                             | IUA Authorization Client  | R           |

<figcaption ID="2">Table 2: Grouping of MHD actors required by this national extension.</figcaption>

###	Process Flow
For the process flow of this profile and its interplay with the other profiles see [sequence diagrams](sequencediagrams.html). 

### Security Consideration
This national extension enforces authentication and authorization of access to the Patient Identity Manager using the IUA profile with extended access token as described in [IUA](iti-71.html#expected-actions-1).
