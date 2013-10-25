note
	description: "Summary description for {WEB_SOCKET_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_CONSTANTS

feature -- Constants

	crlf: STRING = "%R%N"

	HTTP_1_1: STRING = "HTTP/1.1 101 WebSocket Protocol Handshake"

	Upgrade: STRING = "Upgrade: WebSocket"

	Connection: STRING = "Connection: Upgrade"

	Sec_WebSocket_Origin: STRING = "Sec-WebSocket-Origin: "

	Sec_WebSocket_Protocol: STRING = "Sec-WebSocket-Protocol: "

	Sec_WebSocket_Location: STRING = "Sec-WebSocket-Location: "

	Sec_WebSocket_Version: STRING = "Sec-WebSocket-Version: "

	Sec_WebSocket_Extensions: STRING = "Sec-WebSocket-Extensions: "

	WebSocket_Origin: STRING = "WebSocket-Origin: "

	WebSocket_Protocol: STRING = "WebSocket-Protocol: "

	WebSocket_Location: STRING = "WebSocket-Location: "

	Origin: STRING = "Origin"

	Host: STRING = "Host"

	Server: STRING = "EWSS"

	Sec_WebSocket_Key: STRING = "Sec-WebSocket-Key"

	Key3: STRING = "key3"

	Start_frame: INTEGER_32 = 0x00

	End_frame: INTEGER_32 = 0xFF

	Ws_scheme: STRING = "ws://"

	Wss_scheme: STRING = "wss://"

	Magic_guid: STRING = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"

		-- The handshake from the client looks as follows:

		--        GET /chat HTTP/1.1
		--        Host: server.example.com
		--        Upgrade: websocket
		--        Connection: Upgrade
		--        Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==
		--        Origin: http://example.com
		--        Sec-WebSocket-Protocol: chat, superchat
		--        Sec-WebSocket-Version: 13

		--   The handshake from the server looks as follows:

		--        HTTP/1.1 101 Switching Protocols
		--        Upgrade: websocket
		--        Connection: Upgrade
		--        Sec-WebSocket-Accept: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=
		--        Sec-WebSocket-Protocol: chat

end
