note
	description: "Summary description for {WEB_SOCKET_CONNECTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_CONNECTION
	inherit
		NETWORK_STREAM_SOCKET

create
	make_server_by_port, make_client_by_port

feature
	send_message (a_msg: STRING)
		local
			a_package : PACKET
            a_data : MANAGED_POINTER
            c_string : C_STRING
		do
			 create c_string.make (a_msg)
             create a_data.make_from_pointer (c_string.item, a_msg.count + 1)
             create a_package.make_from_managed_pointer (a_data)
             Current.send (a_package, 1)
		end
end
