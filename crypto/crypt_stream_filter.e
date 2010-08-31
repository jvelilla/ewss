note
	description: "Filter for byte stream"
	project: "http://www.nenie.org/eiffel/"
	license: "http://www.opensource.org/licenses/mit-license.html"
	revision: "$Id: crypt_stream_filter.e,v 1.1 2001/12/23 01:40:15 farnaud Exp $"

deferred class CRYPT_STREAM_FILTER

inherit
	CRYPT_BYTE_CONSUMER

feature -- Filter

	next: CRYPT_BYTE_CONSUMER

	set_next (a: CRYPT_BYTE_CONSUMER) 
		do
			next := a
		end

	is_valid_next: BOOLEAN
			-- Is 'next' ready for use?
		do
			Result := next /= Void
		end

end
