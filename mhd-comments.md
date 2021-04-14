Issues for MHD:

- package name 4.0.0-comment does not work with IG Publisher for dependent packages: Failed to resolve package ihe.mhd.fhir#4.0.0-comment from server: http://packages.fhir.org and  Error reading http://ihe.net/fhir/ihe.mhd.fhir/4.0.0-comment/package.tgz The issue is that current tooling does not accept suffix -comment. Use current as version instead.

- For MHD Rev. 3.2 – 2020-08-28 it was specified for Folder that "When the List.identifier carries the entryUUID, then the List.identifier.use shall be ‘official’. When the List.identifier carries the uniqueId, then the List.identifier.use shall be ‘usual’.", I propose this concept should be token over MHD List, because otherwise the identifers cannot be differentiated.

- There is no List ITI-66 response profile defined
