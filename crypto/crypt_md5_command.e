note
	description: "Simple command line program that hashes its argument"

class CRYPT_MD5_COMMAND

inherit
	ARGUMENTS

creation
	make

feature -- Main

	make 
			-- Main.
		local
			md5: CRYPT_MD5
		do
			create md5.make
			if argument_count = 1 then
				md5.init
				md5.update_string (argument (1))
				md5.final
				io.put_string (md5.digest.hex_string)
				io.put_new_line
			else
				io.put_string ("usage: ")
				io.put_string (command_name)
				io.put_string (" value-to-hash")
				io.put_new_line
			end
		end

end
