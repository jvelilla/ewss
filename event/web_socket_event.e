note
	description: "Summary description for {WEB_SOCKET_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEB_SOCKET_EVENT

inherit

	WEB_SOCKET_CONSTANTS

	REFACTORING_HELPER

feature -- Web Socket Interface

	on_message (conn: WEB_SOCKET_CONNECTION; a_message: STRING)
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
			conn.close_socket
		ensure
			ws_conn_closed: conn.is_closed
		end

	body: STRING

	message: STRING
		do
			create Result.make_empty
			Result.append_code (start_frame.as_natural_32)
			Result.append (body)
			Result.append_code (end_frame.as_natural_32)
		end

	close_message: STRING
		do
			create Result.make_empty
			Result.append_code (end_frame.as_natural_32)
			Result.append_code (start_frame.as_natural_32)
		end

	set_body (a_body: STRING)
		do
			body := a_body
		end

end
