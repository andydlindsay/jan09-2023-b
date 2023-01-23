# W03D01 - Web Servers 101

### To Do
- [x] Web Servers
- [x] Express
- [x] Middleware
- [x] Common Errors
  - [x] Address in Use EADDRINUSE
  - [x] Cannot Set Headers

http://www.bestbuy.ca

http://localhost:8080/u/640zlf

### Web Server
* serve files that are used by the web HTML, CSS, JS, JSON
* speak HTTP

### HTTP
* HyperText Transfer Protocol
* built on top of TCP

IP === street address
PORT === apt number

* each back-and-forth is made up of a `request` and a `response`

response
client <========= TCP/HTTP =========> server

### Request
* verb/method === what we want to do
* path/url === what we want to do it to

* Methods: GET and POST
  * GET === retrieve information (getter)
  * POST === set information (setter)
* Url: / (root), /users, /urls, /blogposts

GET /urls
POST /urls

http://localhost:8001 /products


### Response
* has to have a status code
  * 200 - okay
  * 404 - resource not found
  * 500 - server problem

if (statusCode >== 200 && statusCode < 400) {}

* 1xx - routing codes
* 2xx - everything is okay
* 3xx - redirections
* 4xx - problem with request
* 5xx - server problem

### Middleware
* middleware is code (in the form of a function) that runs between the request and the response

                                  request
client <=====> middleware <===> middleware <==> middleware <=====> route handler
               body-parser      cookie-parser                       request.body
               request.body     request.cookies 
                next()            next()

