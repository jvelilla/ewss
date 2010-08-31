note
	description: "Summary description for {TCP_STREAM_SOCKET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TCP_STREAM_SOCKET
	inherit
		NETWORK_STREAM_SOCKET

create
	make_server_by_port

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
