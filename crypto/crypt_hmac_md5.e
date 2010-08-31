note
	description: "HMAC-MD5: HMAC using MD-5 message digest"

class CRYPT_HMAC_MD5

inherit
	CRYPT_HMAC

create
	make

feature

	make 
			-- Init hash function to MD5.
		do
			create {CRYPT_MD5} digester.make
		end

end
