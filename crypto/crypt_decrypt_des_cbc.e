note
	description: "Decryption using DES Cipher Block Chaining"
	block_warning: "Output size is multiple of block size (may include padding)"

class CRYPT_DECRYPT_DES_CBC

inherit
	CRYPT_ENCRYPT_DES_CBC
		redefine
			init, update_chain
		end

create
	make

feature -- Stream

	init
			-- Initialise.
		do
			init_vector_done := False
			create xor_block

			init_blocks
			next.init
		end

feature {NONE}

	init_vector_done: BOOLEAN
			-- Has the intialisation vector been processed?

feature {NONE}

	update_chain
			-- Update chain.
		do
			if not init_vector_done then
				-- first block is init vector, initialises
				-- feedback block, no output.
				last_block.copy (incoming_block)
				init_vector_done := True
			else
				-- Decrypted := DES-decrypt (Incoming) XOR Last_block
				cipher.decrypt (incoming_block)
				xor_block.copy_bytes (cipher.last) -- typing
				last_block.xor_all (xor_block)
				next.update_bytes (last_block)
				-- Last block := Incoming
				last_block.copy_bytes (incoming_block)
			end
		end

	xor_block: CRYPT_DES_BLOCK

end
