note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_WEB_SOCKET

inherit
	EQA_TEST_SET
			redefine
				on_prepare,
				on_clean
			select
				default_create
			end
	INET_ADDRESS_FACTORY
			rename
				default_create as default_create_iaf
			end
	INET_PROPERTIES
			rename
				default_create as default_create_ip
			end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
		end

	on_clean
			-- <Precursor>
		do

		end


feature -- Test routines

	test_web_socket_connection
		local
			msg : STRING
			address: detachable INET_ADDRESS
		do
			address := create_from_name ("localhost")
			create ws_conn.make_client_by_address_and_port (address, 9090)
			ws_conn.set_connect_timeout (1000)
					-- Connect to the Server
			ws_conn.connect
			assert ("Connected", ws_conn.is_connected)
		end


	test_web_socket_good_header
		local
			msg : STRING
			address: detachable INET_ADDRESS
		do
			address := create_from_name ("localhost")
			create ws_conn.make_client_by_address_and_port (address, 9090)
			ws_conn.set_connect_timeout (1000)
					-- Connect to the Server
			ws_conn.connect
			assert ("Connected", ws_conn.is_connected)
			client_handshake.append_code (0x0D)
			client_handshake.append_code (0x0A)
			client_handshake.append (key3)
			send_message (client_handshake)
			assert("Data Received", receive_data /= Void)
		end

feature {NONE} -- implementation
	ws_conn: NETWORK_STREAM_SOCKET
	crlf: STRING is "%/13/%/10/"

	client_handshake : STRING = "[
GET /demo HTTP/1.1
Host: example.com
Connection: Upgrade
Sec-WebSocket-Key2: 12998 5 Y3 1  .P00
Sec-WebSocket-Protocol: sample
Upgrade: WebSocket
Sec-WebSocket-Key1: 4 @1  46546xW%0l 1 5
Origin: http://example.com

]"

	key3 : STRING = "^n:ds[4U"



	send_message (a_msg: STRING)
		local
			a_package : PACKET
            a_data : MANAGED_POINTER
            c_string : C_STRING
		do
			 create c_string.make (a_msg)
             create a_data.make_from_pointer (c_string.item, a_msg.count + 1)
             create a_package.make_from_managed_pointer (a_data)
             ws_conn.send (a_package, 0)
		end

	receive_data : STRING
        local
        	end_of_stream : BOOLEAN
        do

            from
                ws_conn.read_line
                Result := ""
            until
                end_of_stream
            loop
                print ("%N" +ws_conn.last_string+ "%N")
                Result.append(ws_conn.last_string)
                if ws_conn.last_string /= void and ws_conn.socket_ok  then
                	ws_conn.read_line
        		else
        			end_of_stream := True
        		end
        	end
		end

end


