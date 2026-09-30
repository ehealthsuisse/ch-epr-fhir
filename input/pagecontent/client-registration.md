<div markdown="1" class="dragon">
This page is work in progress, see [#11](https://github.com/ehealthsuisse/ch-health-dossier/issues/11).
</div>

### Scope

This page describes how an IUA Authorization Client is registered at the IUA Authorization Server, so that it can
request access tokens with [ITI-71](iti-71.html). During the registration the client receives its `client_id` and
exchanges its public key used for the client authentication and the HTTP message signature of the token request.

### Dynamic Client Registration

TODO: registration of a client with [OAuth 2.0 Dynamic Client Registration Protocol (RFC 7591)](https://www.rfc-editor.org/rfc/rfc7591).
