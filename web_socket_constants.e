note
	description: "Summary description for {WEB_SOCKET_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_CONSTANTS

feature -- Constants
	crlf: STRING = "%/13/%/10/"
	HTTP_1_1 : STRING = "HTTP/1.1 101 WebSocket Protocol Handshake"
	Upgrade  : STRING = "Upgrade: WebSocket"
    Connection : STRING ="Connection: Upgrade"
    Sec_WebSocket_Origin : STRING = "Sec-WebSocket-Origin: "
    Sec_WebSocket_Protocol : STRING ="Sec-WebSocket-Protocol: "
    Sec_WebSocket_Location : STRING ="Sec-WebSocket-Location: "
    WebSocket_Origin : STRING = "WebSocket-Origin: "
    WebSocket_Protocol : STRING ="WebSocket-Protocol: "
    WebSocket_Location : STRING ="WebSocket-Location: "
	Origin : STRING = "Origin"
	Host   : STRING = "Host"
	Server : STRING = "EWSS"
	Sec_WebSocket_Key1 :STRING = "Sec-WebSocket-Key1"
	Sec_WebSocket_Key2 :STRING = "Sec-WebSocket-Key2"
	Key3			   :STRING = "key3"
	Start_frame : INTEGER_32 = 0x00
	End_frame   : INTEGER_32 = 0xFF

	Ws_scheme : STRING = "ws://"
	Wss_scheme : STRING = "wss://"


--GET / HTTP/1.1
--Upgrade: WebSocket

--Connection: Upgrade

--Host: localhost:9090

--Origin: null

--Sec-WebSocket-Key1: ?2 75  9 Ku3 10 O 1  8  0

--Sec-WebSocket-Key2: C 7b' $ qI>D97 W   0  09 4 99



--Sec-WebSocket-Key2: C 7b' $ qI>D97 W   0  09 4 99
--Server Handshake:HTTP/1.1 101 WebSocket Protocol Handshake
--Upgrade: WebSocket
--Connection: Upgrade
--Sec-WebSocket-Location: ws://localhost:9090/
--Sec-WebSocket-Origin:  null


end
