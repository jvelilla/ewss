note
	description: "Decrypt stream using DES Cipher Feedback Mode"

class CRYPT_DECRYPT_DES_CFB

inherit
	CRYPT_ENCRYPT_DES_CFB
		redefine
			update_byte
		end

create
	make

feature -- Stream

	update_byte (a:INTEGER) 
			-- Update byte.
		do
			cipher.encrypt (shift_block)
			next.update_byte (byte_xor (cipher.last.first, a))

			-- feedback
			shift_block.shift_left (a)
		end

end
