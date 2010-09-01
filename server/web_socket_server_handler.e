note
	description: "Summary description for {WEB_SOCKET_SERVER_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_SERVER_HANDLER
inherit
	WEB_SOCKET_CONSTANTS
	THREAD
create
	make

feature {NONE} -- Initialization

	make (a_main_server: like main_server; a_name: STRING)
			--
			-- `a_main_server': The main server object
			-- `a_name': The name of this module
		require
			a_main_server_attached: a_main_server /= Void
			a_name_attached: a_name /= Void
		do
			main_server := a_main_server
	        is_stop_requested := False
	     ensure
           main_server_set: a_main_server ~ main_server
   	end

feature -- Inherited Features

	execute
			-- Creates a socket and connects to the http server.
		local
			l_http_socket: detachable WEB_SOCKET_CONNECTION
			l_request : WEB_SOCKET_REQUEST_PROCESSOR
		do
			is_stop_requested := False

			create l_http_socket.make_server_by_port ({HTTP_CONSTANTS}.Http_server_port)
			l_http_socket.set_reuse_address
			if not l_http_socket.is_bound then
				print ("%NSocket could not be bound on port " + {HTTP_CONSTANTS}.Http_server_port.out )
			else
				from
	               l_http_socket.listen ({HTTP_CONSTANTS}.Max_tcp_clients)
	               print ("%NWebSocket Connection Server ready on port " + {HTTP_CONSTANTS}.Http_server_port.out +"%N")

	            until
	            	is_stop_requested
	            loop
	                l_http_socket.accept
	                if not is_stop_requested then
			            if attached l_http_socket.accepted as l_thread_http_socket then
							create l_request.make (l_thread_http_socket)
							l_request.launch
						end
					end
	            end
	            l_http_socket.cleanup
	        	check
	        		socket_is_closed: l_http_socket.is_closed
	       		end
       		end
       		print ("WebSocket Connection Server ends.")
       	rescue
       		print ("WebSocket Server shutdown due to exception. Please restart manually.")

			if attached l_http_socket as ll_http_socket then
				ll_http_socket.cleanup
				check
	        		socket_is_closed: ll_http_socket.is_closed
	       		end
			end
			is_stop_requested := True
	    	retry
       	end

feature -- Access
	main_server : WEB_SOCKET_SERVER

	is_stop_requested : BOOLEAN
invariant
	main_server_attached: main_server /= Void
end


