note
	description: "Summary description for {WEB_SOCKET_SERVER}."
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_SERVER

create
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Initialization

	setup
		local
			l_web_socket: WEB_SOCKET_SERVER_HANDLER
		do
			print ("%N%N%N")
			print ("Starting WebSocket Server:%N")
			stop := False
			create l_web_socket.make (current, "HTTP_HANDLER")
			l_web_socket.launch
			run
		end

	shutdown_server
		do
			stop := True
		end

feature -- Access

	stop: BOOLEAN
			-- Stops the server

feature {NONE} -- implementation

	run
			-- Start the server
		local
			l_thread: EXECUTION_ENVIRONMENT
		do
			create l_thread
			from
			until
				stop
			loop
				l_thread.sleep (1000000)
			end
		end

end
