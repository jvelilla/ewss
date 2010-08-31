note
	description: "Fixed size block with bytes as integers"
	project: "http://www.nenie.org/eiffel/"
	license: "http://www.opensource.org/licenses/mit-license.html"
	revision: "$Id: crypt_bytes.e,v 1.7 2003/12/21 18:56:01 farnaud Exp $"

deferred class CRYPT_BYTES

inherit
	CRYPT_HEX_PRIVATE_ROUTINES

	CRYPT_BIT32_PRIVATE_ROUTINES
		export
			{ANY} is_byte
		end

	KL_IMPORTED_STRING_ROUTINES

	KL_IMPORTED_INTEGER_ROUTINES
		export {NONE} all end

feature -- Bounds

	lower: INTEGER = 1
			-- One.

	upper: INTEGER
			-- Upper bound of block (inclusive).
		do
			Result := count
		end

	count: INTEGER
			-- Number of bytes
		deferred
		end

 feature -- Definition

	item (i: INTEGER): INTEGER
			-- Indexed byte.
		require
			lower: i >= lower
			upper: i <= upper
		deferred
		ensure
			byte: is_byte(Result)
		end

	put (a_byte: INTEGER; i: INTEGER)
			-- Put byte at index i.
		require
			lower: i >= lower
			upper: i <= upper
			byte: is_byte (a_byte)
		deferred
		ensure
			set: a_byte = item (i)
		end

feature -- Copy

	copy_bytes (a: CRYPT_BYTES)
			-- Copy bytes.
		require
			not_void: a /= Void
			size: a.count = count
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > count
			loop
				put (a.item (i), i)
				i := i + 1
			end
		ensure
			same: same_bytes (a)
		end

	same_bytes (a: CRYPT_BYTES): BOOLEAN
			-- Copy bytes.
		require
			not_void: a /= Void
		local
			i: INTEGER
		do
			Result := (a = Current)
			if (not Result) and (a.count = count) then
				from
					i := 1
					Result := True
				until
					(i > count) or (not Result)
				loop
					Result := (a.item (i) = item (i))
					i := i + 1
				end
			end
		end

	copy_bytes_at (a: CRYPT_BYTES; a_from: INTEGER)
			-- Copy bytes from within a larger block.
		require
			not_void: a /= Void
			inside_min: a_from > 0
			inside_max: a_from + count - 1 <= a.count
		local
			i: INTEGER
		do
			from
				i := 1
			variant
				count - i + 1
			until
				i > count
			loop
				put (a.item (i + a_from - 1), i)
				i := i + 1
			end
		end

feature -- Operations

	xor_bytes (a: CRYPT_BYTES)
			-- Current := Current xor a, bitwise
			-- Partial if a shorter than Current.
		require
			not_void: a /= Void
			size: a.count <= count
		local
			i: INTEGER
		do
			from
				i := a.count
			variant
				i
			until
				i = 0
			loop
				put (byte_xor (a.item (i), item (i)), i)
				i := i - 1
			end
		end

feature -- First/last

	first: INTEGER
			-- First byte.
		do
			Result := item (1)
		ensure
			def: Result = item (1)
		end

	last: INTEGER
			-- Last byte.
		do
			Result := item (count)
		ensure
			def: Result = item (count)
		end

feature -- Hexadecimal

	hex_string: STRING
			-- Finish
		local
			j: INTEGER
			a_byte: INTEGER
		do
			from
				create Result.make (0)
				j := 0
			until
				j = count
			loop
				a_byte := item (lower+j)
				Result.append_character (int_to_hex((a_byte//16)\\16))
				Result.append_character (int_to_hex((a_byte\\16)))
				j := j + 1
			end
		end

	from_hex (a: STRING)
			-- Initialise from hex.
		require
			not_void: a /= Void
			size: a.count = (count * 2)
			hex: STRING_.is_hexadecimal (a)
		local
			i, j: INTEGER
			a_byte: INTEGER
		do
			from
				i := 1
				j := 1
			until
				i > count
			loop
				a_byte := hex_to_int (a.item (j)) * 16
				j := j + 1
				a_byte := a_byte + hex_to_int (a.item (j))
				j := j + 1

				put (a_byte, i)
				i := i + 1
			end
		ensure
			reverse: --hex_string.is_equal (a.as_lower)
		end

feature -- String as byte block

	from_string (a: STRING)
			-- Initialise from string assuming 1 byte per character.
		require
			not_void: a /= Void
			size: a.count = count
			--max_char: foreach i in 1..count, a.item (i) <= 255
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > count
			loop
				put (a.item (i).code, i)
				i := i + 1
			end
		end

feature -- Array

	from_character_array (an_array: like as_character_array)
			-- Set from character array.
		require
			not_void: an_array /= Void
			count: an_array.count = count
		local
			i: INTEGER
		do
			from
				i := an_array.lower
			variant
				an_array.upper - i + 1
			until
				i > an_array.upper
			loop
				put (an_array.item (i).code, i - an_array.lower + 1)
				i := i + 1
			end
		ensure
			items: count > 0 implies item (1) = an_array.item (1).code -- same for 2..count
		end

	as_character_array: ARRAY [CHARACTER]
			-- Convert to array of characters.
		local
			i: INTEGER
		do
			create Result.make (1, count)
			from
				i := 1
			variant
				count - i + 1
			until
				i > count
			loop
				Result.put (INTEGER_.to_character (item (i)), i)
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			result_count: Result.count = count
			items: Result.count > 0 implies Result.item (1).code = item (1) -- same for 2..count
		end

feature -- Convenience

 	sub (min, max: INTEGER): CRYPT_BYTES_ARRAY 
			-- New array consisting of items at indexes
			-- in `min .. max'
		require
			min_large_enough: 1 <= min
			max_small_enough: max <= count
			valid_bounds: min <= max + 1
		local
			cnt: INTEGER
			i: INTEGER
		do
			cnt := max - min + 1
			create Result.make (cnt)
			from
				i := 1
			until
				i > cnt
			loop
				Result.put (item (i + min - 1), i)
				i := i + 1
			end
		ensure
			subarray_not_void: Result /= Void
			count_set: Result.count = max - min + 1
			limits_set: Result.count > 0 implies
					(Result.item (1) = item (min)
					and Result.item (Result.count) = item (max))
		end

end
