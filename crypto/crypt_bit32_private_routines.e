note
	description: "32 bit routines -- may have to be ported"
	project: "http://www.nenie.org/eiffel/"
	license: "http://www.opensource.org/licenses/mit-license.html"
	revision: "$Id: crypt_bit32_private_routines.e,v 1.10 2006/08/25 00:36:40 farnaud Exp $"
	exportable: bit_or, bit_xor, bit_and, bit_not, shift_left, shift_right, add, to_crypt32

class CRYPT_BIT32_PRIVATE_ROUTINES

inherit
	CRYPT_HEX_PRIVATE_ROUTINES

feature {NONE} -- 32 bit type with mostly boolean operands

	crypt32: INTEGER
			-- Type anchor.
		do end

	bit_or (a,b: like crypt32): like crypt32
		do
			Result := a.bit_or (b)
		end

	bit_xor (a,b: like crypt32): like crypt32
		do
			Result := a.bit_xor (b)
		end

	bit_and (a,b: like crypt32): like crypt32
		do
			Result := a.bit_and (b)
		end

	bit_not (a:like crypt32): like crypt32
		do
			Result := a.bit_not
		end

	shift_left (a: like crypt32; n: INTEGER): like crypt32
		require
			positive_n: n >= 0
		do
				-- Inspect to circumvent SE 2.1 INTEGER_8 restriction
			inspect	n
			when 0 then Result := a
			when 1 then Result := a.bit_shift_left (1)
			when 2 then Result := a.bit_shift_left (2)
			when 3 then Result := a.bit_shift_left (3)
			when 4 then Result := a.bit_shift_left (4)
			when 5 then Result := a.bit_shift_left (5)
			when 6 then Result := a.bit_shift_left (6)
			when 7 then Result := a.bit_shift_left (7)
			when 8 then Result := a.bit_shift_left (8)
			when 9 then Result := a.bit_shift_left (9)
			when 10 then Result := a.bit_shift_left (10)
			when 11 then Result := a.bit_shift_left (11)
			when 12 then Result := a.bit_shift_left (12)
			when 13 then Result := a.bit_shift_left (13)
			when 14 then Result := a.bit_shift_left (14)
			when 15 then Result := a.bit_shift_left (15)
			when 16 then Result := a.bit_shift_left (16)
			when 17 then Result := a.bit_shift_left (17)
			when 18 then Result := a.bit_shift_left (18)
			when 19 then Result := a.bit_shift_left (19)
			when 20 then Result := a.bit_shift_left (20)
			when 21 then Result := a.bit_shift_left (21)
			when 22 then Result := a.bit_shift_left (22)
			when 23 then Result := a.bit_shift_left (23)
			when 24 then Result := a.bit_shift_left (24)
			when 25 then Result := a.bit_shift_left (25)
			when 26 then Result := a.bit_shift_left (26)
			when 27 then Result := a.bit_shift_left (27)
			when 28 then Result := a.bit_shift_left (28)
			when 29 then Result := a.bit_shift_left (29)
			when 30 then Result := a.bit_shift_left (30)
			when 31 then Result := a.bit_shift_left (31)
			when 32 then Result := a.bit_shift_left (32)
			else
				check no_bits_left: Result = 0 end
			end
		end

	shift_right (a: like crypt32; n: INTEGER): like crypt32
			-- Right shifted
		require
			positive_n: n >= 0
		do
			if a < 0 and n > 0 then
				-- on Smarteiffel bit_shift_right does sign extension
				-- so shift by one, clear top bit, and do remainder
				-- bits on positive result.
				Result := a.bit_shift_right (1)
				Result := Result.bit_and ((1).bit_shift_left (31).bit_not)
				if n > 1 then
					Result := shift_right (Result, n -  1)
				end
			else
				check sign_bit_clear: a >= 0 or n = 0 end
				Result := shift_positive_right (a, n)
			end
		end

	shift_positive_right (a: like crypt32; n: INTEGER): like crypt32
			-- Right shifted, 'positive' version for implementation
		require
			positive_a: a >= 0
			positive_n: n >= 0
		do
			inspect	n
			when 0 then Result := a
			when 1 then Result := a.bit_shift_right (1)
			when 2 then Result := a.bit_shift_right (2)
			when 3 then Result := a.bit_shift_right (3)
			when 4 then Result := a.bit_shift_right (4)
			when 5 then Result := a.bit_shift_right (5)
			when 6 then Result := a.bit_shift_right (6)
			when 7 then Result := a.bit_shift_right (7)
			when 8 then Result := a.bit_shift_right (8)
			when 9 then Result := a.bit_shift_right (9)
			when 10 then Result := a.bit_shift_right (10)
			when 11 then Result := a.bit_shift_right (11)
			when 12 then Result := a.bit_shift_right (12)
			when 13 then Result := a.bit_shift_right (13)
			when 14 then Result := a.bit_shift_right (14)
			when 15 then Result := a.bit_shift_right (15)
			when 16 then Result := a.bit_shift_right (16)
			when 17 then Result := a.bit_shift_right (17)
			when 18 then Result := a.bit_shift_right (18)
			when 19 then Result := a.bit_shift_right (19)
			when 20 then Result := a.bit_shift_right (20)
			when 21 then Result := a.bit_shift_right (21)
			when 22 then Result := a.bit_shift_right (22)
			when 23 then Result := a.bit_shift_right (23)
			when 24 then Result := a.bit_shift_right (24)
			when 25 then Result := a.bit_shift_right (25)
			when 26 then Result := a.bit_shift_right (26)
			when 27 then Result := a.bit_shift_right (27)
			when 28 then Result := a.bit_shift_right (28)
			when 29 then Result := a.bit_shift_right (29)
			when 30 then Result := a.bit_shift_right (30)
			when 31 then Result := a.bit_shift_right (31)
			when 32 then Result := a.bit_shift_right (32)
			else
				check no_bits_left: Result = 0 end
			end
		end

	add (a,b: like crypt32): like crypt32
			-- modulo unsigned addition.
		local
			l_low30, l_top: like crypt32
		do
			-- Split addition in low/top to avoid SmartEiffel overflow exception
				-- 001{30 times}
			l_low30 := (3).bit_shift_left (30).bit_not
				-- Low 31 bits
			Result := (a.bit_and (l_low30)) + (b.bit_and (l_low30))
				-- Top 1 bit
			l_top := (shift_right (Result, 30) + shift_right (a, 30) + shift_right (b, 30)).bit_shift_left (30)
				-- Merge top and bottom
			Result := Result.bit_and (l_low30).bit_or (l_top)
			--Result := a #+ b	
		--ensure
		--	se_implementation: Result = a #+ b
		--	ise_implementation: Result = a + b
		end

	to_crypt32 (an_int: INTEGER): like crypt32
			-- Make md5 word from integer.
		do
			Result := an_int
		end

	crypt32_byte_1 (a: like crypt32): INTEGER
			-- First byte of crypt32
		do
			Result := shift_right (shift_left (a,24), 24)
		ensure
			byte: is_byte (Result)
		end


	crypt32_byte_2 (a: like crypt32): INTEGER
			-- 2nd byte of crypt32
		do
			Result := crypt32_byte_1 (shift_right (a, 8))
		ensure
			byte: is_byte (Result)
		end

	crypt32_byte_3 (a: like crypt32): INTEGER
			-- 3rd byte of crypt32
		do
			Result := crypt32_byte_1 (shift_right (a, 16))
		ensure
			byte: is_byte (Result)
		end

	crypt32_byte_4 (a: like crypt32): INTEGER
			-- 4th byte of crypt32
		do
			Result := crypt32_byte_1 (shift_right (a, 24))
		ensure
			byte: is_byte (Result)
		end

	hex (a_str: STRING): like crypt32
			-- To make constants.
		require
			not_void: a_str /= Void
			count: a_str.count <= 32
		local
			an_index: INTEGER
		do
			from
				an_index := 1
			until
				an_index > a_str.count
			loop
				Result := shift_left (Result, 4)
				Result := bit_or (Result, to_crypt32 (hex_to_int (a_str.item (an_index))))
				an_index := an_index + 1
			end
		end

feature {NONE} -- Byte routines

	is_byte (a: INTEGER): BOOLEAN
			-- Is this a byte value?
		do
			Result := a >= 0 and a < 256
		ensure
			define: Result = (a >= 0 and a < 256)
		end

	byte_xor (a,b: INTEGER): INTEGER
			-- bit XOR two bytes.
		require
			a: is_byte (a)
			b: is_byte (b)
		do
			Result := crypt32_byte_1 (bit_xor (to_crypt32(a), to_crypt32(b)))
		ensure
			byte: is_byte (Result)
		end

	byte_or (a,b: INTEGER): INTEGER
			-- bit OR two bytes.
		require
			a: is_byte (a)
			b: is_byte (b)
		do
			Result := crypt32_byte_1 (bit_or (to_crypt32(a), to_crypt32(b)))
		ensure
			byte: is_byte (Result)
		end

	byte_and (a,b: INTEGER): INTEGER
			-- bit AND two bytes.
		require
			a: is_byte (a)
			b: is_byte (b)
		do
			Result := crypt32_byte_1 (bit_and (to_crypt32(a), to_crypt32(b)))
		ensure
			byte: is_byte (Result)
		end

	byte_not (a: INTEGER): INTEGER
			-- bit NOT a byte.
		require
			a: is_byte (a)
		do
			Result := crypt32_byte_1 (bit_not (to_crypt32(a)))
		ensure
			byte: is_byte (Result)
		end

end
