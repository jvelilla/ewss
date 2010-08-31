note
	description: "Stream into a string, always the same string"

class CRYPT_STREAM_INTO_STRING

inherit
	CRYPT_STREAM_STRING
		redefine
			init
		end

create
	make

feature {NONE} -- Creation

	make (a: STRING) 
			-- Set string which will be written into.
			-- Subsequent uses reset that string and do not
			-- create a new one.
		do
			last_string := a
		ensure
			keep_reference: a = last_string
		end

feature -- Byte consumer

	init
			-- Clear, but do not replace, 'last_string'.
		do
			last_string.wipe_out
		end

end
