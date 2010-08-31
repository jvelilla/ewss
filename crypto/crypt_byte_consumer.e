note
	description: "Byte consumer with init/finish"
	project: "http://www.nenie.org/eiffel/"
	license: "http://www.opensource.org/licenses/mit-license.html"
	revision: "$Id: crypt_byte_consumer.e,v 1.2 2001/12/16 23:58:33 farnaud Exp $"

deferred class CRYPT_BYTE_CONSUMER

feature -- Basic specifiers

	init 
			-- Reset processing.
		deferred
		end

	update_byte (a_byte: INTEGER)
			-- Add one byte to stream.
		require
			byte_lower: a_byte >= 0
			byte_upper: a_byte <= 255
		deferred
		end

	final
			-- Terminate processing.
		deferred
		end

feature -- Convenience routines

	update_string (in_string: STRING)
			-- Call 'update_byte' for each character treated a byte.
			-- This assumes character codes fit in BYTE!
		require
			not_void: in_string /= Void
			--all_chars_above_256: in_string.item(1..in_string.count).item.code < 256
		local
			j,cnt: INTEGER
		do
			from
				j := 1
				cnt := in_string.count
			invariant
				j <= cnt implies in_string.item (j).code < 256
			until
				j > cnt
			loop
				update_byte (in_string.item (j).code)
				j := j + 1
			end
		end

	update_bytes (in_bytes: CRYPT_BYTES)
			-- Call 'update_byte' for each byte in this block.
		require
			not_void: in_bytes /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > in_bytes.count
			loop
				update_byte (in_bytes.item (i))
				i := i + 1
			end
		end

end
