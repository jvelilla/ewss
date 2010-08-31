note
	description: "Stream filter"

class CRYPT_STREAM_PRIVATE_FACTORY

feature {NONE} -- Stream end

	string_stream: CRYPT_STREAM_STRING
			-- Stream to string.
		do
			create Result
		end

	into_stream (a: STRING): CRYPT_STREAM_INTO_STRING
			-- Stream to a specific string.
		require
			not_void: a /= Void
		do
			create Result.make (a)
		end

	print_stream: CRYPT_STREAM_PRINT
			-- Stream that prints on 'io'.
		do
			create Result
		end

	bytes_stream: CRYPT_STREAM_BYTES
			-- Stream to CRYTP_BYTES.
		do
			create Result
		end

feature {NONE} -- Stream utilitie(s)

	duplicate_stream (a: CRYPT_BYTE_CONSUMER; a_other: CRYPT_BYTE_CONSUMER): CRYPT_STREAM_DUPLICATE
		require
			not_void: a /= Void
			other_not_void: a_other /= Void
		do
			create Result.make (a, a_other)
		end

feature {NONE} -- Cipher filters

	encrypt_des_cfb (a: CRYPT_BYTE_CONSUMER): CRYPT_ENCRYPT_DES_CFB
			-- Encrypt DES byte mode.
		require
			not_void: a /= Void
		do
			create Result.make (a)
		end

	decrypt_des_cfb (a: CRYPT_BYTE_CONSUMER): CRYPT_DECRYPT_DES_CFB
			-- Decrypt DES byte mode.
		require
			not_void: a /= Void
		do
			create Result.make (a)
		end

	encrypt_des_cbc (a: CRYPT_BYTE_CONSUMER): CRYPT_ENCRYPT_DES_CBC
			-- Encrypt DES block mode.
		require
			not_void: a /= Void
		do
			create Result.make (a)
		end

	decrypt_des_cbc (a: CRYPT_BYTE_CONSUMER): CRYPT_DECRYPT_DES_CBC
			-- Decrypt DES block mode.
		require
			not_void: a /= Void
		do
			create Result.make (a)
		end

feature {NONE} -- Digest consumers

	md5: CRYPT_MD5
			-- MD5 message digest.
		do
			create Result.make
		end

	hmac_md5: CRYPT_HMAC_MD5 
			-- HMAC message authentication using MD5.
		do
			create Result.make
		end

end
