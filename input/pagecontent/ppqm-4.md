
#### PPQ-4: Mobile Privacy Policy Bundle Feed

To manipulate policies _groupwise_, the __Mobile Privacy Policy Bundle Feed__ transaction (PPQ-4) can be used:

<div>{% include PPQ-4.svg %}</div>

The request is a [PpqmFeedRequestBundle](StructureDefinition-PpqmFeedRequestBundle.html)
resource containing one or more [PpqmConsent](StructureDefinition-PpqmConsent.html)
resources (for add and update operations) or references to them (for the delete operation).
