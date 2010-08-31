note
	description: "Mixin version of stream factory routines"

class CRYPT_STREAM_FACTORY

inherit
	CRYPT_STREAM_PRIVATE_FACTORY
		export
			{ANY} into_stream, string_stream,
				print_stream, duplicate_stream,
				encrypt_des_cfb, decrypt_des_cfb,
				encrypt_des_cbc, decrypt_des_cbc,
				md5, hmac_md5
		end

end
