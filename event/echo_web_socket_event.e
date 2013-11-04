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

	on_message (conn: WEB_SOCKET_CONNECTION; a_message: STRING; a_binary: BOOLEAN)
			-- Called when a frame from the client has been receive
		local
			l_message: STRING
			l_string: STRING
		do
			create l_message.make_empty
			if a_binary then
				l_message.append_code (130)
			else
				l_message.append_code (129)
			end

			if a_message.count > 65535 then
				l_message.append_code (127)
				l_message.append_code ((a_message.count |>> 16).as_natural_32)
				l_message.append_code ((a_message.count |>> 8).as_natural_32)
				l_message.append_code (a_message.count.to_character_8.code.as_natural_32)
			elseif a_message.count > 125  then
				l_message.append_code (126)
				l_message.append_code ((a_message.count |>> 8).as_natural_32)
				l_message.append_code (a_message.count.to_character_8.code.as_natural_32)
			else
				l_message.append_code (a_message.count.as_natural_32)
			end
			l_message.append (a_message)
			conn.send_message (l_message)
		end

	on_open (conn: WEB_SOCKET_CONNECTION; a_message: STRING)
			-- Called after handshake, indicates that a complete WebSocket connection has been established.
		do
		end

end
