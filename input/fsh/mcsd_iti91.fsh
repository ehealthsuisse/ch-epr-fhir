Instance: mCSDITI91ResponseBundle
InstanceOf: Bundle
Title: "mCSD Request Care Services Updates Response Bundle"
Description: "An exemple of ITI-91 response Bundle in the profile CH mCSD"
* type = #history

// First entry, an addition
* entry[+].request.method = #PUT
* entry[=].request.url = "TODO?"
* entry[=].response.status = "201"
* entry[=].response.lastModified = "2014-08-15T10:35:02.034Z"
* entry[=].resource = CHmCSDOrganizationSpitalX

// Second entry, a deletion
* entry[+].request.method = #DELETE
* entry[=].request.url = "TODO?"
* entry[=].response.status = "200"
* entry[=].response.lastModified = "2014-08-20T11:05:34.174Z"

// Third entry, a modification
// TODO
