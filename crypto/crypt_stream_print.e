note
	description: "Print byte stream"
	project: "http://www.nenie.org/eiffel/"
	license: "http://www.opensource.org/licenses/mit-license.html"
	revision: "$Id: crypt_stream_print.e,v 1.2 2003/10/01 00:47:49 farnaud Exp $"

class CRYPT_STREAM_PRINT

inherit
	CRYPT_BYTE_CONSUMER

	CRYPT_HEX_PRIVATE_ROUTINES

	KL_INTEGER_ROUTINES
		export
			{NONE} all
		end

feature -- Basic specifiers

	init
			-- Reset processing.
		do
			position := 1
			create last_ascii.make (0)
		end

	update_byte (a_byte: INTEGER)
			-- Add one byte to stream.
		do
			if position /= 0 then
				--io.put_string (":")
			end
			io.put_character (int_to_hex (a_byte // 16))
			io.put_character (int_to_hex (a_byte \\ 16))

			if a_byte <= Ascii_max and a_byte > Ascii_min then
				last_ascii.append_character (to_character (a_byte))
			else
				last_ascii.append_character ('.')
			end

			if position > Max_position then
				print_tail
				init
			end

			position := position + 1
		end

	final
			-- Terminate processing.
		do
			if position /= 1 then
				print_tail
			end
		end

feature {NONE} -- Impl

	print_tail
			-- Print tail with ascii representation.
		do
			from until position > Max_position loop
				io.put_character (' ')
			end
			io.put_character (' ')
			io.put_string (last_ascii)
			io.put_new_line
		end

feature {NONE} -- State

	position: INTEGER
		-- Number

	last_ascii: STRING
		-- Ascii representation of byte.s

	Max_position: INTEGER = 24
		-- Bytes per line (takes 3*Result + 1 chars)

	Ascii_min: INTEGER = 32
	Ascii_max: INTEGER = 127

end
