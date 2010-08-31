note
	description: "Summary description for {WEB_SOCKET_CONFIGURATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_CONFIGURATION

create
	make
feature -- Initialization
	make
		do
		end


feature -- Event Handler
	event : ECHO_WEB_SOCKET_EVENT
        do
        	create Result.make
        end

end
