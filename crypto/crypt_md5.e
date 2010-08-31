note
	description: "MD5 message digest -- RFC1321"
	project: "http://www.nenie.org/eiffel/"
	license: "http://www.opensource.org/licenses/mit-license.html"
	revision: "$Id: crypt_md5.e,v 1.7 2003/10/01 00:47:49 farnaud Exp $"

class CRYPT_MD5

inherit
	CRYPT_DIGEST
	CRYPT_BIT32_PRIVATE_ROUTINES

create
	make

feature {NONE} -- State

	state_0,state_1,state_2,state_3: like crypt32
			-- State of MD5.

	length_0,length_1: like crypt32
			-- bit message length.

	buffer: ARRAY[INTEGER]
			-- Array of incoming _bytes_.
	index: INTEGER
			-- Next available position in buffer.

feature -- Interface

	make, init
			-- Reset.
		do
			digest := Void

			state_0 := Md5.hex_67452301
			state_1 := Md5.hex_efcdab89
			state_2 := Md5.hex_98badcfe
			state_3 := Md5.hex_10325476
			length_0 := Md5.hex_0
			length_1 := Md5.hex_0
			create buffer.make (1,64)
			index := buffer.lower
		end

	update_byte (a_byte: INTEGER)
			-- Add one byte to MD5 stream.
		do
			buffer.put (a_byte, index)
			if index = buffer.upper then
				transform (buffer)
				index := buffer.lower
			else
				index := index + 1
			end
			length_0 := add (length_0, Md5.hex_8)
			if length_0 = Md5.hex_0 then
				-- we know we wrap through zero because
				length_1 := add (length_1, Md5.hex_1)
			end
		end

	final
			-- Pad and compute digest.
		local
			a_length_0, a_length_1: like crypt32
			a_pad_count: INTEGER
		do
			-- save count before padding
			a_length_0 := length_0
			a_length_1 := length_1

			-- how many bytes at the end of current buffer
			a_pad_count := buffer.upper - index + 1
			if a_pad_count < 8 then
				a_pad_count := a_pad_count + 56 -- wrap to next block
			else
				a_pad_count := a_pad_count - 8 -- fill this but last 8 bytes
			end

			if a_pad_count > 0 then
				update_byte (128) -- first bit.
				a_pad_count := a_pad_count - 1

				from until a_pad_count = 0 loop
					update_byte (0)
					a_pad_count := a_pad_count - 1
				end
			end

			-- last 8 bytes: count

			-- first word of length
			update_byte (crypt32_byte_1 (a_length_0))
			update_byte (crypt32_byte_2 (a_length_0))
			update_byte (crypt32_byte_3 (a_length_0))
			update_byte (crypt32_byte_4 (a_length_0))

			-- second word of length (not supported)
			update_byte (crypt32_byte_1 (a_length_1))
			update_byte (crypt32_byte_2 (a_length_1))
			update_byte (crypt32_byte_3 (a_length_1))
			update_byte (crypt32_byte_4 (a_length_1))

			digest := new_digest
		end

	digest: CRYPT_BYTES

	digest_size: INTEGER =  16

	block_size: INTEGER = 64

feature {NONE} -- digest

	new_digest: CRYPT_16BYTES
			-- Return array of bytes with digest.
		do
			create {CRYPT_16BYTES_SIMPLE} Result
			Result.put (crypt32_byte_1 (state_0),1)
			Result.put (crypt32_byte_2 (state_0),2)
			Result.put (crypt32_byte_3 (state_0),3)
			Result.put (crypt32_byte_4 (state_0),4)
			Result.put (crypt32_byte_1 (state_1),5)
			Result.put (crypt32_byte_2 (state_1),6)
			Result.put (crypt32_byte_3 (state_1),7)
			Result.put (crypt32_byte_4 (state_1),8)
			Result.put (crypt32_byte_1 (state_2),9)
			Result.put (crypt32_byte_2 (state_2),10)
			Result.put (crypt32_byte_3 (state_2),11)
			Result.put (crypt32_byte_4 (state_2),12)
			Result.put (crypt32_byte_1 (state_3),13)
			Result.put (crypt32_byte_2 (state_3),14)
			Result.put (crypt32_byte_3 (state_3),15)
			Result.put (crypt32_byte_4 (state_3),16)
		end

feature {NONE} -- MD5 primitives

	rot(x: like crypt32; n: INTEGER): like crypt32
		do
			Result := bit_or (shift_left (x, n) , shift_right (x, 32-n))
		end

	f(x, y, z: like crypt32): like crypt32
		do
			Result := bit_or (bit_and (x, y), bit_and (bit_not (x),z))
		end

	g(x, y, z: like crypt32): like crypt32
		do
			Result := bit_or (bit_and (x, z), bit_and(y, bit_not (z)))
		end

	h(x, y, z: like crypt32): like crypt32
		do
			Result := bit_xor (bit_xor (x,y),z)
		end

	i(x, y, z: like crypt32): like crypt32
		do
			Result := bit_xor (y, bit_or (x, bit_not (z)))
		end


feature {NONE} -- MD5 functions

	ff(a, b, c, d, x: like crypt32; s: INTEGER; ac: like crypt32): like crypt32
		do
			Result := add (a, f(b, c, d))
			Result := add (Result, x)
			Result := add (Result, ac)
			Result := rot (Result, s)
			Result := add (Result, b)
		end

	gg(a, b, c, d, x: like crypt32; s: INTEGER; ac: like crypt32): like crypt32
		do
			Result := add (a, g(b, c, d))
			Result := add (Result, x)
			Result := add (Result, ac)
			Result := rot (Result, s)
			Result := add (Result, b)
		end

	hh (a, b, c, d, x: like crypt32; s: INTEGER; ac: like crypt32): like crypt32
		do
			Result := add (a, h(b, c, d))
			Result := add (Result, x)
			Result := add (Result, ac)
			Result := rot (Result, s)
			Result := add (Result, b)
		end

	ii (a, b, c, d, x: like crypt32; s: INTEGER; ac: like crypt32): like crypt32
		do
			Result := add (a, i(b, c, d))
			Result := add (Result, x)
			Result := add (Result, ac)
			Result := rot (Result, s)
			Result := add (Result, b)
		end

	encode_word (in_block: ARRAY[INTEGER]; in_index: INTEGER): like crypt32
			-- Encode 4 bytes.
		require
			not_void: in_block /= Void
			size: in_index + 3 <= in_block.upper
		do
			Result := to_crypt32 (in_block.item (in_index))
			Result := bit_or (Result, shift_left (to_crypt32 (in_block.item (in_index+1)), 8))
			Result := bit_or (Result, shift_left (to_crypt32 (in_block.item (in_index+2)), 16))
			Result := bit_or (Result, shift_left (to_crypt32 (in_block.item (in_index+3)), 24))
		end

	transform(in_block: ARRAY[INTEGER])
			-- Transform State according to first 64 incoming bytes.
		require
			not_void: in_block /= Void
			size: in_block.count = 64
		local
			-- avoid arrays of like crypt32 for portability
			a, b, c, d: like crypt32
			block_0, block_1, block_2, block_3,
			block_4, block_5, block_6, block_7,
			block_8, block_9, block_10, block_11,
			block_12, block_13, block_14, block_15: like crypt32
			an_index: INTEGER
		do
			-- encode
			an_index := in_block.lower
			block_0 := encode_word (in_block, an_index)	an_index := an_index + 4
			block_1 := encode_word (in_block, an_index)	an_index := an_index + 4
			block_2 := encode_word (in_block, an_index) an_index := an_index + 4
			block_3 := encode_word (in_block, an_index) an_index := an_index + 4
			block_4 := encode_word (in_block, an_index) an_index := an_index + 4
			block_5 := encode_word (in_block, an_index) an_index := an_index + 4
			block_6 := encode_word (in_block, an_index) an_index := an_index + 4
			block_7 := encode_word (in_block, an_index) an_index := an_index + 4
			block_8 := encode_word (in_block, an_index) an_index := an_index + 4
			block_9 := encode_word (in_block, an_index) an_index := an_index + 4
			block_10 := encode_word (in_block, an_index) an_index := an_index + 4
			block_11 := encode_word (in_block, an_index) an_index := an_index + 4
			block_12 := encode_word (in_block, an_index) an_index := an_index + 4
			block_13 := encode_word (in_block, an_index) an_index := an_index + 4
			block_14 := encode_word (in_block, an_index) an_index := an_index + 4
			block_15 := encode_word (in_block, an_index)

			-- transform
			a := state_0
			b := state_1
			c := state_2
			d := state_3
			a := ff (a, b, c, d, block_0 ,  7, Md5.hex_d76aa478)
			d := ff (d, a, b, c, block_1 , 12, Md5.hex_e8c7b756)
			c := ff (c, d, a, b, block_2 , 17, Md5.hex_242070db)
			b := ff (b, c, d, a, block_3 , 22, Md5.hex_c1bdceee)
			a := ff (a, b, c, d, block_4 ,  7, Md5.hex_f57c0faf)
			d := ff (d, a, b, c, block_5 , 12, Md5.hex_4787c62a)
			c := ff (c, d, a, b, block_6 , 17, Md5.hex_a8304613)
			b := ff (b, c, d, a, block_7 , 22, Md5.hex_fd469501)
			a := ff (a, b, c, d, block_8 ,  7, Md5.hex_698098d8)
			d := ff (d, a, b, c, block_9 , 12, Md5.hex_8b44f7af)
			c := ff (c, d, a, b, block_10, 17, Md5.hex_ffff5bb1)
			b := ff (b, c, d, a, block_11, 22, Md5.hex_895cd7be)
			a := ff (a, b, c, d, block_12,  7, Md5.hex_6b901122)
			d := ff (d, a, b, c, block_13, 12, Md5.hex_fd987193)
			c := ff (c, d, a, b, block_14, 17, Md5.hex_a679438e)
			b := ff (b, c, d, a, block_15, 22, Md5.hex_49b40821)
			a := gg (a, b, c, d, block_1 ,  5, Md5.hex_f61e2562)
			d := gg (d, a, b, c, block_6 ,  9, Md5.hex_c040b340)
			c := gg (c, d, a, b, block_11, 14, Md5.hex_265e5a51)
			b := gg (b, c, d, a, block_0 , 20, Md5.hex_e9b6c7aa)
			a := gg (a, b, c, d, block_5 ,  5, Md5.hex_d62f105d)
			d := gg (d, a, b, c, block_10,  9, Md5.hex_2441453)
			c := gg (c, d, a, b, block_15, 14, Md5.hex_d8a1e681)
			b := gg (b, c, d, a, block_4 , 20, Md5.hex_e7d3fbc8)
			a := gg (a, b, c, d, block_9 ,  5, Md5.hex_21e1cde6)
			d := gg (d, a, b, c, block_14,  9, Md5.hex_c33707d6)
			c := gg (c, d, a, b, block_3 , 14, Md5.hex_f4d50d87)
			b := gg (b, c, d, a, block_8 , 20, Md5.hex_455a14ed)
			a := gg (a, b, c, d, block_13,  5, Md5.hex_a9e3e905)
			d := gg (d, a, b, c, block_2 ,  9, Md5.hex_fcefa3f8)
			c := gg (c, d, a, b, block_7 , 14, Md5.hex_676f02d9)
			b := gg (b, c, d, a, block_12, 20, Md5.hex_8d2a4c8a)
			a := hh (a, b, c, d, block_5 ,  4, Md5.hex_fffa3942)
			d := hh (d, a, b, c, block_8 , 11, Md5.hex_8771f681)
			c := hh (c, d, a, b, block_11, 16, Md5.hex_6d9d6122)
			b := hh (b, c, d, a, block_14, 23, Md5.hex_fde5380c)
			a := hh (a, b, c, d, block_1 ,  4, Md5.hex_a4beea44)
			d := hh (d, a, b, c, block_4 , 11, Md5.hex_4bdecfa9)
			c := hh (c, d, a, b, block_7 , 16, Md5.hex_f6bb4b60)
			b := hh (b, c, d, a, block_10, 23, Md5.hex_bebfbc70)
			a := hh (a, b, c, d, block_13,  4, Md5.hex_289b7ec6)
			d := hh (d, a, b, c, block_0 , 11, Md5.hex_eaa127fa)
			c := hh (c, d, a, b, block_3 , 16, Md5.hex_d4ef3085)
			b := hh (b, c, d, a, block_6 , 23, Md5.hex_4881d05)
			a := hh (a, b, c, d, block_9 ,  4, Md5.hex_d9d4d039)
			d := hh (d, a, b, c, block_12, 11, Md5.hex_e6db99e5)
			c := hh (c, d, a, b, block_15, 16, Md5.hex_1fa27cf8)
			b := hh (b, c, d, a, block_2 , 23, Md5.hex_c4ac5665)
			a := ii (a, b, c, d, block_0 ,  6, Md5.hex_f4292244)
			d := ii (d, a, b, c, block_7 , 10, Md5.hex_432aff97)
			c := ii (c, d, a, b, block_14, 15, Md5.hex_ab9423a7)
			b := ii (b, c, d, a, block_5 , 21, Md5.hex_fc93a039)
			a := ii (a, b, c, d, block_12,  6, Md5.hex_655b59c3)
			d := ii (d, a, b, c, block_3 , 10, Md5.hex_8f0ccc92)
			c := ii (c, d, a, b, block_10, 15, Md5.hex_ffeff47d)
			b := ii (b, c, d, a, block_1 , 21, Md5.hex_85845dd1)
			a := ii (a, b, c, d, block_8 ,  6, Md5.hex_6fa87e4f)
			d := ii (d, a, b, c, block_15, 10, Md5.hex_fe2ce6e0)
			c := ii (c, d, a, b, block_6 , 15, Md5.hex_a3014314)
			b := ii (b, c, d, a, block_13, 21, Md5.hex_4e0811a1)
			a := ii (a, b, c, d, block_4 ,  6, Md5.hex_f7537e82)
			d := ii (d, a, b, c, block_11, 10, Md5.hex_bd3af235)
			c := ii (c, d, a, b, block_2 , 15, Md5.hex_2ad7d2bb)
			b := ii (b, c, d, a, block_9 , 21, Md5.hex_eb86d391)

			state_0 := add (state_0, a)
			state_1 := add (state_1, b)
			state_2 := add (state_2, c)
			state_3 := add (state_3, d)
		end

feature {NONE} -- constants

	Md5: CRYPT_MD5_CONSTANTS
			-- Constants. They are in a separate class because
			--   const: like crypt32 is once hex ("1234abcd")
			-- is impossible (no anchors in once) and we don't want to
			-- expose the real type.
		once
			create Result.make
		end

invariant
	buffer: buffer /= Void
	buffer_size: buffer.count = 64
	index_range: index >= buffer.lower and index <= buffer.upper

end
