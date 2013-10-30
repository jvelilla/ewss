note
	description: "Summary description for {SHARED_WEB_SOCKET_EVENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_WEB_SOCKET_EVENT

inherit

	SHARED_WEB_SOCKET_CONFIGURATION

feature

	event: WEB_SOCKET_EVENT
		once
			Result := ws_config.event
		end

end
