note
	description: "Portable hex<>int routines (yet another)"
	project: "http://www.nenie.org/eiffel/"
	license: "http://www.opensource.org/licenses/mit-license.html"
	revision: "$Id: crypt_hex_private_routines.e,v 1.2 2002/12/22 02:01:07 farnaud Exp $"
	exportable: hex_to_int, int_to_hex

class CRYPT_HEX_PRIVATE_ROUTINES

feature {NONE} -- Hexadecimal

	hex_to_int (a_char: CHARACTER): INTEGER
			-- Portable hex char to int.
		require
			hex: ("0123456789abcdefABCDEF").has (a_char)
		do
			inspect a_char
			when '0' then Result := 0
			when '1' then Result := 1
			when '2' then Result := 2
			when '3' then Result := 3
			when '4' then Result := 4
			when '5' then Result := 5
			when '6' then Result := 6
			when '7' then Result := 7
			when '8' then Result := 8
			when '9' then Result := 9
			when 'a','A' then Result := 10
			when 'b','B' then Result := 11
			when 'c','C' then Result := 12
			when 'd','D' then Result := 13
			when 'e','E' then Result := 14
			when 'f','F' then Result := 15
			end
		ensure
			in_range: Result >= 0 and Result < 16
		end

	int_to_hex (an_int: INTEGER): CHARACTER 
			-- Portable hex digit.
		require
			in_range: an_int >= 0 and an_int < 16
		do
			inspect an_int
			when 0 then Result := '0'
			when 1 then Result := '1'
			when 2 then Result := '2'
			when 3 then Result := '3'
			when 4 then Result := '4'
			when 5 then Result := '5'
			when 6 then Result := '6'
			when 7 then Result := '7'
			when 8 then Result := '8'
			when 9 then Result := '9'
			when 10 then Result := 'a'
			when 11 then Result := 'b'
			when 12 then Result := 'c'
			when 13 then Result := 'd'
			when 14 then Result := 'e'
			when 15 then Result := 'f'
			end
		ensure
			reverse: hex_to_int (Result) = an_int
		end

end
