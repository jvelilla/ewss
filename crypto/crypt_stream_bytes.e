note
	description: "Put result of byte stream into CRYPT_BYTES"

class CRYPT_STREAM_BYTES

inherit
	CRYPT_BYTE_CONSUMER

feature -- Stream

	init
			-- Reset temporary storage.
		do
			create bytes.make_default
		end

	update_byte (a: INTEGER)
			-- Add byte to temporary storage.
		do
			bytes.force_last (a)
		end

	final 
			-- Prepare bytes array.
		local
			i: INTEGER
		do
			create last_bytes.make (bytes.count)
			from
				i := 1
			until
				i > bytes.count
			loop
				last_bytes.put (bytes.item (i), i)
				i := i + 1
			end

			-- clear temp storage
			bytes := Void
		end

feature {NONE}

	bytes: DS_ARRAYED_LIST[INTEGER]
			-- Not very space efficient storage for bytes.

feature -- Result

	last_bytes: CRYPT_BYTES_ARRAY

end
