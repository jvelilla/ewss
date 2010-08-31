note
	description: "Summary description for {WEB_SOCKET_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEB_SOCKET_EVENT
	inherit
		WEB_socket_constants

feature -- Web Socket Interface

	on_message 	( conn: TCP_STREAM_SOCKET; a_message : STRING)
			-- Called when a frame from the client has been receive
		deferred
		end


	on_open	( conn: TCP_STREAM_SOCKET; a_message : STRING)
			-- Called after handshake, indicates that a complete WebSocket connection has been established.
		deferred
		end


	on_close ( conn: TCP_STREAM_SOCKET; a_message : STRING)
			-- Called after the WebSocket connection is closed
		deferred
		end

	body : STRING

	message : STRING
		do
			create Result.make_empty
			Result.append_code (start_frame.as_natural_32)
			Result.append (body)
			Result.append_code(end_frame.as_natural_32)
		end

	set_body (a_body : STRING)
		do
			body := a_body
		end
end
