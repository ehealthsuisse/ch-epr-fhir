Profile: CHmCSD1AddAudit
Parent:  IHE.BasicAudit.Create // https://profiles.ihe.net/ITI/BALP/1.1.3/StructureDefinition-IHE.BasicAudit.Create.html
Id:      mCSD.Add.Audit
Title:   "CH mCSD Audit Event: CH:mCSD-1 Add Care Service"
Description: "This profile describes the event of adding a Care Service to the Care Services Directory by the Care Services Source actor. It applies to both the Source and Directory actors."
* insert mcsd-ch1-basis

Profile: CHmCSD1UpdateAudit
Parent:  IHE.BasicAudit.Update // https://profiles.ihe.net/ITI/BALP/1.1.3/StructureDefinition-IHE.BasicAudit.Update.html
Id:      mCSD.Update.Audit
Title:   "CH mCSD Audit Event: CH:mCSD-1 Update Care Service"
Description: "This profile describes the event of updating a Care Service in the Care Services Directory by the Care Services Source actor. It applies to both the Source and Directory actors."
* insert mcsd-ch1-basis

Profile: CHmCSD1DeleteAudit
Parent:  IHE.BasicAudit.Delete // https://profiles.ihe.net/ITI/BALP/1.1.3/StructureDefinition-IHE.BasicAudit.Delete.html
Id:      mCSD.Delete.Audit
Title:   "CH mCSD Audit Event: CH:mCSD-1 Delete Care Service"
Description: "This profile describes the event of deleting a Care Service from the Care Services Directory by the Care Services Source actor. It applies to both the Source and Directory actors."
* insert mcsd-ch1-basis


RuleSet: mcsd-ch1-basis
* agent[client] ^short = "Care Services Source agent"
* agent[server] ^short = "Care Services Directory agent"