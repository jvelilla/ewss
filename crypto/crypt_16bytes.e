note
	description: "8 bytes block"

deferred class CRYPT_16BYTES

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

	byte_9: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_10: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_11: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_12: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_13: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_14: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_15: INTEGER
			-- Byte.
		deferred
		ensure
			byte: is_byte(Result)
		end

	byte_16: INTEGER
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

	set_9 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_9 = b
		end

	set_10 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_10 = b
		end

	set_11 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_11 = b
		end

	set_12(b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_12 = b
		end

	set_13 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_13 = b
		end

	set_14 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_14 = b
		end

	set_15 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_15 = b
		end

	set_16 (b: INTEGER)
			-- Set byte.
		require
			byte: is_byte (b)
		deferred
		ensure
			set: byte_16 = b
		end

feature -- Input

	set (b1, b2, b3, b4, b5, b6, b7, b8,
		b9, b10, b11, b12, b13, b14, b15, b16: INTEGER)
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
			is9: is_byte (b9)
			is10: is_byte (b10)
			is11: is_byte (b11)
			is12: is_byte (b12)
			is13: is_byte (b13)
			is14: is_byte (b14)
			is15: is_byte (b15)
			is16: is_byte (b16)
		do
			set_1 (b1)
			set_2 (b2)
			set_3 (b3)
			set_4 (b4)
			set_5 (b5)
			set_6 (b6)
			set_7 (b7)
			set_8 (b8)
			set_9 (b9)
			set_10 (b10)
			set_11 (b11)
			set_12 (b12)
			set_13 (b13)
			set_14 (b14)
			set_15 (b15)
			set_16 (b16)
		ensure
			b1: b1 = byte_1
			b2: b2 = byte_2
			b3: b3 = byte_3
			b4: b4 = byte_4
			b5: b5 = byte_5
			b6: b6 = byte_6
			b7: b7 = byte_7
			b8: b8 = byte_8
			b9: b9 = byte_9
			b10: b10 = byte_10
			b11: b11 = byte_11
			b12: b12 = byte_12
			b13: b13 = byte_13
			b14: b14 = byte_14
			b15: b15 = byte_15
			b16: b16 = byte_16
		end

feature -- Indexed

	count: INTEGER = 16

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
			when 9 then Result := byte_9
			when 10 then Result := byte_10
			when 11 then Result := byte_11
			when 12 then Result := byte_12
			when 13 then Result := byte_13
			when 14 then Result := byte_14
			when 15 then Result := byte_15
			when 16 then Result := byte_16
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
			when 9 then set_9 (a_byte)
			when 10 then set_10 (a_byte)
			when 11 then set_11 (a_byte)
			when 12 then set_12 (a_byte)
			when 13 then set_13 (a_byte)
			when 14 then set_14 (a_byte)
			when 15 then set_15 (a_byte)
			when 16 then set_16 (a_byte)
			end
		end

end
