### Trace Context header

For all transaction described in this implementation guide, the HTTP `traceparent` header is specified. This header 
is defined in the [W3C Trace Context Recommendation](https://www.w3.org/TR/trace-context/).

The header value is made of four parts separated by dashes: the **version**, **trace-id**, **parent-id** and
**trace-flags**. For example:

```http
GET /request HTTP/1.1
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00
```

- The **version** is currently set to `00`.
- The **trace-id** is a unique identifier for this transaction instance (i.e. an HTTP request and its response).
  It is a 16-byte array encoded as 32 hexadecimal characters, all lowercase.
- The **parent-id** is a unique identifier for this message. It is an 8-byte array, encoded as 16 hexadecimal
  characters, all lowercase. 
- The **trace-flags** is used to communicate tracing flags with the consumer. This implementation guide specifies no
  requirements for this field, it is recommended using the value `00`.

Each actor shall support the `traceparent` header. Grouped actors shall use the same **trace-id** value to correlate
IHE transactions.

Actors of all transactions SHALL support the W3C Trace Context Recommendation and 
SHOULD send the HTTP header `traceparent` in requests.

Moreover, when serving incoming requests, each actor SHALL:
-	Accept the HTTP header `traceparent` if it is contained in the incoming request, oth-erwise — generate it.
-	Send the HTTP header `traceparent` in all requests induced by the incoming request, with the same value of the field trace id as for the incoming request.

##### Audit event requirements

The `traceparent` header value of the generated message SHALL be added to the generated Audit Event: for the client,
the header value of the request; for the responder, the header value of the response.
It is described as an `AuditEvent.entity`, with the system 
`https://profiles.ihe.net/ITI/BALP/CodeSystem/BasicAuditEntityType#Traceparent`, as demonstrated below.

```json
{
  "resourceType" : "AuditEvent",
  /* Rest of the AuditEvent */
  "entity" : [
    {
      "what" : {
        "identifier" : {
          "value" : "00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00"
        }
      },
      "type" : {
        "system" : "https://profiles.ihe.net/ITI/BALP/CodeSystem/BasicAuditEntityType",
        "code" : "Traceparent"
      }
    }
  ]
}
```
