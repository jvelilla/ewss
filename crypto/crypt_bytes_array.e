note
	description: "Any size byte block as an inefficient array of INTEGER"

class CRYPT_BYTES_ARRAY

inherit
	CRYPT_BYTES

create
	make,
	make_from_hex,
	make_from_string

feature {NONE} -- Creation

	make (a: INTEGER)
			-- Make fixed size block.
		do
			create array.make (1,a)
		ensure
			count: count = a
		end

	make_from_hex (a: STRING)
			-- make; from_hex
		require
			not_void: a /= Void
			size: a.count \\ 2 = 0
			hex: STRING_.is_hexadecimal (a)
		do
			make (a.count // 2)
			from_hex (a)
		end

	make_from_string (a: STRING)
			-- make; from_string
		require
			not_void: a /= Void
		do
			make (a.count)
			from_string (a)
		end

feature -- Basic specifiers

	item (i: INTEGER): INTEGER
			-- Indexed byte.
		do
			Result := array.item (i)
		end

	put (a_byte: INTEGER; i: INTEGER)
			-- Put byte at index i.
		do
			array.put (a_byte, i)
		end

	count: INTEGER 
			-- Number of bytes
		do
			Result := array.count
		end

feature {NONE} -- Implementation

	array: ARRAY[INTEGER]

invariant
	not_void: array /= Void
	count: array.count = count
	lower: array.lower = 1

end
