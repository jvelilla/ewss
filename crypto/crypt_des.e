note
	description: "Data Encryption Standard (DES)"
	project: "http://www.nenie.org/eiffel/"
	license: "http://www.opensource.org/licenses/mit-license.html"
	revision: "$Id: crypt_des.e,v 1.5 2003/10/01 00:47:49 farnaud Exp $"

class CRYPT_DES

inherit
	CRYPT_BLOCK_CIPHER
		rename
			last as last_block
		end

create
	make

feature {NONE} -- Creation

	make 
			-- Initialise objects.
		do
			left := new_des_block
			right := new_des_block
			tmp := new_des_block
			tmp_convert := new_des_block

			last_block := new_des_block
			key_1 := new_des_block
			key_2 := new_des_block
			key_3 := new_des_block
			key_4 := new_des_block
			key_5 := new_des_block
			key_6 := new_des_block
			key_7 := new_des_block
			key_8 := new_des_block
			key_9 := new_des_block
			key_10 := new_des_block
			key_11 := new_des_block
			key_12 := new_des_block
			key_13 := new_des_block
			key_14 := new_des_block
			key_15 := new_des_block
			key_16 := new_des_block
		end

	new_des_block: CRYPT_DES_BLOCK
		do
			create Result
		end

feature -- CRYPT_BLOCK_CIPHER

	block_size: INTEGER = 8
			-- Block size.

	key_size: INTEGER
			-- Simple DES: 56 bits: 8-bytes, with 7 bits used in each.
		do
			Result := block_size
		end

	set_key (a: CRYPT_BYTES)
			-- Set key.
		do
			tmp_convert.copy_bytes (a)
			set_key_block (tmp_convert)
		end

	encrypt (a: CRYPT_BYTES)
			-- Encrypt.
		do
			tmp_convert.copy_bytes (a)
			encrypt_block (tmp_convert)
		end

	decrypt (a: CRYPT_BYTES)
			-- Decrypt.
		do
			tmp_convert.copy_bytes (a)
			decrypt_block (tmp_convert)
		end

feature -- Algorithm

	set_key_block (a_key: CRYPT_DES_BLOCK)
			-- Set key block.
		require
			not_void: a_key /= Void
		do
			-- make key schedule
			tmp.pc_1_permutation (a_key)

			tmp.rotate_lower_upper_28
			key_1.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28
			key_2.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28_twice
			key_3.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28_twice
			key_4.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28_twice
			key_5.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28_twice
			key_6.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28_twice
			key_7.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28_twice
			key_8.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28
			key_9.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28_twice
			key_10.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28_twice
			key_11.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28_twice
			key_12.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28_twice
			key_13.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28_twice
			key_14.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28_twice
			key_15.pc_2_permutation (tmp)

			tmp.rotate_lower_upper_28
			key_16.pc_2_permutation (tmp)
		end

	encrypt_block (a_plaintext: CRYPT_DES_BLOCK)
			-- Crypt a block.
		require
			not_void: a_plaintext /= Void
		do
			left.initial_permutation (a_plaintext)
			right.copy_upper_lower_32 (left)

			iteration (key_1)
			iteration (key_2)
			iteration (key_3)
			iteration (key_4)
			iteration (key_5)
			iteration (key_6)
			iteration (key_7)
			iteration (key_8)
			iteration (key_9)
			iteration (key_10)
			iteration (key_11)
			iteration (key_12)
			iteration (key_13)
			iteration (key_14)
			iteration (key_15)
			iteration (key_16)

			-- swap left/right
			tmp.copy_lower_32 (right)
			tmp.copy_lower_upper_32 (left)

			last_block.inverse_initial_permutation (tmp)
		end

	decrypt_block (a_cyphertext: CRYPT_DES_BLOCK)
			-- Crypt a block.
		require
			not_void: a_cyphertext /= Void
		do
			left.initial_permutation (a_cyphertext)
			right.copy_upper_lower_32 (left)

			iteration (key_16)
			iteration (key_15)
			iteration (key_14)
			iteration (key_13)
			iteration (key_12)
			iteration (key_11)
			iteration (key_10)
			iteration (key_9)
			iteration (key_8)
			iteration (key_7)
			iteration (key_6)
			iteration (key_5)
			iteration (key_4)
			iteration (key_3)
			iteration (key_2)
			iteration (key_1)

			-- swap left/right
			tmp.copy_lower_32 (right)
			tmp.copy_lower_upper_32 (left)

			last_block.inverse_initial_permutation (tmp)
		end

feature {NONE} -- Iterations

	tmp,left,right: CRYPT_DES_BLOCK

	iteration (a_key: CRYPT_DES_BLOCK)
			-- each round does
			-- (left,right) := (right,f(right, key(i)) XOR left)
		do
			tmp.copy (right)
			right.f(a_key)
			right.xor_32 (left)
			left.copy (tmp)
		end

feature {NONE} -- Interface conversions

	tmp_convert: CRYPT_DES_BLOCK

feature -- Result

	last_block: CRYPT_DES_BLOCK

feature {NONE} -- Key schedule

	key_1: CRYPT_DES_BLOCK
	key_2: CRYPT_DES_BLOCK
	key_3: CRYPT_DES_BLOCK
	key_4: CRYPT_DES_BLOCK
	key_5: CRYPT_DES_BLOCK
	key_6: CRYPT_DES_BLOCK
	key_7: CRYPT_DES_BLOCK
	key_8: CRYPT_DES_BLOCK
	key_9: CRYPT_DES_BLOCK
	key_10: CRYPT_DES_BLOCK
	key_11: CRYPT_DES_BLOCK
	key_12: CRYPT_DES_BLOCK
	key_13: CRYPT_DES_BLOCK
	key_14: CRYPT_DES_BLOCK
	key_15: CRYPT_DES_BLOCK
	key_16: CRYPT_DES_BLOCK


invariant
	last_block_not_void: last_block /= Void
	key_not_void: -- key_[1..16] /= Void

end
