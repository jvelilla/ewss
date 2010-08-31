note
	description: "Byte stream filter making use of a block cipher"

deferred class CRYPT_STREAM_CIPHER_FILTER

inherit
	CRYPT_STREAM_FILTER

feature {NONE} -- Creation

	make (a_next: CRYPT_BYTE_CONSUMER)
			-- Make.
		do
			make_cipher
			set_next (a_next)
		ensure
			next: is_valid_next
		end

	make_cipher
			-- Initialise cipher.
		deferred
		end

feature -- Key

	set_key (a: CRYPT_BYTES)
			-- Set key.
		require
			size: a.count = key_size
		do
			cipher.set_key (a)
		end

	key_size: INTEGER 
			-- Key size.
		do
			Result := cipher.key_size
		end

feature {NONE} -- Cipher

	cipher: CRYPT_BLOCK_CIPHER
			-- Block cipher.

invariant
	cipher_not_void: cipher /= Void
	next: is_valid_next

end
