Profile: CHPIXmPatientFeed
Parent: CHPDQmPatient
Id: ch-pixm-patient-feed
Title: "CH PIXm Patient Feed"
Description: "The patient demographics and identifier information which can be provided in the PIXm Feed according to the EPR. The EPR-SPID as an identifier SHALL be added. The birthname can be added with the  ISO 21090 qualifier extension."
* identifier 2..
* identifier[LocalPid] ^sliceName = "LocalPid"

Profile: PIXm_IN_Parameters_CH
Parent: $IHE.PIXm.Query.Parameters.In
Id: ch-pixm-in-parameters
Title: "CH PIXm IN Parameters"
Description: "The StructureDefinition defines the Input Parameters for the $ihe-pix operation: - Input: sourceIdentifier, targetSystem"
* parameter[sourceIdentifier] 1..1
* parameter[sourceIdentifier] ^short = "sourceIdentifier"
* parameter[sourceIdentifier].name = "sourceIdentifier" (exactly)
* parameter[sourceIdentifier].valueIdentifier 1..
* parameter[sourceIdentifier].valueIdentifier only Identifier
* parameter[sourceIdentifier].valueIdentifier.system 1..
* parameter[sourceIdentifier].valueIdentifier.value 1..
* parameter[targetSystem] 1..2
* parameter[targetSystem] ^short = "targetSystem"
* parameter[targetSystem].name = "targetSystem" (exactly)
* parameter[targetSystem].valueUri 1..
* parameter[targetSystem].valueUri only uri

Profile: IHE_PIXm_OUT_Parameters_CH
Parent: $IHE.PIXm.Query.Parameters.Out
Id: ch-pixm-out-parameters
Title: "CH PIXm OUT Parameters"
Description: "The StructureDefinition defines the Output Parameters for the $ihe-pix operation: "
* parameter ..3
* parameter[targetId] 0..1
* parameter[targetId] ^short = "targetId"
* parameter[targetId].name = "targetId" (exactly)
* parameter[targetId].valueReference only Reference(CHPDQmPatient)
* parameter[targetId].valueReference ^type.aggregation = #referenced
* parameter[targetId].valueReference.reference ^short = "Absolute URL"
* parameter[targetIdentifier] 0..2
* parameter[targetIdentifier] ^short = "targetIdentifier"
* parameter[targetIdentifier].name = "targetIdentifier" (exactly)