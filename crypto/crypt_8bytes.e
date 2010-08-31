note
	description: "8 bytes block"

deferred class CRYPT_8BYTES

inherit
	CRYPT_BYTES

feature -- Items

	byte_1: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_2: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_3: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_4: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_5: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_6: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_7: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_8: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	set_1 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_1 = b
		end

	set_2 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_2 = b
		end

	set_3 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_3 = b
		end

	set_4 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_4 = b
		end

	set_5 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_5 = b
		end

	set_6 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_6 = b
		end

	set_7 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_7 = b
		end

	set_8 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_8 = b
		end

feature -- Input

	set (b1, b2, b3, b4, b5, b6, b7, b8: INTEGER)
			-- Initialise from integer.
		require
			is1: is_byte (b1)
			is2: is_byte (b2)
			is3: is_byte (b3)
			is4: is_byte (b4)
			is5: is_byte (b5)
			is6: is_byte (b6)
			is7: is_byte (b7)
			is8: is_byte (b8)
		do
			set_1 (b1)
			set_2 (b2)
			set_3 (b3)
			set_4 (b4)
			set_5 (b5)
			set_6 (b6)
			set_8 (b8)
		ensure
			b1: b1 = byte_1
			b2: b2 = byte_2
			b3: b3 = byte_3
			b4: b4 = byte_4
			b5: b1 = byte_5
			b6: b2 = byte_6
			b7: b3 = byte_7
			b8: b4 = byte_8
		end

feature -- Indexed

	count: INTEGER = 8

	item (i: INTEGER): INTEGER
			-- Indexed byte.
		do
			inspect
				i
			when 1 then Result := byte_1
			when 2 then Result := byte_2
			when 3 then Result := byte_3
			when 4 then Result := byte_4
			when 5 then Result := byte_5
			when 6 then Result := byte_6
			when 7 then Result := byte_7
			when 8 then Result := byte_8
			end
		end

	put (a_byte: INTEGER; i: INTEGER) 
			-- Put byte at index.
		do
			inspect
				i
			when 1 then set_1 (a_byte)
			when 2 then set_2 (a_byte)
			when 3 then set_3 (a_byte)
			when 4 then set_4 (a_byte)
			when 5 then set_5 (a_byte)
			when 6 then set_6 (a_byte)
			when 7 then set_7 (a_byte)
			when 8 then set_8 (a_byte)
			end
		end
end
