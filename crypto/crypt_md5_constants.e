note
	description: "MD5 constants"
	notes: "generated"
	project: "http://www.nenie.org/eiffel/"
	license: "http://www.opensource.org/licenses/mit-license.html"
	revision: "$Id: crypt_md5_constants.e,v 1.1 2001/06/30 20:50:41 farnaud Exp $"

class CRYPT_MD5_CONSTANTS

inherit
	CRYPT_BIT32_PRIVATE_ROUTINES

creation
	make

feature {NONE} -- Initialise

	make 
			-- Initialise constants.
		do
			hex_0 := hex ("0")
			hex_1 := hex ("1")
			hex_8 := hex ("8")
			hex_d76aa478 := hex ("d76aa478")
			hex_e8c7b756 := hex ("e8c7b756")
			hex_242070db := hex ("242070db")
			hex_c1bdceee := hex ("c1bdceee")
			hex_f57c0faf := hex ("f57c0faf")
			hex_4787c62a := hex ("4787c62a")
			hex_a8304613 := hex ("a8304613")
			hex_fd469501 := hex ("fd469501")
			hex_698098d8 := hex ("698098d8")
			hex_8b44f7af := hex ("8b44f7af")
			hex_ffff5bb1 := hex ("ffff5bb1")
			hex_895cd7be := hex ("895cd7be")
			hex_6b901122 := hex ("6b901122")
			hex_fd987193 := hex ("fd987193")
			hex_a679438e := hex ("a679438e")
			hex_49b40821 := hex ("49b40821")
			hex_f61e2562 := hex ("f61e2562")
			hex_c040b340 := hex ("c040b340")
			hex_265e5a51 := hex ("265e5a51")
			hex_e9b6c7aa := hex ("e9b6c7aa")
			hex_d62f105d := hex ("d62f105d")
			hex_2441453 := hex ("2441453")
			hex_d8a1e681 := hex ("d8a1e681")
			hex_e7d3fbc8 := hex ("e7d3fbc8")
			hex_21e1cde6 := hex ("21e1cde6")
			hex_c33707d6 := hex ("c33707d6")
			hex_f4d50d87 := hex ("f4d50d87")
			hex_455a14ed := hex ("455a14ed")
			hex_a9e3e905 := hex ("a9e3e905")
			hex_fcefa3f8 := hex ("fcefa3f8")
			hex_676f02d9 := hex ("676f02d9")
			hex_8d2a4c8a := hex ("8d2a4c8a")
			hex_fffa3942 := hex ("fffa3942")
			hex_8771f681 := hex ("8771f681")
			hex_6d9d6122 := hex ("6d9d6122")
			hex_fde5380c := hex ("fde5380c")
			hex_a4beea44 := hex ("a4beea44")
			hex_4bdecfa9 := hex ("4bdecfa9")
			hex_f6bb4b60 := hex ("f6bb4b60")
			hex_bebfbc70 := hex ("bebfbc70")
			hex_289b7ec6 := hex ("289b7ec6")
			hex_eaa127fa := hex ("eaa127fa")
			hex_d4ef3085 := hex ("d4ef3085")
			hex_4881d05 := hex ("4881d05")
			hex_d9d4d039 := hex ("d9d4d039")
			hex_e6db99e5 := hex ("e6db99e5")
			hex_1fa27cf8 := hex ("1fa27cf8")
			hex_c4ac5665 := hex ("c4ac5665")
			hex_f4292244 := hex ("f4292244")
			hex_432aff97 := hex ("432aff97")
			hex_ab9423a7 := hex ("ab9423a7")
			hex_fc93a039 := hex ("fc93a039")
			hex_655b59c3 := hex ("655b59c3")
			hex_8f0ccc92 := hex ("8f0ccc92")
			hex_ffeff47d := hex ("ffeff47d")
			hex_85845dd1 := hex ("85845dd1")
			hex_6fa87e4f := hex ("6fa87e4f")
			hex_fe2ce6e0 := hex ("fe2ce6e0")
			hex_a3014314 := hex ("a3014314")
			hex_4e0811a1 := hex ("4e0811a1")
			hex_f7537e82 := hex ("f7537e82")
			hex_bd3af235 := hex ("bd3af235")
			hex_2ad7d2bb := hex ("2ad7d2bb")
			hex_eb86d391 := hex ("eb86d391")
			hex_67452301 := hex ("67452301")
			hex_efcdab89 := hex ("efcdab89")
			hex_98badcfe := hex ("98badcfe")
			hex_10325476 := hex ("10325476")
		end

feature -- Constants

	hex_0: like crypt32
	hex_1: like crypt32
	hex_8: like crypt32
	hex_d76aa478: like crypt32
	hex_e8c7b756: like crypt32
	hex_242070db: like crypt32
	hex_c1bdceee: like crypt32
	hex_f57c0faf: like crypt32
	hex_4787c62a: like crypt32
	hex_a8304613: like crypt32
	hex_fd469501: like crypt32
	hex_698098d8: like crypt32
	hex_8b44f7af: like crypt32
	hex_ffff5bb1: like crypt32
	hex_895cd7be: like crypt32
	hex_6b901122: like crypt32
	hex_fd987193: like crypt32
	hex_a679438e: like crypt32
	hex_49b40821: like crypt32
	hex_f61e2562: like crypt32
	hex_c040b340: like crypt32
	hex_265e5a51: like crypt32
	hex_e9b6c7aa: like crypt32
	hex_d62f105d: like crypt32
	hex_2441453: like crypt32
	hex_d8a1e681: like crypt32
	hex_e7d3fbc8: like crypt32
	hex_21e1cde6: like crypt32
	hex_c33707d6: like crypt32
	hex_f4d50d87: like crypt32
	hex_455a14ed: like crypt32
	hex_a9e3e905: like crypt32
	hex_fcefa3f8: like crypt32
	hex_676f02d9: like crypt32
	hex_8d2a4c8a: like crypt32
	hex_fffa3942: like crypt32
	hex_8771f681: like crypt32
	hex_6d9d6122: like crypt32
	hex_fde5380c: like crypt32
	hex_a4beea44: like crypt32
	hex_4bdecfa9: like crypt32
	hex_f6bb4b60: like crypt32
	hex_bebfbc70: like crypt32
	hex_289b7ec6: like crypt32
	hex_eaa127fa: like crypt32
	hex_d4ef3085: like crypt32
	hex_4881d05: like crypt32
	hex_d9d4d039: like crypt32
	hex_e6db99e5: like crypt32
	hex_1fa27cf8: like crypt32
	hex_c4ac5665: like crypt32
	hex_f4292244: like crypt32
	hex_432aff97: like crypt32
	hex_ab9423a7: like crypt32
	hex_fc93a039: like crypt32
	hex_655b59c3: like crypt32
	hex_8f0ccc92: like crypt32
	hex_ffeff47d: like crypt32
	hex_85845dd1: like crypt32
	hex_6fa87e4f: like crypt32
	hex_fe2ce6e0: like crypt32
	hex_a3014314: like crypt32
	hex_4e0811a1: like crypt32
	hex_f7537e82: like crypt32
	hex_bd3af235: like crypt32
	hex_2ad7d2bb: like crypt32
	hex_eb86d391: like crypt32
	hex_67452301: like crypt32
	hex_efcdab89: like crypt32
	hex_98badcfe: like crypt32
	hex_10325476: like crypt32

end
