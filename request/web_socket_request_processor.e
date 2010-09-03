note
	description: "Summary description for {WEB_SOCKET_REQUEST_PROCESSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_REQUEST_PROCESSOR
	inherit
	THREAD
	WEB_SOCKET_CONSTANTS
	SHARED_WEB_SOCKET_EVENT
	REFACTORING_HELPER
create
	make
feature -- Initialization

	make (a_client_socket : WEB_SOCKET_CONNECTION)
		do
			create method.make_empty
			create uri.make_empty
			is_data_frame_ok := True
			create request_header_map.make (10)
			ws_conn := a_client_socket
		ensure
			 ws_conn_set: ws_conn ~ a_client_socket
		end

feature -- Process
	execute
		local
			lw_response : STRING
			l_client_message : STRING
		do
			from
				is_handshake := False
			until
				False
			loop
				if not is_handshake then
					opening_handshake
				else
					l_client_message := read_data_framing
					print ("%NClient send:" + l_client_message)

					if is_data_frame_ok then
						event.on_message (ws_conn,l_client_message)
				    else
				    	-- To close the connection cleanly, a frame consisting of just a 0xFF
   						-- byte followed by a 0x00 byte is sent from one peer to ask that the
   						-- other peer close the connection. (This will change in the next specification)
				     	fixme ("Improve handling error, and message error")
						event.on_close (ws_conn, "Data frame is not Ok")
					end
				end
			end
		end


feature -- Access
	ws_conn : WEB_SOCKET_CONNECTION

	is_handshake : BOOLEAN

	request_header_map : HASH_TABLE [STRING,STRING]
			-- Containts key value of the header

	current_request_message: STRING
			-- Stores the current request message received from http server

	method :  STRING
		-- http verb

	uri   :	 STRING
		--  http endpoint		

	version : STRING
		--  http_version

	is_data_frame_ok : BOOLEAN

feature {NONE}-- WebSocket Request Processing

	read_data_framing : STRING
			-- Data is sent in the form of UTF-8 text.  Each frame of data starts
 			-- with a 0x00 byte and ends with a 0xFF byte, with the UTF-8 text in
   			-- between. (this will change in the next specification)

		local
			end_of_frame : BOOLEAN
		do
			fixme ("TODO:  handling errors")
			ws_conn.read_stream_thread_aware (1)
			if ws_conn.last_string.at (1).code = start_frame then
				from
					end_of_frame := False
					create Result.make_empty
				until
					end_of_frame
				loop
					ws_conn.read_stream_thread_aware (1)
					if ws_conn.last_string.at (1).code = end_frame then
						end_of_frame := True
					else
						Result.append (ws_conn.last_string)
					end
				end
			else
				is_data_frame_ok := False
			end
		end


	opening_handshake
			-- The openning handshake is intended to be compatible with HTTP-based server
			-- side software.
			-- To this end, the WebSocket client's handshake appears to
   			-- HTTP servers to be a regular GET request with an Upgrade offer:
			--
			-- GET / HTTP/1.1
        	-- Upgrade: WebSocket
        	-- Connection: Upgrade
			--
			-- Optionals fields are used to select options in the WebSocket Protocol
			-- Sec-WebSocket-Protocol : subprotocol selector
			-- Cookie :  which can used for sending cookies to the server (e.g. as an authentication
			--
			-- Security related fields
			-- Host : field is used to protect against DNS rebinding attacks and to allow multiple domains to be served from one IP address.
			-- Sec-WebSocket-Location : the server include the hostname in this field of its handshake, so that both the client and the server can
   			--							verify that they agree on which host is in use.
   			-- Origin : field is used to protect against unauthorized cross-origin use of a WebSocket server by scripts using the |WebSocket| API
   			--			in a Web browser.  The server specifies which origin it is willing to
			--		    receive requests from by including a |Sec-WebSocket-Origin| field
			--		    with that origin.  If multiple origins are authorized, the server
			--		    echoes the value in the |Origin| field of the client's handshake.
			-- Finally the server has to prove to the client that it received the client's webSocket handshake, so that the server does not
			-- accept connections that are not WebSocket connections.

		local
			message: detachable STRING
		do
 	  		 	fixme ("TODO: Rename and handle errors, client did not send a valid handshake")
 	  		 	parse_request_line
           	    message := receive_message_internal
           	    print ("%NMessage:" + message)
            	send_handshake (ws_conn)
            	is_handshake := True
            	print ("%NHandshake completed")
         end


	parse_request_line
        do
        	ws_conn.read_line_thread_aware
			parse_request_line_internal (ws_conn.last_string)
		end



	receive_message_internal : STRING
        local
        	end_of_stream : BOOLEAN
        	pos : INTEGER
        	line : STRING
        do
            from
                ws_conn.read_line_thread_aware
                Result := ""
            until
                end_of_stream
            loop
                line := ws_conn.last_string
                print ("%N" +line+ "%N")
                pos := line.index_of(':',1)
               	request_header_map.put (line.substring (pos + 1, line.count), line.substring (1,pos-1))
                Result.append(ws_conn.last_string)
                if not ws_conn.last_string.is_equal("%R") and ws_conn.socket_ok  then
                	ws_conn.read_line_thread_aware
        		else
        			ws_conn.read_stream_thread_aware (8)
        			request_header_map.put (ws_conn.last_string,key3)
        			end_of_stream := True
        		end
        	end
		end


	parse_request_line_internal (line: STRING)
		require
			line /= Void
		local
			pos, next_pos: INTEGER
		do
			print ("%Nparse request line:%N" + line)
			pos := line.index_of (' ', 1)
			method := line.substring (1, pos - 1)
			next_pos := line.index_of (' ', pos+1)
			uri := line.substring (pos+1, next_pos-1)
			version := line.substring (next_pos + 1, line.count)
		ensure
			not_void_method: method /= Void
		end



    send_handshake (a_http_socket: WEB_SOCKET_CONNECTION)
    		-- This method has to take three pieces of information and combine them to form a response.  The
   			-- first two pieces of information come from the |Sec-WebSocket-Key1|
   			-- and |Sec-WebSocket-Key2| fields in the client handshake
   			-- For each of these fields, the server has to take the digits from the value to obtain a number ,
   			-- then divide that number by the number of spaces characters in the value to obtain a 32-bit number.
   			-- These two resulting numbers are then used in the server handshake, as described below.
			--
		   	-- The counting of spaces is intended to make it impossible to smuggle this field into the resource name;
		   	-- making this even harder is the presence of _two_ such fields, and the use of a newline as the only
		   	-- reliable indicator that the end of the key has been reached.  The use of random characters interspersed with the spaces and the numbers
		   	-- ensures that the implementor actually looks for spaces and newlines, instead of being treating any character like a space, which would
		   	-- make it again easy to smuggle the fields into the path and trick the server.  Finally, _dividing_ by this number of spaces is intended to
		  	-- make sure that even the most naive of implementations will check for spaces, since if ther server does not verify that there are some
		   	-- spaces, the server will try to divide by zero, which is usually fatal (a correct handshake will always have at least one space).
		   	--
		   	-- The third piece of information is given after the fields, in the last eight bytes of the handshake, expressed here as they would be seen if
   			-- interpreted as ASCII:
   			--
   			-- The concatenation of the number obtained from processing the |Sec-WebSocket-Key1| field, expressed as a big-endian 32 bit number, the
   			-- number obtained from processing the |Sec-WebSocket-Key2| field, again expressed as a big-endian 32 bit number, and finally the eight bytes
   			-- at the end of the handshake, form a 128 bit string whose MD5 sum is then used by the server to prove that it read the handshake.

        	local
        		l_handshake : STRING
        		l_origin : STRING
        	do
        		create l_handshake.make_empty
        		l_handshake.append (Http_1_1)
        		l_handshake.append (crlf)
        		-- The following two fields are just for compatibility with HTTP
        		l_handshake.append (Upgrade)
        		l_handshake.append (crlf)
        		l_handshake.append (Connection)
        		l_handshake.append (crlf)
        		-- The following two fields are part of the security model
        		-- echoing the origin and stating the exact host, port and resource name and if
        		-- the connection is expected to be encrypted.
				l_handshake.append (resolve_location)
        		l_handshake.append (crlf)
				l_origin := request_header_map.at (Origin)
				if l_origin /= Void then
					l_origin.left_adjust
					l_origin.right_adjust
				end
        		l_handshake.append (sec_websocket_origin + l_origin)
        		to_implement ("Implement subprotocol logic")
        		-- 
--        		l_handshake.append (crlf)
--        		l_handshake.append (sec_websocket_protocol+"default")
				l_handshake.append (crlf)
				l_handshake.append (crlf)
				l_handshake.append (send_reply)
				print("%NServer Handshake:"+l_handshake + "%N")
				a_http_socket.send_message (l_handshake)
        	end


	resolve_location : STRING
		local
			l_host : STRING
		do
			    create Result.make_empty
        		Result.append (sec_websocket_location)
        		Result.append (ws_scheme)
        		l_host := request_header_map.at (Host)
        		l_host.left_adjust
        		l_host.right_adjust
        		Result.append (l_host)
       			Result.append (uri)
   		end

	send_reply : STRING
		local
			i :  INTEGER
			key1: INTEGER
			key2: INTEGER
			l_key3 : STRING
			part1 : ARRAY [INTEGER]
			part2 : ARRAY [INTEGER]
			md5: CRYPT_MD5
			md5_str : STRING
			in_bytes : CRYPT_16BYTES_SIMPLE
			l_array : ARRAY[CHARACTER_8]
		do
			create md5.make
			key1 := extract_number (request_header_map.item (sec_websocket_key1))
			key2 := extract_number (request_header_map.item (sec_websocket_key2))
			l_key3 := request_header_map.item (Key3)
			create md5_str.make_empty

			part1 := from_integer_to_big_endian (key1)
			part2 := from_integer_to_big_endian (key2)

			create in_bytes
			in_bytes.set_1 (part1[1])
			in_bytes.set_2 (part1[2])
			in_bytes.set_3 (part1[3])
			in_bytes.set_4 (part1[4])
			in_bytes.set_5 (part2[1])
			in_bytes.set_6 (part2[2])
			in_bytes.set_7 (part2[3])
			in_bytes.set_8 (part2[4])
			in_bytes.set_9 (l_key3.at (1).code)
			in_bytes.set_10 (l_key3.at (2).code)
			in_bytes.set_11 (l_key3.at (3).code)
			in_bytes.set_12 (l_key3.at (4).code)
			in_bytes.set_13 (l_key3.at (5).code)
			in_bytes.set_14 (l_key3.at (6).code)
			in_bytes.set_15 (l_key3.at (7).code)
			in_bytes.set_16 (l_key3.at (8).code)
			md5.update_bytes (in_bytes)
			md5.final
			l_array := md5.digest.as_character_array
			create Result.make_empty
			from
                i := 1
            until
                i> l_array.count
            loop
                Result.append(l_array.at (i).out)
                i := i + 1
            end
		end

    extract_number(a_string : STRING) : INTEGER_32
		local
			l_num : STRING
			l_sp : INTEGER
			i : INTEGER
			aux : INTEGER_64
		do
			fixme ("Improve: Method")
			a_string.left_adjust
			from
				create l_num.make_empty
				l_sp := 0
				i := 1
			until
				i > a_string.count
			loop
				if a_string.at (i).is_digit then
					l_num.append (a_string.at (i).out)
				elseif a_string.at (i).is_equal (' ') then
					l_sp := l_sp + 1
				else
					debug
						print ("%N Element:"+a_string.at (i).out)
					end

				end
				i := i + 1
			end
			aux := (l_num.to_integer_64 // l_sp)
			Result := aux.as_integer_32
		end

	from_integer_to_big_endian ( a_key : INTEGER_32) : ARRAY [INTEGER]
		do
			create Result.make (1,4)
			Result [1] := (a_key |>> 24).to_natural_8
			Result [2] := (a_key |>> 16).to_natural_8
			Result [3] := (a_key |>> 8).to_natural_8
			Result [4] := a_key.to_natural_8
		ensure
			byte_0: Result [1] = (a_key |>> 24).to_natural_8
			byte_1: Result [2] = (a_key |>> 16).to_natural_8
			byte_2: Result [3] = (a_key |>> 8).to_natural_8
			byte_3: Result [4] = a_key.to_natural_8
		end


invariant
		connection_attached: ws_conn /= Void

end
