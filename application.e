note
	description : "WebSocket application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		do
			make_web_socket_server
		end

	make_web_socket_server
			-- Run application.
		local
			l_server : WEB_SOCKET_SERVER
		do
			create l_server.make
			l_server.setup
		end

end
