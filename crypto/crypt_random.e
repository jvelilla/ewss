note
	description: "Get random block of *cryptographic-quality* data"

deferred class CRYPT_RANDOM

feature -- Interface

	make_random (n_bytes: INTEGER)
			-- Make a random block of 'n_bytes'.
			-- For security to be valid, the result MUST BE
			-- of cryptographic quality.
		require
			positive: n_bytes> 0
		deferred
		ensure
			set: last_bytes /= Void
			count: n_bytes = last_bytes.count
		end

	last_bytes: CRYPT_BYTES

feature {NONE} -- Convenience

	make_last_bytes (n: INTEGER) 
			-- Create 'last_bytes'.
		require
			positive: n > 0
		do
			!CRYPT_BYTES_ARRAY! last_bytes.make (n)
		end

end
