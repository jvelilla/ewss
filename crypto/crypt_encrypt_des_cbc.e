
indexing
	description: "Encrypt using DES CBC (Cipher Block Chaining)"
	
class CRYPT_ENCRYPT_DES_CBC
	
inherit
	CRYPT_STREAM_CIPHER_FILTER
	
creation
	make
	
feature {NONE} -- Creation

	make_cipher is
			-- Make cipher.
		do
			create {CRYPT_DES} cipher.make
		end
		
feature -- Stream

	init is
			-- Initialise with initialisation.
		local
			random: CRYPT_STD_RANDOM
		do
			init_blocks
			next.init
			
			-- initialisation vector 
			create random.make
			random.make_random (key_size)		
			last_block.copy_bytes (random.last_bytes)
			next.update_bytes (last_block)			
		end
		
		
	update_byte (a_byte: INTEGER) is
			-- Incoming byte.
		do
			incoming_block.put (a_byte, incoming_next)
			incoming_next := incoming_next + 1
			if incoming_next > incoming_block.count then
				update_chain
				incoming_next := 1
			end
		end
		
	final is
		do
			if incoming_next /= 1 then
				-- Pad
				from
				until incoming_next > incoming_block.count loop
					incoming_block.put (0, incoming_next)
					incoming_next := incoming_next + 1
				end
				incoming_next := 1
				
				-- last block
				update_chain
			end		
			
			-- done
			next.final
		end
		
feature {NONE} -- State

	last_block: CRYPT_DES_BLOCK
			-- Chaining.
	incoming_block: CRYPT_DES_BLOCK
			-- Incoming buffer.
	incoming_next: INTEGER
			-- Free position in incoming buffer.
			
feature {NONE} -- Impl

	update_chain is
			-- Update chain.
			-- Encrypted := DES-encrypt (Previous XOR Incoming)
		do
			incoming_block.xor_all (last_block)
			cipher.encrypt (incoming_block)
			next.update_bytes (cipher.last)
			last_block.copy_bytes (cipher.last)
		end
		
	init_blocks is
			-- Initialise incoming, last block and
			-- position.
		do
			incoming_block := new_block
			incoming_next := 1
			last_block := new_block
		end
	
	new_block: CRYPT_DES_BLOCK is
			-- New DES block.
		do	
			create Result
		end
	
invariant
	incoming_next: incoming_next > 0 implies incoming_next <= incoming_block.count
	
end
