note
	description: "HMAC: Keyed-Hashing for Message Authentication"
	implements: "RFC 2104"
	notes: "descendant initialises 'digester'"

deferred class CRYPT_HMAC

inherit
	CRYPT_DIGEST

feature -- Computation: H(key XOR opad, H(key XOR ipad, text))

	init
			-- Init.
		do
			-- i_digest := H (key XOR ipad, ...
			digester.init
			digester.update_bytes (ipad_key)
		end

	update_byte (b: INTEGER)
			-- Add message byte.
		do
			-- ...text ...
			digester.update_byte (b)
		end

	final
			-- Finish.
		local
			i_digest: CRYPT_BYTES
		do
			-- ...)
			digester.final
			i_digest := digester.digest

			-- H(key XOR opad, i_digest)
			digester.init
			digester.update_bytes (opad_key)
			digester.update_bytes (i_digest)
			digester.final
			-- our own 'digest' now set.
		end

feature -- Delegated digest

	digest: CRYPT_BYTES
		do
			Result := digester.digest
		end

	digest_size: INTEGER
		do
			Result := digester.digest_size
		end

	block_size: INTEGER
		do
			Result := digester.block_size
		end

feature {NONE} -- Hash function

	digester: CRYPT_DIGEST

feature {NONE} -- Key state

	key: CRYPT_BYTES

feature -- Key

	set_key (a_key: CRYPT_BYTES)
			-- Set key.
			-- Ideally size is digest_size.
		require
			--before: set before init and not during calculation
		do
			if a_key.count > block_size then
				digester.init
				digester.update_bytes (a_key)
				digester.final
				key := digester.digest
			else
				key := a_key
			end
		ensure
			has_key: has_key
			--may_keep_reference: a_key may= key
		end

	has_key: BOOLEAN
			-- Has a key been set?
		do
			Result := key /= Void
		end

feature {NONE} -- Padding

	opad_key: CRYPT_BYTES
			-- Output pad.
		require
			has_key: has_key
		do
			Result := pad (Opad_byte)
			Result.xor_bytes (key)
		ensure
			not_void: Result /= Void
			size: Result.count = block_size
		end

	ipad_key: CRYPT_BYTES
			-- Input pad.
		require
			has_key: has_key
		do
			Result := pad (Ipad_byte)
			Result.xor_bytes (key)
		ensure
			not_void: Result /= Void
			size: Result.count = block_size
		end

	pad (a_byte: INTEGER): CRYPT_BYTES_ARRAY
			-- Make a block padded with a byte.
		local
			i: INTEGER
		do
			create Result.make (digester.block_size)
			from
				i := Result.count
			variant
				i
			until
				i = 0
			loop
				Result.put (a_byte, i)
				i := i - 1
			end
		ensure
			not_void: Result /= Void
			size: Result.count = block_size
		end

	Ipad_byte: INTEGER = 54 -- 0x36
	Opad_byte: INTEGER = 92 -- 0x5c

invariant
	digester: digester /= Void
	key_size: has_key implies key.count <= block_size

end
