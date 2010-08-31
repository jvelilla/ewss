note
	description: "Simple 16 bytes block"
	project: "http://www.nenie.org/eiffel/"
	license: "http://www.opensource.org/licenses/mit-license.html"
	revision: "$Id: crypt_16bytes_simple.e,v 1.1 2001/09/14 16:03:01 farnaud Exp $"

class CRYPT_16BYTES_SIMPLE

inherit
	CRYPT_16BYTES

feature -- Bytes

	byte_1: INTEGER
	byte_2: INTEGER
	byte_3: INTEGER
	byte_4: INTEGER

	byte_5: INTEGER
	byte_6: INTEGER
	byte_7: INTEGER
	byte_8: INTEGER

	byte_9: INTEGER
	byte_10: INTEGER
	byte_11: INTEGER
	byte_12: INTEGER

	byte_13: INTEGER
	byte_14: INTEGER
	byte_15: INTEGER
	byte_16: INTEGER

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

	set_9 (b: INTEGER)
		do
			byte_9 := b
		end

	set_10 (b: INTEGER)
		do
			byte_10 := b
		end

	set_11 (b: INTEGER)
		do
			byte_11 := b
		end

	set_12 (b: INTEGER)
		do
			byte_12 := b
		end

	set_13 (b: INTEGER)
		do
			byte_13 := b
		end

	set_14 (b: INTEGER)
		do
			byte_14 := b
		end

	set_15 (b: INTEGER)
		do
			byte_15 := b
		end

	set_16 (b: INTEGER)
		do
			byte_16 := b
		end
end
