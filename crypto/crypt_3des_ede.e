note
	description: "Triple DES Encrypt-Decrypt-Encrypt"

class CRYPT_3DES_EDE

inherit
	CRYPT_BLOCK_CIPHER

create
	make

feature

	key_size: INTEGER
			-- 3xDES: 24 bytes, of which 168 bits are significant.
		once
			Result := encrypt_1.key_size * 3
		end

	set_key (a: CRYPT_BYTES)
			-- Set key.
		local
			a_block: CRYPT_DES_BLOCK
		do
			create a_block

			a_block.copy_bytes_at (a,1)
			encrypt_1.set_key (a_block)

			a_block.copy_bytes_at (a,9)
			decrypt_1.set_key (a_block)

			a_block.copy_bytes_at (a,17)
			encrypt_2.set_key (a_block)
		end

feature -- Block cipher

	block_size: INTEGER
			-- Same as DES.
		once
			Result := encrypt_1.block_size
		end

	encrypt (a: CRYPT_BYTES)
			-- DES Encrypt-Decrypt-Encrypt
		do
			encrypt_1.encrypt (a)
			decrypt_1.decrypt_block (encrypt_1.last_block)
			encrypt_2.encrypt (decrypt_1.last_block)
			last := encrypt_2.last_block
		end

	decrypt (a: CRYPT_BYTES)
			-- DES Decrypt-Encrypt-Decrypt reversed (DED)
		do
			encrypt_2.decrypt (a)
			decrypt_1.encrypt_block (encrypt_2.last_block)
			encrypt_1.decrypt (decrypt_1.last_block)
			last := encrypt_1.last_block
		end

	last: CRYPT_BYTES
			-- Result.

feature {NONE}

	make
			-- Make.
		do
			create encrypt_1.make
			create decrypt_1.make
			create encrypt_2.make
		end

feature {NONE} -- Simple DES

	encrypt_1: CRYPT_DES
	decrypt_1: CRYPT_DES
	encrypt_2: CRYPT_DES

invariant
	not_void: encrypt_1 /= Void and decrypt_1 /= Void and encrypt_2 /= Void

end
