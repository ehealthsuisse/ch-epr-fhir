Instance: Ldap
InstanceOf: NamingSystem
Usage: #definition
* name = "LDAP"
* status = #active
* kind = #identifier // codesystem | identifier | root
* date = "2025-05-13"
* responsible = "IETF"
* description = "NamingSystem for Lightweight Directory Access Protocol (LDAP); [https://www.ietf.org/rfc/rfc4514.html](https://www.ietf.org/rfc/rfc4514.html)."
* uniqueId.type = #uri // oid | uuid | uri | other
* uniqueId.value = "urn:ietf:rfc:4514" 
* uniqueId.preferred = true


Instance: EhsEventTypeCode
InstanceOf: NamingSystem
Usage: #definition
* name = "EhsEventTypeCode"
* status = #active
* kind = #codesystem // codesystem | identifier | root
* date = "2025-05-13"
* responsible = "eHealth Suisse"
* description = "NamingSystem for event type code system from eHealth Suisse."
* uniqueId.type = #uri //oid | uuid | uri | other
* uniqueId.value = "urn:e-health-suisse:event-type-code" 
* uniqueId.preferred = true


Instance: IheEventTypeCode
InstanceOf: NamingSystem
Usage: #definition
* name = "IheEventTypeCode"
* status = #active
* kind = #codesystem // codesystem | identifier | root
* date = "2025-05-13"
* responsible = "IHE International"
* description = "NamingSystem for event type code from IHE."
* uniqueId.type = #uri //oid | uuid | uri | other
* uniqueId.value = "urn:ihe:event-type-code" 
* uniqueId.preferred = true


Instance: IheItiXds2013UniqueId
InstanceOf: NamingSystem
Usage: #definition
* name = "IheItiXds2013UniqueId"
* status = #active
* kind = #identifier // codesystem | identifier | root
* date = "2025-05-13"
* responsible = "IHE International"
* description = "NamingSystem for uniqueId from IHE."
* uniqueId.type = #uri //oid | uuid | uri | other
* uniqueId.value = "urn:ihe:iti:xds:2013:uniqueId" 
* uniqueId.preferred = true
