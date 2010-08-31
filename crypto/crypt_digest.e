note
	description: "Byte consumer that produces a message digest"

deferred class CRYPT_DIGEST

inherit
	CRYPT_BYTE_CONSUMER

feature -- Digest

	digest: CRYPT_BYTES
			-- Message digest.
			-- Valid after call to 'final'.
		require
			--final: is_final
		deferred
		ensure
			not_void: Result /= Void
			size: Result.count = digest_size
		end

	digest_size: INTEGER
			-- Message digest size.
			-- (fixed for each algorithm)
		deferred
		end

	block_size: INTEGER
			-- Input block size.
			-- This is normally not of interest for clients as
			-- descendants handle padding.
		deferred
		end

end
