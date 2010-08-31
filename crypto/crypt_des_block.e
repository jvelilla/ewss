note
	description: "Basic 64-bit block with DES block operations"
	project: "http://www.nenie.org/eiffel/"
	license: "http://www.opensource.org/licenses/mit-license.html"
	revision: "$Id: crypt_des_block.e,v 1.4 2003/10/01 00:47:49 farnaud Exp $"
	--
	-- This class is not expanded to avoid portability problems.
	-- A single class is used for 32, 48, 56 and 64 bit operations:
	-- upper bits are untouched for 32, 48 and 56 bits operations.
	-- As the class is not expanded, all operations are in-place
	-- (there are no object creations, parameters are not changed).
	--
	-- A possibly cleaner design would have 4 expanded and immutable
	-- classes for all the sizes. Generic operations could be factored
	-- out.
	--
	-- The use of booleans for bits allows code to be closer to the
	-- the spec than manipulating integers directly. DES is not
	-- really optimised for 32 bits generic register machines,
	-- indeed it may be optimised to be slower on these. This
	-- implementation may be better for permutations but is worse
	-- for XOR and shifts. Space is no issue as DES only needs a
	-- few of these blocks.
	--
	-- equal, is_copy are valid with default semantics
	-- (all attributes are boolean)
	--
	-- The loop unwinding for regular bit operations is probably
	-- very naive and could have been left to the compiler.
	--

class CRYPT_DES_BLOCK

inherit
	CRYPT_8BYTES

feature -- Copy

	copy_lower_32 (other: like Current) is
			-- Copy lower 32 bits of other.
		require
			not_void: other /= Void
		do
			bit_1 := other.bit_1
			bit_2 := other.bit_2
			bit_3 := other.bit_3
			bit_4 := other.bit_4
			bit_5 := other.bit_5
			bit_6 := other.bit_6
			bit_7 := other.bit_7
			bit_8 := other.bit_8
			bit_9 := other.bit_9
			bit_10 := other.bit_10
			bit_11 := other.bit_11
			bit_12 := other.bit_12
			bit_13 := other.bit_13
			bit_14 := other.bit_14
			bit_15 := other.bit_15
			bit_16 := other.bit_16
			bit_17 := other.bit_17
			bit_18 := other.bit_18
			bit_19 := other.bit_19
			bit_20 := other.bit_20
			bit_21 := other.bit_21
			bit_22 := other.bit_22
			bit_23 := other.bit_23
			bit_24 := other.bit_24
			bit_25 := other.bit_25
			bit_26 := other.bit_26
			bit_27 := other.bit_27
			bit_28 := other.bit_28
			bit_29 := other.bit_29
			bit_30 := other.bit_30
			bit_31 := other.bit_31
			bit_32 := other.bit_32
		end

	copy_lower_upper_32 (other: like Current)
			 -- Copy lower 32 bits of other onto upper of Current.
		require
			not_void: other /= Void
		do
			bit_33 := other.bit_1
			bit_34 := other.bit_2
			bit_35 := other.bit_3
			bit_36 := other.bit_4
			bit_37 := other.bit_5
			bit_38 := other.bit_6
			bit_39 := other.bit_7
			bit_40 := other.bit_8
			bit_41 := other.bit_9
			bit_42 := other.bit_10
			bit_43 := other.bit_11
			bit_44 := other.bit_12
			bit_45 := other.bit_13
			bit_46 := other.bit_14
			bit_47 := other.bit_15
			bit_48 := other.bit_16
			bit_49 := other.bit_17
			bit_50 := other.bit_18
			bit_51 := other.bit_19
			bit_52 := other.bit_20
			bit_53 := other.bit_21
			bit_54 := other.bit_22
			bit_55 := other.bit_23
			bit_56 := other.bit_24
			bit_57 := other.bit_25
			bit_58 := other.bit_26
			bit_59 := other.bit_27
			bit_60 := other.bit_28
			bit_61 := other.bit_29
			bit_62 := other.bit_30
			bit_63 := other.bit_31
			bit_64 := other.bit_32
		end

	copy_upper_lower_32 (other: like Current)
			 -- Copy upper 32 bits of other onto lower of Current.
		require
			not_void: other /= Void
		do
			bit_1 := other.bit_33
			bit_2 := other.bit_34
			bit_3 := other.bit_35
			bit_4 := other.bit_36
			bit_5 := other.bit_37
			bit_6 := other.bit_38
			bit_7 := other.bit_39
			bit_8 := other.bit_40
			bit_9 := other.bit_41
			bit_10 := other.bit_42
			bit_11 := other.bit_43
			bit_12 := other.bit_44
			bit_13 := other.bit_45
			bit_14 := other.bit_46
			bit_15 := other.bit_47
			bit_16 := other.bit_48
			bit_17 := other.bit_49
			bit_18 := other.bit_50
			bit_19 := other.bit_51
			bit_20 := other.bit_52
			bit_21 := other.bit_53
			bit_22 := other.bit_54
			bit_23 := other.bit_55
			bit_24 := other.bit_56
			bit_25 := other.bit_57
			bit_26 := other.bit_58
			bit_27 := other.bit_59
			bit_28 := other.bit_60
			bit_29 := other.bit_61
			bit_30 := other.bit_62
			bit_31 := other.bit_63
			bit_32 := other.bit_64
		end

feature -- Key schedule: shifts

	rotate_lower_28
			-- rotate left bits 1-28
		local
			saved: BOOLEAN
		do
			saved := bit_1

			bit_1 := bit_2
			bit_2 := bit_3
			bit_3 := bit_4
			bit_4 := bit_5
			bit_5 := bit_6
			bit_6 := bit_7
			bit_7 := bit_8
			bit_8 := bit_9
			bit_9 := bit_10
			bit_10 := bit_11
			bit_11 := bit_12
			bit_12 := bit_13
			bit_13 := bit_14
			bit_14 := bit_15
			bit_15 := bit_16
			bit_16 := bit_17
			bit_17 := bit_18
			bit_18 := bit_19
			bit_19 := bit_20
			bit_20 := bit_21
			bit_21 := bit_22
			bit_22 := bit_23
			bit_23 := bit_24
			bit_24 := bit_25
			bit_25 := bit_26
			bit_26 := bit_27
			bit_27 := bit_28
			bit_28 := saved
		end

	rotate_upper_28
			-- rotate left bits 29-56
		local
			saved: BOOLEAN
		do
			saved := bit_29

			bit_29 := bit_30
			bit_30 := bit_31
			bit_31 := bit_32
			bit_32 := bit_33
			bit_33 := bit_34
			bit_34 := bit_35
			bit_35 := bit_36
			bit_36 := bit_37
			bit_37 := bit_38
			bit_38 := bit_39
			bit_39 := bit_40
			bit_40 := bit_41
			bit_41 := bit_42
			bit_42 := bit_43
			bit_43 := bit_44
			bit_44 := bit_45
			bit_45 := bit_46
			bit_46 := bit_47
			bit_47 := bit_48
			bit_48 := bit_49
			bit_49 := bit_50
			bit_50 := bit_51
			bit_51 := bit_52
			bit_52 := bit_53
			bit_53 := bit_54
			bit_54 := bit_55
			bit_55 := bit_56
			bit_56 := saved
		end

	rotate_lower_upper_28
			-- rotate_lower_28; rotate_upper_28
		do
			rotate_lower_28
			rotate_upper_28
		end

	rotate_lower_upper_28_twice
			-- do 'rotate_lower_upper_28' twice.
		do
			rotate_lower_upper_28
			rotate_lower_upper_28
		end

feature -- Key schedule: permutation

	pc_1_permutation (other: like Current)
			-- Get bits from 64 bits keys into 56 bits, and shuffle.
			-- (bit 8, 16, etc are ignored)
		require
			not_void: other /= Void
			shuffling: other /= Current
		do
			-- Generated from FIPS standard
			bit_1 := other.bit_57
			bit_2 := other.bit_49
			bit_3 := other.bit_41
			bit_4 := other.bit_33
			bit_5 := other.bit_25
			bit_6 := other.bit_17
			bit_7 := other.bit_9
			bit_8 := other.bit_1
			bit_9 := other.bit_58
			bit_10 := other.bit_50
			bit_11 := other.bit_42
			bit_12 := other.bit_34
			bit_13 := other.bit_26
			bit_14 := other.bit_18
			bit_15 := other.bit_10
			bit_16 := other.bit_2
			bit_17 := other.bit_59
			bit_18 := other.bit_51
			bit_19 := other.bit_43
			bit_20 := other.bit_35
			bit_21 := other.bit_27
			bit_22 := other.bit_19
			bit_23 := other.bit_11
			bit_24 := other.bit_3
			bit_25 := other.bit_60
			bit_26 := other.bit_52
			bit_27 := other.bit_44
			bit_28 := other.bit_36

			bit_29 := other.bit_63
			bit_30 := other.bit_55
			bit_31 := other.bit_47
			bit_32 := other.bit_39
			bit_33 := other.bit_31
			bit_34 := other.bit_23
			bit_35 := other.bit_15
			bit_36 := other.bit_7
			bit_37 := other.bit_62
			bit_38 := other.bit_54
			bit_39 := other.bit_46
			bit_40 := other.bit_38
			bit_41 := other.bit_30
			bit_42 := other.bit_22
			bit_43 := other.bit_14
			bit_44 := other.bit_6
			bit_45 := other.bit_61
			bit_46 := other.bit_53
			bit_47 := other.bit_45
			bit_48 := other.bit_37
			bit_49 := other.bit_29
			bit_50 := other.bit_21
			bit_51 := other.bit_13
			bit_52 := other.bit_5
			bit_53 := other.bit_28
			bit_54 := other.bit_20
			bit_55 := other.bit_12
			bit_56 := other.bit_4
		end

	pc_2_permutation (other: like Current)
			-- Get 56 bits into 48. PC2 permutation.
		require
			not_void: other /= Void
			shuffling: other /= Current
		do
			-- Generated from FIPS standard
			bit_1 := other.bit_14
			bit_2 := other.bit_17
			bit_3 := other.bit_11
			bit_4 := other.bit_24
			bit_5 := other.bit_1
			bit_6 := other.bit_5
			bit_7 := other.bit_3
			bit_8 := other.bit_28
			bit_9 := other.bit_15
			bit_10 := other.bit_6
			bit_11 := other.bit_21
			bit_12 := other.bit_10
			bit_13 := other.bit_23
			bit_14 := other.bit_19
			bit_15 := other.bit_12
			bit_16 := other.bit_4
			bit_17 := other.bit_26
			bit_18 := other.bit_8
			bit_19 := other.bit_16
			bit_20 := other.bit_7
			bit_21 := other.bit_27
			bit_22 := other.bit_20
			bit_23 := other.bit_13
			bit_24 := other.bit_2
			bit_25 := other.bit_41
			bit_26 := other.bit_52
			bit_27 := other.bit_31
			bit_28 := other.bit_37
			bit_29 := other.bit_47
			bit_30 := other.bit_55
			bit_31 := other.bit_30
			bit_32 := other.bit_40
			bit_33 := other.bit_51
			bit_34 := other.bit_45
			bit_35 := other.bit_33
			bit_36 := other.bit_48
			bit_37 := other.bit_44
			bit_38 := other.bit_49
			bit_39 := other.bit_39
			bit_40 := other.bit_56
			bit_41 := other.bit_34
			bit_42 := other.bit_53
			bit_43 := other.bit_46
			bit_44 := other.bit_42
			bit_45 := other.bit_50
			bit_46 := other.bit_36
			bit_47 := other.bit_29
			bit_48 := other.bit_32
		end

feature -- Xor

	xor_32 (other: like Current)
			-- Current := Current xor other
			-- (applied to lowest 32 bits)
		require
			not_void: other /= Void
		do
			bit_1 := bit_1 xor other.bit_1
			bit_2 := bit_2 xor other.bit_2
			bit_3 := bit_3 xor other.bit_3
			bit_4 := bit_4 xor other.bit_4
			bit_5 := bit_5 xor other.bit_5
			bit_6 := bit_6 xor other.bit_6
			bit_7 := bit_7 xor other.bit_7
			bit_8 := bit_8 xor other.bit_8
			bit_9 := bit_9 xor other.bit_9
			bit_10 := bit_10 xor other.bit_10
			bit_11 := bit_11 xor other.bit_11
			bit_12 := bit_12 xor other.bit_12
			bit_13 := bit_13 xor other.bit_13
			bit_14 := bit_14 xor other.bit_14
			bit_15 := bit_15 xor other.bit_15
			bit_16 := bit_16 xor other.bit_16
			bit_17 := bit_17 xor other.bit_17
			bit_18 := bit_18 xor other.bit_18
			bit_19 := bit_19 xor other.bit_19
			bit_20 := bit_20 xor other.bit_20
			bit_21 := bit_21 xor other.bit_21
			bit_22 := bit_22 xor other.bit_22
			bit_23 := bit_23 xor other.bit_23
			bit_24 := bit_24 xor other.bit_24
			bit_25 := bit_25 xor other.bit_25
			bit_26 := bit_26 xor other.bit_26
			bit_27 := bit_27 xor other.bit_27
			bit_28 := bit_28 xor other.bit_28
			bit_29 := bit_29 xor other.bit_29
			bit_30 := bit_30 xor other.bit_30
			bit_31 := bit_31 xor other.bit_31
			bit_32 := bit_32 xor other.bit_32
		end

	xor_48 (other: like Current)
			-- Current := Current xor other
			-- (applied to lowest 32 bits)
		require
			not_void: other /= Void
		do
			xor_32 (other)

			bit_33 := bit_33 xor other.bit_33
			bit_34 := bit_34 xor other.bit_34
			bit_35 := bit_35 xor other.bit_35
			bit_36 := bit_36 xor other.bit_36
			bit_37 := bit_37 xor other.bit_37
			bit_38 := bit_38 xor other.bit_38
			bit_39 := bit_39 xor other.bit_39
			bit_40 := bit_40 xor other.bit_40
			bit_41 := bit_41 xor other.bit_41
			bit_42 := bit_42 xor other.bit_42
			bit_43 := bit_43 xor other.bit_43
			bit_44 := bit_44 xor other.bit_44
			bit_45 := bit_45 xor other.bit_45
			bit_46 := bit_46 xor other.bit_46
			bit_47 := bit_47 xor other.bit_47
			bit_48 := bit_48 xor other.bit_48
		end

	xor_all (other: like Current)
			-- Current := Current xor other
		require
			not_void: other /= Void
		do
			xor_48 (other)

			bit_49 := bit_49 xor other.bit_49
			bit_50 := bit_50 xor other.bit_50
			bit_51 := bit_51 xor other.bit_51
			bit_52 := bit_52 xor other.bit_52
			bit_53 := bit_53 xor other.bit_53
			bit_54 := bit_54 xor other.bit_54
			bit_55 := bit_55 xor other.bit_55
			bit_56 := bit_56 xor other.bit_56
			bit_57 := bit_57 xor other.bit_57
			bit_58 := bit_58 xor other.bit_58
			bit_59 := bit_59 xor other.bit_59
			bit_60 := bit_60 xor other.bit_60
			bit_61 := bit_61 xor other.bit_61
			bit_62 := bit_62 xor other.bit_62
			bit_63 := bit_63 xor other.bit_63
			bit_64 := bit_64 xor other.bit_64
		end

feature -- Shift

	shift_left_8
			-- Shift 8 bits to the left.
		do
			bit_1 := bit_9
			bit_2 := bit_10
			bit_3 := bit_11
			bit_4 := bit_12
			bit_5 := bit_13
			bit_6 := bit_14
			bit_7 := bit_15
			bit_8 := bit_16
			bit_9 := bit_17
			bit_10 := bit_18
			bit_11 := bit_19
			bit_12 := bit_20
			bit_13 := bit_21
			bit_14 := bit_22
			bit_15 := bit_23
			bit_16 := bit_24
			bit_17 := bit_25
			bit_18 := bit_26
			bit_19 := bit_27
			bit_20 := bit_28
			bit_21 := bit_29
			bit_22 := bit_30
			bit_23 := bit_31
			bit_24 := bit_32
			bit_25 := bit_33
			bit_26 := bit_34
			bit_27 := bit_35
			bit_28 := bit_36
			bit_29 := bit_37
			bit_30 := bit_38
			bit_31 := bit_39
			bit_32 := bit_40
			bit_33 := bit_41
			bit_34 := bit_42
			bit_35 := bit_43
			bit_36 := bit_44
			bit_37 := bit_45
			bit_38 := bit_46
			bit_39 := bit_47
			bit_40 := bit_48
			bit_41 := bit_49
			bit_42 := bit_50
			bit_43 := bit_51
			bit_44 := bit_52
			bit_45 := bit_53
			bit_46 := bit_54
			bit_47 := bit_55
			bit_48 := bit_56
			bit_49 := bit_57
			bit_50 := bit_58
			bit_51 := bit_59
			bit_52 := bit_60
			bit_53 := bit_61
			bit_54 := bit_62
			bit_55 := bit_63
			bit_56 := bit_64
		end

feature -- function f

	f (a_key: like Current)
			-- Cipher function f.
		require
			key_not_void: a_key /= Void
		local
			an_index: INTEGER
		do
			-- 32->48 bit expansion
			expansion

			-- xor key in
			xor_48 (a_key)

			-- Sbox 1
			an_index := sbox_1.item (sbox_index (bit_1, bit_2, bit_3, bit_4, bit_5, bit_6))
			bit_1 := quad_bit_1 (an_index)
			bit_2 := quad_bit_2 (an_index)
			bit_3 := quad_bit_3 (an_index)
			bit_4 := quad_bit_4 (an_index)

			-- Sbox 2
			an_index := sbox_2.item (sbox_index (bit_7, bit_8, bit_9, bit_10, bit_11, bit_12))
			bit_5 := quad_bit_1 (an_index)
			bit_6 := quad_bit_2 (an_index)
			bit_7 := quad_bit_3 (an_index)
			bit_8 := quad_bit_4 (an_index)

			-- Sbox 3
			an_index := sbox_3.item (sbox_index (bit_13, bit_14, bit_15, bit_16, bit_17, bit_18))
			bit_9 := quad_bit_1 (an_index)
			bit_10 := quad_bit_2 (an_index)
			bit_11 := quad_bit_3 (an_index)
			bit_12 := quad_bit_4 (an_index)

			-- Sbox 4
			an_index := sbox_4.item (sbox_index (bit_19, bit_20, bit_21, bit_22, bit_23, bit_24))
			bit_13 := quad_bit_1 (an_index)
			bit_14 := quad_bit_2 (an_index)
			bit_15 := quad_bit_3 (an_index)
			bit_16 := quad_bit_4 (an_index)

			-- Sbox 5
			an_index := sbox_5.item (sbox_index (bit_25, bit_26, bit_27, bit_28, bit_29, bit_30))
			bit_17 := quad_bit_1 (an_index)
			bit_18 := quad_bit_2 (an_index)
			bit_19 := quad_bit_3 (an_index)
			bit_20 := quad_bit_4 (an_index)

			-- Sbox 6
			an_index := sbox_6.item (sbox_index (bit_31, bit_32, bit_33, bit_34, bit_35, bit_36))
			bit_21 := quad_bit_1 (an_index)
			bit_22 := quad_bit_2 (an_index)
			bit_23 := quad_bit_3 (an_index)
			bit_24 := quad_bit_4 (an_index)

			-- Sbox 7
			an_index := sbox_7.item (sbox_index (bit_37, bit_38, bit_39, bit_40, bit_41, bit_42))
			bit_25 := quad_bit_1 (an_index)
			bit_26 := quad_bit_2 (an_index)
			bit_27 := quad_bit_3 (an_index)
			bit_28 := quad_bit_4 (an_index)

			-- Sbox 8
			an_index := sbox_8.item (sbox_index (bit_43, bit_44, bit_45, bit_46, bit_47, bit_48))
			bit_29 := quad_bit_1 (an_index)
			bit_30 := quad_bit_2 (an_index)
			bit_31 := quad_bit_3 (an_index)
			bit_32 := quad_bit_4 (an_index)

			-- finish with permutation P
			p_permutation
		end

feature {NONE} -- function f()

	expansion
			-- 32->48 bit expansion function.
		local
			saved: BOOLEAN
		do
			-- Generated from standard
			-- (in reverse order to allow in place)
			saved := bit_32

			bit_48 := bit_1
			bit_47 := bit_32
			bit_46 := bit_31
			bit_45 := bit_30
			bit_44 := bit_29
			bit_43 := bit_28
			bit_42 := bit_29
			bit_41 := bit_28
			bit_40 := bit_27
			bit_39 := bit_26
			bit_38 := bit_25
			bit_37 := bit_24
			bit_36 := bit_25
			bit_35 := bit_24
			bit_34 := bit_23
			bit_33 := bit_22
			bit_32 := bit_21
			bit_31 := bit_20
			bit_30 := bit_21
			bit_29 := bit_20
			bit_28 := bit_19
			bit_27 := bit_18
			bit_26 := bit_17
			bit_25 := bit_16
			bit_24 := bit_17
			bit_23 := bit_16
			bit_22 := bit_15
			bit_21 := bit_14
			bit_20 := bit_13
			bit_19 := bit_12
			bit_18 := bit_13
			bit_17 := bit_12
			bit_16 := bit_11
			bit_15 := bit_10
			bit_14 := bit_9
			bit_13 := bit_8
			bit_12 := bit_9
			bit_11 := bit_8
			bit_10 := bit_7
			bit_9 := bit_6
			bit_8 := bit_5
			bit_7 := bit_4
			bit_6 := bit_5
			bit_5 := bit_4
			bit_4 := bit_3
			bit_3 := bit_2
			bit_2 := bit_1
			bit_1 := saved
		end

	p_permutation
			-- Permutation P for f.
		local
			saved_1: BOOLEAN
			saved_5: BOOLEAN
			saved_10: BOOLEAN
			saved_2: BOOLEAN
			saved_8: BOOLEAN
			saved_14: BOOLEAN
			saved_3: BOOLEAN
			saved_9: BOOLEAN
			saved_19: BOOLEAN
			saved_13: BOOLEAN
			saved_6: BOOLEAN
			saved_22: BOOLEAN
			saved_11: BOOLEAN
			saved_4: BOOLEAN
			saved_25: BOOLEAN
		do
			saved_1 := bit_1
			saved_5 := bit_5
			saved_10 := bit_10
			saved_2 := bit_2
			saved_8 := bit_8
			saved_14 := bit_14
			saved_3 := bit_3
			saved_9 := bit_9
			saved_19 := bit_19
			saved_13 := bit_13
			saved_6 := bit_6
			saved_22 := bit_22
			saved_11 := bit_11
			saved_4 := bit_4
			saved_25 := bit_25

			-- Generated from FIPS standard
			bit_1 := bit_16
			bit_2 := bit_7
			bit_3 := bit_20
			bit_4 := bit_21
			bit_5 := bit_29
			bit_6 := bit_12
			bit_7 := bit_28
			bit_8 := bit_17
			bit_9 := saved_1
			bit_10 := bit_15
			bit_11 := bit_23
			bit_12 := bit_26
			bit_13 := saved_5
			bit_14 := bit_18
			bit_15 := bit_31
			bit_16 := saved_10
			bit_17 := saved_2
			bit_18 := saved_8
			bit_19 := bit_24
			bit_20 := saved_14
			bit_21 := bit_32
			bit_22 := bit_27
			bit_23 := saved_3
			bit_24 := saved_9
			bit_25 := saved_19
			bit_26 := saved_13
			bit_27 := bit_30
			bit_28 := saved_6
			bit_29 := saved_22
			bit_30 := saved_11
			bit_31 := saved_4
			bit_32 := saved_25
		end

feature {NONE} -- function f(): S-boxes

	sbox_index (a1, a2, a3, a4, a5, a6: BOOLEAN): INTEGER
			-- Index into an sbox from 6 incoming bits.
		do
			-- a2-a5 column number
			if a2 then
				Result := 8
			end
			if a3 then
				Result := Result + 4
			end
			if a4 then
				Result := Result + 2
			end
			if a5 then
				Result := Result + 1
			end

			-- a1*2+a6 row number
			if a1 then
				Result := Result + 32
			end
			if a6 then
				Result := Result + 16
			end
			Result := Result + 1
		ensure
			index: Result > 0 and Result <= 64
		end

	quad_bit_1 (an_index: INTEGER): BOOLEAN
			-- Bit 1 from 1-16 index
		require
			index: an_index >= 0 and an_index < 16
		do
			Result := byte_bit_5 (an_index)
		end

	quad_bit_2 (an_index: INTEGER): BOOLEAN
			-- Bit 2 from 1-16 index.
		require
			index: an_index >= 0 and an_index < 16
		do
			Result := byte_bit_6 (an_index)
		end

	quad_bit_3 (an_index: INTEGER): BOOLEAN
			-- Bit 3 from 1-16 index.
		require
			index: an_index >= 0 and an_index < 16
		do
			Result := byte_bit_7 (an_index)
		end

	quad_bit_4(an_index: INTEGER): BOOLEAN
			-- Bit 4 from 1-16 index.
		require
			index: an_index >= 0 and an_index < 16
		do
			Result := byte_bit_8 (an_index)
		end

feature {NONE} -- Sbox

	sbox_1: ARRAY[INTEGER]
		once
 			Result := <<
			14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7,
			0,  15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8,
			4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0,
			15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0,  6, 13 >>
		ensure
			lower_1: Result.lower = 1
		end

	sbox_2: ARRAY[INTEGER]
		once
 			Result := <<
			15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0,  5, 10,
			3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5,
			0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15,
			13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9 >>
		ensure
			lower_1: Result.lower = 1
		end

	sbox_3: ARRAY[INTEGER]
		once
 			Result := <<
			10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8,
			13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1,
			13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7,
			1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12 >>
		ensure
			lower_1: Result.lower = 1
		end

	sbox_4: ARRAY[INTEGER]
		once
 			Result := <<
			7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15,
			13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9,
			10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4,
			3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14 >>
		ensure
			lower_1: Result.lower = 1
		end

	sbox_5: ARRAY[INTEGER]
		once
 			Result := <<
			2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9,
			14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6,
			4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0,  14,
    		11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3 >>
		ensure
			lower_1: Result.lower = 1
		end

	sbox_6: ARRAY[INTEGER]
		once
 			Result := <<
			12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11,
			10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8,
			9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6,
			4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13 >>
		ensure
			lower_1: Result.lower = 1
		end

	sbox_7: ARRAY[INTEGER]
		once
 			Result := <<
			4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1,
			13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6,
			1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2,
			6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12 >>
		ensure
			lower_1: Result.lower = 1
		end

	sbox_8: ARRAY[INTEGER]
		once
 			Result := <<
			13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7,
			1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2,
			7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8,
			2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11 >>
		ensure
			lower_1: Result.lower = 1
		end

feature -- Initial permutation

	initial_permutation (other: like Current)
			-- Initial permuation (IP)
		require
			not_void: other /= Void
			shuffling: other /= Current
		do
			-- Generated from FIPS standard
			bit_1 := other.bit_58
  			bit_2 := other.bit_50
			bit_3 := other.bit_42
			bit_4 := other.bit_34
			bit_5 := other.bit_26
			bit_6 := other.bit_18
			bit_7 := other.bit_10
			bit_8 := other.bit_2
			bit_9 := other.bit_60
			bit_10 := other.bit_52
			bit_11 := other.bit_44
			bit_12 := other.bit_36
			bit_13 := other.bit_28
			bit_14 := other.bit_20
			bit_15 := other.bit_12
			bit_16 := other.bit_4
			bit_17 := other.bit_62
			bit_18 := other.bit_54
			bit_19 := other.bit_46
			bit_20 := other.bit_38
			bit_21 := other.bit_30
			bit_22 := other.bit_22
			bit_23 := other.bit_14
			bit_24 := other.bit_6
			bit_25 := other.bit_64
			bit_26 := other.bit_56
			bit_27 := other.bit_48
			bit_28 := other.bit_40
			bit_29 := other.bit_32
			bit_30 := other.bit_24
			bit_31 := other.bit_16
			bit_32 := other.bit_8
			bit_33 := other.bit_57
			bit_34 := other.bit_49
			bit_35 := other.bit_41
			bit_36 := other.bit_33
			bit_37 := other.bit_25
			bit_38 := other.bit_17
			bit_39 := other.bit_9
			bit_40 := other.bit_1
			bit_41 := other.bit_59
			bit_42 := other.bit_51
			bit_43 := other.bit_43
			bit_44 := other.bit_35
			bit_45 := other.bit_27
			bit_46 := other.bit_19
			bit_47 := other.bit_11
			bit_48 := other.bit_3
			bit_49 := other.bit_61
			bit_50 := other.bit_53
			bit_51 := other.bit_45
			bit_52 := other.bit_37
			bit_53 := other.bit_29
			bit_54 := other.bit_21
			bit_55 := other.bit_13
			bit_56 := other.bit_5
			bit_57 := other.bit_63
			bit_58 := other.bit_55
			bit_59 := other.bit_47
			bit_60 := other.bit_39
			bit_61 := other.bit_31
			bit_62 := other.bit_23
			bit_63 := other.bit_15
			bit_64 := other.bit_7
		end

	inverse_initial_permutation (other: like Current)
			-- Inverse initial permutation (IP-1).
		require
			not_void: other /= Void
			shuffling: other /= Current
		do
			-- Generated from FIPS standard
			bit_1 := other.bit_40
			bit_2 := other.bit_8
			bit_3 := other.bit_48
			bit_4 := other.bit_16
			bit_5 := other.bit_56
			bit_6 := other.bit_24
			bit_7 := other.bit_64
			bit_8 := other.bit_32
			bit_9 := other.bit_39
			bit_10 := other.bit_7
			bit_11 := other.bit_47
			bit_12 := other.bit_15
			bit_13 := other.bit_55
			bit_14 := other.bit_23
			bit_15 := other.bit_63
			bit_16 := other.bit_31
			bit_17 := other.bit_38
			bit_18 := other.bit_6
			bit_19 := other.bit_46
			bit_20 := other.bit_14
			bit_21 := other.bit_54
			bit_22 := other.bit_22
			bit_23 := other.bit_62
			bit_24 := other.bit_30
			bit_25 := other.bit_37
			bit_26 := other.bit_5
			bit_27 := other.bit_45
			bit_28 := other.bit_13
			bit_29 := other.bit_53
			bit_30 := other.bit_21
			bit_31 := other.bit_61
			bit_32 := other.bit_29
			bit_33 := other.bit_36
			bit_34 := other.bit_4
			bit_35 := other.bit_44
			bit_36 := other.bit_12
			bit_37 := other.bit_52
			bit_38 := other.bit_20
			bit_39 := other.bit_60
			bit_40 := other.bit_28
			bit_41 := other.bit_35
			bit_42 := other.bit_3
			bit_43 := other.bit_43
			bit_44 := other.bit_11
			bit_45 := other.bit_51
			bit_46 := other.bit_19
			bit_47 := other.bit_59
			bit_48 := other.bit_27
			bit_49 := other.bit_34
			bit_50 := other.bit_2
			bit_51 := other.bit_42
			bit_52 := other.bit_10
			bit_53 := other.bit_50
			bit_54 := other.bit_18
			bit_55 := other.bit_58
			bit_56 := other.bit_26
			bit_57 := other.bit_33
			bit_58 := other.bit_1
			bit_59 := other.bit_41
			bit_60 := other.bit_9
			bit_61 := other.bit_49
			bit_62 := other.bit_17
			bit_63 := other.bit_57
			bit_64 := other.bit_25
		end

feature {CRYPT_DES_BLOCK} -- bits

	bit_1: BOOLEAN
	bit_2: BOOLEAN
	bit_3: BOOLEAN
	bit_4: BOOLEAN
	bit_5: BOOLEAN
	bit_6: BOOLEAN
	bit_7: BOOLEAN
	bit_8: BOOLEAN
	bit_9: BOOLEAN
	bit_10: BOOLEAN
	bit_11: BOOLEAN
	bit_12: BOOLEAN
	bit_13: BOOLEAN
	bit_14: BOOLEAN
	bit_15: BOOLEAN
	bit_16: BOOLEAN
	bit_17: BOOLEAN
	bit_18: BOOLEAN
	bit_19: BOOLEAN
	bit_20: BOOLEAN
	bit_21: BOOLEAN
	bit_22: BOOLEAN
	bit_23: BOOLEAN
	bit_24: BOOLEAN
	bit_25: BOOLEAN
	bit_26: BOOLEAN
	bit_27: BOOLEAN
	bit_28: BOOLEAN
	bit_29: BOOLEAN
	bit_30: BOOLEAN
	bit_31: BOOLEAN
	bit_32: BOOLEAN
	bit_33: BOOLEAN
	bit_34: BOOLEAN
	bit_35: BOOLEAN
	bit_36: BOOLEAN
	bit_37: BOOLEAN
	bit_38: BOOLEAN
	bit_39: BOOLEAN
	bit_40: BOOLEAN
	bit_41: BOOLEAN
	bit_42: BOOLEAN
	bit_43: BOOLEAN
	bit_44: BOOLEAN
	bit_45: BOOLEAN
	bit_46: BOOLEAN
	bit_47: BOOLEAN
	bit_48: BOOLEAN
	bit_49: BOOLEAN
	bit_50: BOOLEAN
	bit_51: BOOLEAN
	bit_52: BOOLEAN
	bit_53: BOOLEAN
	bit_54: BOOLEAN
	bit_55: BOOLEAN
	bit_56: BOOLEAN
	bit_57: BOOLEAN
	bit_58: BOOLEAN
	bit_59: BOOLEAN
	bit_60: BOOLEAN
	bit_61: BOOLEAN
	bit_62: BOOLEAN
	bit_63: BOOLEAN
	bit_64: BOOLEAN

feature -- Bytes

	byte_1: INTEGER
		do
			Result := byte (bit_1, bit_2, bit_3, bit_4, bit_5, bit_6, bit_7, bit_8)
		end

	byte_2: INTEGER
		do
			Result := byte (bit_9, bit_10, bit_11, bit_12, bit_13, bit_14, bit_15, bit_16)
		end

	byte_3: INTEGER
		do
			Result := byte (bit_17, bit_18, bit_19, bit_20, bit_21, bit_22, bit_23, bit_24)
		end

	byte_4: INTEGER
		do
			Result := byte (bit_25, bit_26, bit_27, bit_28, bit_29, bit_30, bit_31, bit_32)
		end

	byte_5: INTEGER
		do
			Result := byte (bit_33, bit_34, bit_35, bit_36, bit_37, bit_38, bit_39, bit_40)
		end

	byte_6: INTEGER
		do
			Result := byte (bit_41, bit_42, bit_43, bit_44, bit_45, bit_46, bit_47, bit_48)
		end

	byte_7: INTEGER
		do
			Result := byte (bit_49, bit_50, bit_51, bit_52, bit_53, bit_54, bit_55, bit_56)
		end

	byte_8: INTEGER
		do
			Result := byte (bit_57, bit_58, bit_59, bit_60, bit_61, bit_62, bit_63, bit_64)
		end

	set_1 (b1: INTEGER)
		do
			bit_1 := byte_bit_1 (b1)
			bit_2 := byte_bit_2 (b1)
			bit_3 := byte_bit_3 (b1)
			bit_4 := byte_bit_4 (b1)
			bit_5 := byte_bit_5 (b1)
			bit_6 := byte_bit_6 (b1)
			bit_7 := byte_bit_7 (b1)
			bit_8 := byte_bit_8 (b1)
		end

	set_2 (b2: INTEGER)
		do
			bit_9 := byte_bit_1 (b2)
			bit_10 := byte_bit_2 (b2)
			bit_11 := byte_bit_3 (b2)
			bit_12 := byte_bit_4 (b2)
			bit_13 := byte_bit_5 (b2)
			bit_14 := byte_bit_6 (b2)
			bit_15 := byte_bit_7 (b2)
			bit_16 := byte_bit_8 (b2)
		end

	set_3 (b3: INTEGER)
		do
			bit_17 := byte_bit_1 (b3)
			bit_18 := byte_bit_2 (b3)
			bit_19 := byte_bit_3 (b3)
			bit_20 := byte_bit_4 (b3)
			bit_21 := byte_bit_5 (b3)
			bit_22 := byte_bit_6 (b3)
			bit_23 := byte_bit_7 (b3)
			bit_24 := byte_bit_8 (b3)
		end

	set_4 (b4: INTEGER)
		do
			bit_25 := byte_bit_1 (b4)
			bit_26 := byte_bit_2 (b4)
			bit_27 := byte_bit_3 (b4)
			bit_28 := byte_bit_4 (b4)
			bit_29 := byte_bit_5 (b4)
			bit_30 := byte_bit_6 (b4)
			bit_31 := byte_bit_7 (b4)
			bit_32 := byte_bit_8 (b4)
		end

	set_5 (b5: INTEGER)
		do
			bit_33 := byte_bit_1 (b5)
			bit_34 := byte_bit_2 (b5)
			bit_35 := byte_bit_3 (b5)
			bit_36 := byte_bit_4 (b5)
			bit_37 := byte_bit_5 (b5)
			bit_38 := byte_bit_6 (b5)
			bit_39 := byte_bit_7 (b5)
			bit_40 := byte_bit_8 (b5)
		end

	set_6 (b6: INTEGER)
		do
			bit_41 := byte_bit_1 (b6)
			bit_42 := byte_bit_2 (b6)
			bit_43 := byte_bit_3 (b6)
			bit_44 := byte_bit_4 (b6)
			bit_45 := byte_bit_5 (b6)
			bit_46 := byte_bit_6 (b6)
			bit_47 := byte_bit_7 (b6)
			bit_48 := byte_bit_8 (b6)
		end

	set_7 (b7: INTEGER)
		do
			bit_49 := byte_bit_1 (b7)
			bit_50 := byte_bit_2 (b7)
			bit_51 := byte_bit_3 (b7)
			bit_52 := byte_bit_4 (b7)
			bit_53 := byte_bit_5 (b7)
			bit_54 := byte_bit_6 (b7)
			bit_55 := byte_bit_7 (b7)
			bit_56 := byte_bit_8 (b7)
		end

	set_8 (b8: INTEGER)
		do
			bit_57 := byte_bit_1 (b8)
			bit_58 := byte_bit_2 (b8)
			bit_59 := byte_bit_3 (b8)
			bit_60 := byte_bit_4 (b8)
			bit_61 := byte_bit_5 (b8)
			bit_62 := byte_bit_6 (b8)
			bit_63 := byte_bit_7 (b8)
			bit_64 := byte_bit_8 (b8)
		end

feature {NONE} -- Bytes

	byte (b1,b2,b3,b4,b5,b6,b7,b8: BOOLEAN): INTEGER
			-- Byte from bits.
		do
			if b8 then Result := 1 end
			if b7 then Result := Result + 2 end
			if b6 then Result := Result + 4 end
			if b5 then Result := Result + 8 end
			if b4 then Result := Result + 16 end
			if b3 then Result := Result + 32 end
			if b2 then Result := Result + 64 end
			if b1 then Result := Result + 128 end
		end

	byte_bit_8 (b: INTEGER): BOOLEAN
		do
			if b \\ 2 = 1 then
				Result := True
			end
		end

	byte_bit_7 (b: INTEGER): BOOLEAN
		do
			Result := byte_bit_8 (b // 2)
		end

	byte_bit_6 (b: INTEGER): BOOLEAN
		do
			Result := byte_bit_8 (b // 4)
		end

	byte_bit_5 (b: INTEGER): BOOLEAN
		do
			Result := byte_bit_8 (b // 8)
		end

	byte_bit_4 (b: INTEGER): BOOLEAN
		do
			Result := byte_bit_8 (b // 16)
		end

	byte_bit_3 (b: INTEGER): BOOLEAN
		do
			Result := byte_bit_8 (b // 32)
		end

	byte_bit_2 (b: INTEGER): BOOLEAN
		do
			Result := byte_bit_8 (b // 64)
		end

	byte_bit_1 (b: INTEGER): BOOLEAN
		do
			Result := byte_bit_8 (b // 128)
		end

feature -- Out

	bits_out_32: STRING
			-- Lower 32 bits as text.
		do
			create Result.make (0)
			Result.append_character (bit_out (bit_1))
			Result.append_character (bit_out (bit_2))
			Result.append_character (bit_out (bit_3))
			Result.append_character (bit_out (bit_4))
			Result.append_character (bit_out (bit_5))
			Result.append_character (bit_out (bit_6))
			Result.append_character (bit_out (bit_7))
			Result.append_character (bit_out (bit_8))

			Result.append_character (bit_out (bit_9))
			Result.append_character (bit_out (bit_10))
			Result.append_character (bit_out (bit_11))
			Result.append_character (bit_out (bit_12))
			Result.append_character (bit_out (bit_13))
			Result.append_character (bit_out (bit_14))
			Result.append_character (bit_out (bit_15))
			Result.append_character (bit_out (bit_16))

			Result.append_character (bit_out (bit_17))
			Result.append_character (bit_out (bit_18))
			Result.append_character (bit_out (bit_19))
			Result.append_character (bit_out (bit_20))
			Result.append_character (bit_out (bit_21))
			Result.append_character (bit_out (bit_22))
			Result.append_character (bit_out (bit_23))
			Result.append_character (bit_out (bit_24))

			Result.append_character (bit_out (bit_25))
			Result.append_character (bit_out (bit_26))
			Result.append_character (bit_out (bit_27))
			Result.append_character (bit_out (bit_28))
			Result.append_character (bit_out (bit_29))
			Result.append_character (bit_out (bit_30))
			Result.append_character (bit_out (bit_31))
			Result.append_character (bit_out (bit_32))
		end

	bits_out: STRING
			-- Bits as text.
		do
			Result := bits_out_32
			Result.append_character (bit_out (bit_33))
			Result.append_character (bit_out (bit_34))
			Result.append_character (bit_out (bit_35))
			Result.append_character (bit_out (bit_36))
			Result.append_character (bit_out (bit_37))
			Result.append_character (bit_out (bit_38))
			Result.append_character (bit_out (bit_39))
			Result.append_character (bit_out (bit_40))

			Result.append_character (bit_out (bit_41))
			Result.append_character (bit_out (bit_42))
			Result.append_character (bit_out (bit_43))
			Result.append_character (bit_out (bit_44))
			Result.append_character (bit_out (bit_45))
			Result.append_character (bit_out (bit_46))
			Result.append_character (bit_out (bit_47))
			Result.append_character (bit_out (bit_48))

			Result.append_character (bit_out (bit_49))
			Result.append_character (bit_out (bit_50))
			Result.append_character (bit_out (bit_51))
			Result.append_character (bit_out (bit_52))
			Result.append_character (bit_out (bit_53))
			Result.append_character (bit_out (bit_54))
			Result.append_character (bit_out (bit_55))
			Result.append_character (bit_out (bit_56))

			Result.append_character (bit_out (bit_57))
			Result.append_character (bit_out (bit_58))
			Result.append_character (bit_out (bit_59))
			Result.append_character (bit_out (bit_60))
			Result.append_character (bit_out (bit_61))
			Result.append_character (bit_out (bit_62))
			Result.append_character (bit_out (bit_63))
			Result.append_character (bit_out (bit_64))
		end

	bit_out (b: BOOLEAN): CHARACTER
		do
			if b then
				Result := '1'
			else
				Result := '0'
			end
		end
end
