# W02D03 - Networking with TCP

### To Do
- [x] Discuss networking and the need for protocols
- [x] TCP introduction
- [x] TCP demo
- [ ] HTTP fundamentals [stretch]

### Networking
* computers talking to each other
* internet

### Internet Protocol
* street address for the computer we want to talk to
* IPv4 127.0.0.1 192.168.2.2
* IPv6 2001:db8:3333:4444:5555:6666:7777:8888

MAC Address - permanent address for a device

### Port
* uniquely identifies an app running on the other computer
* 65,535 ports to choose from
  * HTTP 80
  * HTTPS 443
  * SSH 22
  * Postgres 5432
  * 3000 - 9000
  * Minecraft 25565

### Transport Control Protocol (TCP)
* Breaks your message down into packets (envelope)
* Header holds the information of the recipient and the sender
* Triple handshake
* Lost packets are resent
* Packets are reordered when they arrive

### User Datagram Protocol (UDP)
* For streaming/low latency
* Connectionless protocol
* Packets are NOT resent

### Event-driven Programming
* program moves forward when an event occurs

Clients - wants something from the server
Servers - has something the client wants


all characters are stored as 1's and 0's
encoding


\n


Snek
'Name: ADL'
'Move: down'

'up'

wasd
data === 'k'
'Move: up'
data === 's'
'Move: down'