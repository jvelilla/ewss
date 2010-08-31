note
	description: "Duplicate input to two output streams (like unix 'tee')"

class CRYPT_STREAM_DUPLICATE

inherit
	CRYPT_STREAM_FILTER

create
	make

feature {NONE} -- Creation

	make (a: CRYPT_BYTE_CONSUMER; a_other: CRYPT_BYTE_CONSUMER)
			-- Send input to both 'a' and 'a_other'.
		require
			a_not_void: a /= Void
			other_not_void: a_other /= Void
		do
			set_next (a)
			other := a_other
		end

feature -- Input

	init
		do
			next.init
			other.init
		end

	update_byte (a: INTEGER)
		do
			next.update_byte (a)
			other.update_byte (a)
		end

	final 
		do
			next.final
			other.final
		end

feature {NONE} -- Attribute(s)

	other: CRYPT_BYTE_CONSUMER

invariant
	next: is_valid_next
	other: other /= Void

end
