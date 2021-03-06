note
	description: "Web Socket events"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEB_SOCKET_EVENT

inherit

	WEB_SOCKET_CONSTANTS

	REFACTORING_HELPER

feature -- Web Socket Interface

	on_message (conn: WEB_SOCKET_CONNECTION; a_message: STRING; a_binary: BOOLEAN)
			-- Called when a frame from the client has been receive
		require
			conn_attached: conn /= Void
			conn_valid: conn.is_open_read and then conn.is_open_write
		deferred
		end

	on_open (conn: WEB_SOCKET_CONNECTION; a_message: STRING)
			-- Called after handshake, indicates that a complete WebSocket connection has been established.
		require
			conn_attached: conn /= Void
			conn_valid: conn.is_open_read and then conn.is_open_write
		deferred
		end

	on_close (conn: WEB_SOCKET_CONNECTION; a_message: STRING)
			-- Called after the WebSocket connection is closed

		require
			conn_attached: conn /= Void
			conn_valid: conn.is_open_read and then conn.is_open_write
		do
			fixme ("Add log ")
			conn.send_message (close_message)
			conn.close
		ensure
			ws_conn_closed: conn.is_closed
		end

	body: STRING

	message: STRING
		do
			create Result.make_empty
			Result.append_code (129)
			Result.append_natural_64 (body.count.as_natural_64)
			Result.append (body)
		end

	close_message: STRING
		do
			create Result.make_empty
			Result.append_code (0x8)
		end

	set_body (a_body: STRING)
		do
			body := a_body
		end

end
