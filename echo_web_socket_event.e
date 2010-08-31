note
	description: "Summary description for {ECHO_WEB_SOCKET_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECHO_WEB_SOCKET_EVENT
	inherit
		WEB_SOCKET_EVENT

create
	make
feature -- Initialization
	make
		do

		end
feature -- WebSocket Event

	on_message 	( conn: TCP_STREAM_SOCKET; a_message : STRING)
			-- Called when a frame from the client has been receive
		do
			set_body (a_message)
			conn.send_message (body)
		end


	on_open	( conn: TCP_STREAM_SOCKET; a_message : STRING)
			-- Called after handshake, indicates that a complete WebSocket connection has been established.
		do
		end


	on_close ( conn: TCP_STREAM_SOCKET; a_message : STRING)
			-- Called after the WebSocket connection is closed
		do
		end
end
