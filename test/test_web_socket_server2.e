note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_WEB_SOCKET_SERVER2

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

	test_connection
			-- New test routine
		do
			create client_socket.make_client_by_port (9090, "localhost")
			client_socket.set_connect_timeout (1000)
					-- Connect to the Server
			client_socket.connect
			if not client_socket.is_connected then
					io.put_string ("Unable to connect to localhost:9090 " )
					io.put_new_line
			else
					send_message_and_receive_reply (client_socket, "Hello")
					send_message_and_receive_reply (client_socket, "This")
					send_message_and_receive_reply (client_socket, "is")
					send_message_and_receive_reply (client_socket, "a")
					send_message_and_receive_reply (client_socket, "test")
					client_socket.close
			end
		end

	test_get_url
		local
			msg : STRING
			address: detachable INET_ADDRESS
		do
			address := create_from_name ("www.google.com")
			create client_socket.make_client_by_address_and_port (address, 80)
			client_socket.set_connect_timeout (1000)
					-- Connect to the Server
			client_socket.connect
			if not client_socket.is_connected then
					io.put_string ("Unable to connect to www.google.com:80" )
					io.put_new_line
			else
				send_message (client_socket, "GET / HTTP/1.0%/13/%/10/%/13/%/10/")
				msg := receive_data (client_socket)
			end
		end

	test_head_url
		local
			msg : STRING
			address: detachable INET_ADDRESS
		do
			address := create_from_name ("www.google.com.ar")
			create client_socket.make_client_by_address_and_port (address, 80)
			client_socket.set_connect_timeout (1000)
					-- Connect to the Server
			client_socket.connect
			if not client_socket.is_connected then
					io.put_string ("Unable to connect to www.google.com:80" )
					io.put_new_line
			else
				send_message (client_socket, "HEAD / HTTP/1.0%/13/%/10/%/13/%/10/")
				msg := receive_data (client_socket)
			end
		end


	test_web_socket_connection
		local
			msg : STRING
			address: detachable INET_ADDRESS
		do
			address := create_from_name ("localhost")
			create client_socket.make_client_by_address_and_port (address, 9090)
			client_socket.set_connect_timeout (1000)
					-- Connect to the Server
			client_socket.connect
			if not client_socket.is_connected then
					io.put_string ("Unable to connect to localchost:9090" )
					io.put_new_line
			else
				send_message (client_socket, "GET / HTTP/1.1%/13/%/10/%/13/%/10/")
				msg := receive_data (client_socket)
			end
		end

feature -- Implementation
	client_socket: NETWORK_STREAM_SOCKET
	crlf: STRING is "%/13/%/10/"

	feature {NONE} --Implementation

	send_message_and_receive_reply (a_socket: SOCKET; message: STRING)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_read and then a_socket.is_open_write
			valid_message: message /= Void and then not message.is_empty
		do
			send_message (a_socket, message)
			receive_reply (a_socket)
		end

	send_message (a_socket: SOCKET; message: STRING)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_write
			valid_message: message /= Void and then not message.is_empty
		do
			a_socket.put_string (message + "%/13/%/10/%/13/%/10/")
		end

	send_message2 (a_socket: SOCKET; message: STRING)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_read
			valid_message: message /= Void and then not message.is_empty
		do
			a_socket.put_string (message + "%N")
		end

	receive_reply (a_socket: SOCKET)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_read
		local
			l_last_string: detachable STRING
		do
			a_socket.read_line
			l_last_string := a_socket.last_string
			check l_last_string_attached: l_last_string /= Void end
			io.put_string ("Server Says: ")
			io.put_string (l_last_string)
			io.put_new_line
		end

	receive_data (socket: SOCKET) : STRING
        require
            socket: socket /= Void and then not socket.is_closed
        local
        	end_of_stream : BOOLEAN
        do

            from
                socket.read_line
                Result := ""
            until
                end_of_stream
            loop
                print ("%N" +socket.last_string+ "%N")
                Result.append(socket.last_string)
                if socket.last_string /= void and socket.socket_ok  then
                	socket.read_line
        		else
        			end_of_stream := True
        		end
        	end
		end
end


