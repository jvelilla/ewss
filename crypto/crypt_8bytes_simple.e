note
	description: "Simple 8 bytes block"
	project: "http://www.nenie.org/eiffel/"
	license: "http://www.opensource.org/licenses/mit-license.html"
	revision: "$Id: crypt_8bytes_simple.e,v 1.2 2002/01/01 20:43:28 farnaud Exp $"

class CRYPT_8BYTES_SIMPLE

inherit
	CRYPT_8BYTES
		rename
			shift_left as bit32_shift_left,
			shift_right as bit32_shift_right
		end

feature -- Bytes

	byte_1: INTEGER
	byte_2: INTEGER
	byte_3: INTEGER
	byte_4: INTEGER

	byte_5: INTEGER
	byte_6: INTEGER
	byte_7: INTEGER
	byte_8: INTEGER

	set_1 (b: INTEGER)
		do
			byte_1 := b
		end

	set_2 (b: INTEGER)
		do
			byte_2 := b
		end

	set_3 (b: INTEGER)
		do
			byte_3 := b
		end

	set_4 (b: INTEGER)
		do
			byte_4 := b
		end

	set_5 (b: INTEGER)
		do
			byte_5 := b
		end

	set_6 (b: INTEGER)
		do
			byte_6 := b
		end

	set_7 (b: INTEGER)
		do
			byte_7 := b
		end

	set_8 (b: INTEGER)
		do
			byte_8 := b
		end

feature -- Shift

	shift_left (b: INTEGER)
			-- Shift left.
		do
			set_1 (byte_2)
			set_2 (byte_3)
			set_3 (byte_4)
			set_4 (byte_5)
			set_5 (byte_6)
			set_6 (byte_7)
			set_7 (byte_8)

			set_8 (b)
		ensure
			last: b = byte_8
		end

	shift_right (b: INTEGER) 
			-- Shift right.
		do
			set_8 (byte_7)
			set_7 (byte_6)
			set_6 (byte_5)
			set_5 (byte_4)
			set_4 (byte_3)
			set_3 (byte_2)
			set_2 (byte_1)

			set_1 (b)
		ensure
			first: b = byte_1
		end

end
