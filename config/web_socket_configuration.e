note
	description: "Web socket configuration details"
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_CONFIGURATION

feature -- Event Handler

	event: ECHO_WEB_SOCKET_EVENT
		do
			create Result.make
		end

end
