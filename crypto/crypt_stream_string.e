note
	description: "Collect a byte stream in a string"

class
	CRYPT_STREAM_STRING

inherit
	CRYPT_BYTE_CONSUMER
	KL_INTEGER_ROUTINES
		export
			{NONE} all
		end

feature -- Stream

	init is
			-- Create string.
		do
			create last_string.make (0)
		end

	update_byte (a: INTEGER) is
			-- Append byte to string has character.
		do
			last_string.append_character (to_character (a))
		end

	final is
			-- Do nothing.
		do
		end

feature -- Result

	last_string: STRING

end
