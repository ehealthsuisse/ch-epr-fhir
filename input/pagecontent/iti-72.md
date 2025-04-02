This section describes the national extension for the Swiss EPR to
the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction
defined in the IUA profile published in the IHE IT Infrastructure Technical Framework Trial Implementation “Internet
User Authorization”.

### Scope

This transaction is used to incorporate authorization information into HTTP RESTful transactions.

### Actor Roles

**Actor:** IUA Authorization Client  
**Role:** Authorization component of a HTTP RESTful transaction client.      
**Actor:** IUA Resource Server  
**Role:** Authorization component of a HTTP RESTful transaction server.


This national extension restricts the Actor options of the IUA Trial Implementation to comply to the legal requirements
of the Swiss EPR.

The IUA Trial Implementation supports three options for the Authorization Token format; the JWT Token, the SAML Token
and the Token Introspection option. Since this national extension will apply to cross community communication, the Token
Introspection Option SHALL NOT be used.

### Referenced Standards

1. [IHE ITI Technical Framework Supplement Internet User Authorization (IUA) Revision 2.2](https://profiles.ihe.net/ITI/IUA/index.html)

### Security Consideration

IUA Authorization Clients, Authorization Servers and Resource Server actors SHALL use the JWS (signed) alternative
of the JWT token as specified in the IUA Trial Implementation. The JWE alternative SHALL not be used.

When receiving requests of transactions where the EPR-SPID is provided in the IUA token and in the transaction body,
the Resource Servers SHALL verify that both are the same.

The actors SHALL support the _traceparent_ header handling, as defined in [Appendix: Trace Context](tracecontext.html).