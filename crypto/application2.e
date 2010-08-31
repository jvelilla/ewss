note
	description : "crypto application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION2

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			md5: CRYPT_MD5
		do
			create md5.make
			md5.init
			md5.update_string ("hello")
			--5d41402abc4b2a76b9719d911017c592
			--5d41402abc4b2a76b9719d911017c592
			md5.final
			io.put_string (md5.digest.hex_string)
			io.put_new_line

		end

end
