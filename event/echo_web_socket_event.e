note
	description: "Summary description for {ECHO_WEB_SOCKET_EVENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	ECHO_WEB_SOCKET_EVENT

inherit

	WEB_SOCKET_EVENT

create
	make

feature {NONE} -- Initialization

	make
		do
			set_body (create {STRING}.make_empty)
		ensure
			body_set: body.is_empty
		end


feature -- WebSocket Event

	on_message (conn: WEB_SOCKET_CONNECTION; a_message: STRING)
			-- Called when a frame from the client has been receive
		do
			set_body (a_message)
			conn.send_message (message)
		end

	on_open (conn: WEB_SOCKET_CONNECTION; a_message: STRING)
			-- Called after handshake, indicates that a complete WebSocket connection has been established.
		do
		end

end
