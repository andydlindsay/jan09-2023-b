# W03D03 - HTTP Cookies & User Authentication

### To Do
- [x] HTTP and cookies
- [x] Render pages differently based on language preference
- [x] Register user with email and password

### HTTP
* stateless protocol
* neither party HAS to remember any previous communication

### Cookies
* a key/value pair stored in the client (browser)
* always set by the server
* browser will send ALL cookies for a domain with EVERY request
* cookies are domain-specific
* life span === time to live TTL


urlencoding
username=alice&password=1234

req.body
{
  username: 'alice',
  password: '1234'
}

username=alice%20miller&password=1234











