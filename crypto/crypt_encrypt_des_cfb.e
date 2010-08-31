note
	description: "Encryption/decryption using DES Cipher Feedback Mode"
	crypt_decrypt: "Encryption and decryption are identical"

class CRYPT_ENCRYPT_DES_CFB

inherit
	CRYPT_STREAM_CIPHER_FILTER
	CRYPT_BIT32_PRIVATE_ROUTINES

create
	make

feature {NONE} -- Creation

	make_cipher
			-- Make des.
		do
			create {CRYPT_DES} cipher.make
		end

feature -- Stream

	init
			-- Initialisation.
		do
			create shift_block
			next.init
		end

	update_byte (a:INTEGER)
			-- Update byte.
		local
			a_next: INTEGER
		do
			cipher.encrypt (shift_block)

			-- xor first byte of DES-ed shift register with input
			a_next := byte_xor (cipher.last.first, a)
			next.update_byte (a_next)

			-- feedback
			shift_block.shift_left (a_next)
		end

	final 
			-- Final.
		do
			next.final
		end

feature {NONE} -- State

	shift_block: CRYPT_8BYTES_SIMPLE

end
