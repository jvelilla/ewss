
indexing
	description: "Fixed-size block cipher interface"
	
deferred class CRYPT_BLOCK_CIPHER

feature -- Key

	key_size: INTEGER is
			-- Key size in bytes.
		deferred
		ensure
			positive: Result > 0
		end
	
	set_key (a: CRYPT_BYTES) is
		
		require
			not_void: a /= Void
			size: a.count = key_size
		deferred
		end	
		
feature -- Encrypt decrypt

	block_size: INTEGER is
			-- Block size in bytes.
		deferred
		ensure
			positive: Result > 0
		end
		
	encrypt (a: CRYPT_BYTES) is
			-- Encrypt byte block.
		require
			not_void: a /= Void
			size: a.count = block_size
		deferred
		end
		
	decrypt (a: CRYPT_BYTES) is
			-- Decrypt byte block.
		require
			not_void: a /= Void
			size: a.count = block_size
		deferred
		end
		
	last: CRYPT_BYTES is
			-- Last processed block.
		deferred
		ensure
			size: Result.count = block_size
		end

end
