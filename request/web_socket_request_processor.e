note
	description: "Summary description for {WEB_SOCKET_REQUEST_PROCESSOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_REQUEST_PROCESSOR

inherit

	THREAD
		rename
			make as make_thread
		end

	SHARED_BASE64

	WEB_SOCKET_CONSTANTS

	SHARED_WEB_SOCKET_EVENT

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_client_socket: WEB_SOCKET_CONNECTION)
		do
			make_thread
			ws_conn := a_client_socket
			is_closed := False
			reset
		ensure
			ws_conn_set: ws_conn = a_client_socket
		end

	reset
			-- Reset the parser
		do
			create header.make_empty
			create header_map.make (10)
			create method.make_empty
			create uri.make_empty
			create version.make_empty
			has_error := False
			is_data_frame_ok := True
			is_binary := False
		end

feature -- Process

	execute
		local
			lw_response: STRING
			l_client_message: STRING
		do
			from
				is_handshake := False
			until
				False or else has_error or is_closed
			loop
				if not is_handshake then
					opening_handshake
				else
					if ws_conn.ready_for_reading then
						l_client_message := read_data_framing
						if is_data_frame_ok then
							event.on_message (ws_conn, l_client_message,is_binary)
						else
							event.on_close (ws_conn, "Data frame is not Ok")
							is_closed := True
						end
					end
				end
			end
			if has_error then
				if not ws_conn.is_closed then
					event.on_close (ws_conn, "Data frame is not OK")
				end
			end
		end

feature -- Access

	header: STRING
			-- Header' source
			-- Stores the current request message received from http server

	ws_conn: WEB_SOCKET_CONNECTION

	is_handshake: BOOLEAN

	header_map: HASH_TABLE [STRING, STRING]
			-- Containts key value of the header

	method: STRING
			-- http verb

	uri: STRING
			--  http endpoint

	version: STRING
			--  http_version

	is_data_frame_ok: BOOLEAN

	is_closed: BOOLEAN

	is_binary: BOOLEAN


feature -- Status report

	has_error: BOOLEAN
			-- Error occurred during `parse'

	is_verbose: BOOLEAN
			-- Is verbose for output messages

feature -- Element change

	enable_verbose
			-- Enable version bose.
		do
			is_verbose := True
		ensure
			verbose: is_verbose
		end

feature {NONE} -- WebSocket Request Processing

	read_data_framing: STRING
			-- TODO Binary messages
			-- Handle error responses in a better way.
			-- IDEA:
			-- class FRAME
			-- 		is_fin: BOOLEAN
			--		opcode: WEB_SOCKET_STATUS_CODE (TEXT, BINARY, CLOSE, CONTINUE,PING, PONG)
			--		data/payload
			--      status_code: #see Status Codes http://tools.ietf.org/html/rfc6455#section-7.3
			--		has_error
		note
			EIS: "name=Data Frame", "src=http://tools.ietf.org/html/rfc6455#section-5", "protocol=uri"
		local
			l_opcode: INTEGER
			l_len: INTEGER
			l_encoded: BOOLEAN
			l_utf: UTF_CONVERTER
			l_key: STRING
			i: INTEGER
			l_frame: STRING
			l_rsv: BOOLEAN
			l_fin: BOOLEAN
		do
			create Result.make_empty
			from
			until
				l_fin or not is_data_frame_ok
			loop
					-- multi-frames or continue is only valid for Binary or Text
				ws_conn.read_stream (1)
				l_opcode := ws_conn.last_string.at (1).code
				debug
					print (to_byte (l_opcode).out)
				end
				l_fin := l_opcode & (0b10000000) /= 0
				l_rsv := l_opcode & (0b01110000) = 0
				l_opcode := l_opcode & 0xF
				log ("Standard Action:" + l_opcode.out)

					-- fin validation
				if not l_fin then
						-- Control frames (see Section 5.5) MAY be injected in the middle of
						--a fragmented message.  Control frames themselves MUST NOT be fragmented.
						-- if the l_opcode is a control frame then there is an error!!!
						-- PING, PONG, CLOSE
					if l_opcode = 8 or else l_opcode = 9 or l_opcode = 10 then
						is_data_frame_ok := False
					end
				end

					-- rsv validation
				if not l_rsv then
					is_data_frame_ok := False
						-- RSV1, RSV2, RSV3:  1 bit each

						-- MUST be 0 unless an extension is negotiated that defines meanings
						-- for non-zero values.  If a nonzero value is received and none of
						-- the negotiated extensions defines the meaning of such a nonzero
						-- value, the receiving endpoint MUST _Fail the WebSocket
						-- Connection_
				end

				is_binary := l_opcode = 2

					-- At the moment only TEXT, (pending Binary)
				if (l_opcode = 1  or l_opcode = 2) and then is_data_frame_ok then -- TEXT
					ws_conn.read_stream (1)
					l_len := ws_conn.last_string.at (1).code
					debug
						print (to_byte (l_len).out)
					end
					l_encoded := l_len >= 128
					if l_encoded then
						l_len := l_len - 128
					end
					if l_len = 127 then
						ws_conn.read_stream (8)
						l_len := (ws_conn.last_string[6].code |<< 16).bit_or(ws_conn.last_string[7].code |<< 8).bit_or(ws_conn.last_string[8].code)
					elseif l_len = 126 then
						ws_conn.read_stream (2)
						l_len := (ws_conn.last_string[1].code |<< 8).bit_or(ws_conn.last_string[2].code)
					end
					if l_encoded then
						ws_conn.read_stream (4)
						l_key := ws_conn.last_string
						ws_conn.read_stream (l_len)
						l_frame := ws_conn.last_string
						from
							i := 1
						until
							i > l_frame.count
						loop
							l_frame [i] := (l_frame [i].code.to_integer_8.bit_xor (l_key [((i - 1) \\ 4) + 1].code.to_integer_8)).to_character_8
							i := i + 1
						end
						if l_opcode = 1 then
							Result.append (l_utf.string_32_to_utf_8_string_8 (l_frame))
						else
							Result.append (l_frame)
						end
						log ("Received <===============")
						log (Result)
					end
				else
					is_data_frame_ok := False
				end

			end
		end

	opening_handshake
			-- The opening handshake is intended to be compatible with HTTP-based
			-- server-side software and intermediaries, so that a single port can be
			-- used by both HTTP clients alking to that server and WebSocket
			-- clients talking to that server.  To this end, the WebSocket client's
			-- handshake is an HTTP Upgrade request:

			--    GET /chat HTTP/1.1
			--    Host: server.example.com
			--    Upgrade: websocket
			--    Connection: Upgrade
			--    Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==
			--    Origin: http://example.com
			--    Sec-WebSocket-Protocol: chat, superchat
			--    Sec-WebSocket-Version: 13
		note
			EIS: "name=Server Side Requirements", "src=http://tools.ietf.org/html/rfc6455#section-4.2", "protocol=uri"
			EIS: "name=Reading the Client's Opening Handshake", "src=http://tools.ietf.org/html/rfc6455#section-4.2.1", "protocol=uri"
			EIS: "name=Sending the Server's Opening Handshake", "src=http://tools.ietf.org/html/rfc6455#section-4.2.2", "protocol=uri"
		local
			l_sha1: SHA1
			l_key, l_handshake: STRING
		do
			parse (ws_conn)
				-- Reading client's opening GT

				-- TODO extract to a validator handshake or something like that.
			log ("Receive <====================")
			log (header)
			if method.same_string ("GET") then --item MUST be GET
				if attached header_map.item (Sec_WebSocket_Key) as l_ws_key and then -- Sec-websocket-key must be present
					attached header_map.item ("Upgrade") as l_upgrade_key and then -- Upgrade header must be present with value websocket
					l_upgrade_key.is_case_insensitive_equal ("websocket") and then attached header_map.item ("Connection") as l_connection_key and then -- Connection header must be present with value Upgrade
					l_connection_key.has_substring ("Upgrade") and then attached header_map.item ("Sec-WebSocket-Version") as l_version_key and then -- Version header must be present with value 13
					l_version_key.is_case_insensitive_equal ("13") and then attached header_map.item ("Host") -- Host header must be present
				then
					log ("key " + l_ws_key)
						-- Sending the server's opening handshake
					l_ws_key.append_string (Magic_guid)
					create l_sha1.make
					l_sha1.update_from_string (l_ws_key)
					l_key := Base64_encoder.encoded_string (digest (l_sha1))
					create l_handshake.make_from_string ("HTTP/1.1 101 Switching Protocols%R%N")
					l_handshake.append_string ("Upgrade: websocket%R%N")
					l_handshake.append_string ("Connection: Upgrade%R%N")
					l_handshake.append_string ("Sec-WebSocket-Accept: ")
					l_handshake.append_string (l_key)
					l_handshake.append_string ("%R%N")
						-- end of header empty line
					l_handshake.append_string ("%R%N")
					io.put_new_line
					log ("================> Send")
					log (l_handshake)
					ws_conn.put_string (l_handshake)
					is_handshake := True -- the connection is in OPEN State.
				end
			end
			if not is_handshake then
				log ("Error!!!")
					-- If we cannot complete the handshake, then the server MUST stop processing the client's handshake and return an HTTP response with an
					-- appropriate error code (such as 400 Bad Request).
				has_error := True
				ws_conn.put_string ("HTTP/1.1 400 Bad Request")
					-- For now a simple Bad Request!!!.
			end
		end

feature -- Parse Request

	parse (a_socket: WEB_SOCKET_CONNECTION)
			-- Parse the HTTP request using `a_socket'.
		require
			input_readable: a_socket /= Void and then a_socket.is_open_read
		local
			end_of_stream: BOOLEAN
			pos, n: INTEGER
			line: detachable STRING
			k, val: STRING
			txt: STRING
		do
			reset
			create txt.make (64)
			header := txt
			if attached next_line (a_socket) as l_request_line and then not l_request_line.is_empty then
				txt.append (l_request_line)
				txt.append_character ('%N')
				analyze_request_line (l_request_line)
			else
				has_error := True
			end
			if not has_error or is_verbose then
					-- if `is_verbose' we can try to print the request, even if it is a bad HTTP request
				from
					line := next_line (a_socket)
				until
					line = Void or end_of_stream
				loop
					n := line.count
					if is_verbose then
						log (line)
					end
					pos := line.index_of (':', 1)
					if pos > 0 then
						k := line.substring (1, pos - 1)
						if line [pos + 1].is_space then
							pos := pos + 1
						end
						if line [n] = '%R' then
							n := n - 1
						end
						val := line.substring (pos + 1, n)
						header_map.put (val, k)
					end
					txt.append (line)
					txt.append_character ('%N')
					if line.is_empty or else line [1] = '%R' then
						end_of_stream := True
					else
						line := next_line (a_socket)
					end
				end
			end
		end

feature {NONE} -- Implementation

	analyze_request_line (line: STRING)
			-- Analyze `line' as a HTTP request line
		require
			valid_line: line /= Void and then not line.is_empty
		local
			pos, next_pos: INTEGER
		do
			if is_verbose then
				log ("%N## Parse HTTP request line ##")
				log (line)
			end
			pos := line.index_of (' ', 1)
			method := line.substring (1, pos - 1)
			next_pos := line.index_of (' ', pos + 1)
			uri := line.substring (pos + 1, next_pos - 1)
			version := line.substring (next_pos + 1, line.count)
			has_error := method.is_empty
		end

	next_line (a_socket: WEB_SOCKET_CONNECTION): detachable STRING
			-- Next line fetched from `a_socket' is available.
		require
			is_readable: a_socket.is_open_read
		do
			if a_socket.socket_ok then
				a_socket.read_line_thread_aware
				Result := a_socket.last_string
			end
		end

	log (a_message: READABLE_STRING_8)
			-- Log `a_message'
		do
			io.put_string (a_message)
			io.put_new_line
		end

	digest (a_sha1: SHA1): STRING
			-- Digest of `a_sha1'.
			-- Should by in SHA1 class
		local
			l_digest: SPECIAL [NATURAL_8]
			index, l_upper: INTEGER
		do
			l_digest := a_sha1.digest
			create Result.make (l_digest.count // 2)
			from
				index := l_digest.Lower
				l_upper := l_digest.upper
			until
				index > l_upper
			loop
				Result.append_character (l_digest [index].to_character_8)
				index := index + 1
			end
		end

	to_byte (a_integer: INTEGER): ARRAY [INTEGER]
		require
			valid: a_integer >= 0 and then a_integer <= 255
		local
			l_val: INTEGER
			l_index: INTEGER
		do
			create Result.make_filled (0, 1, 8)
			from
				l_val := a_integer
				l_index := 8
			until
				l_val < 2
			loop
				Result.put (l_val \\ 2, l_index)
				l_val := l_val // 2
				l_index := l_index - 1
			end
			Result.put (l_val, l_index)
		end

invariant
	connection_attached: ws_conn /= Void

end
