require 'digest'

class BlockChain

	def initialize
		@chain = []
	end

	def mining
		begin
			nonce = rand(100)
		end while nonce != 0

		block = {
			'index' => @chain.length + 1,
			'time' => Time.now,
			'nonce' => nonce,
			'previous_block' => Digest::SHA256.hexdigest(last_block.to_s)	
		} 
		@chain << block
	end

	def current_chain
		@chain
	end

	def last_block
		@chain[-1]
	end
end


