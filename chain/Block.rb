require 'digest'

class BlockChain
	def initialize
		@number_of_blocks = 1
	end

	def mining
		@number_of_blocks = @number_of_blocks + 1
		history = []
		begin
			nonce = rand(10000000)
			hashed = Digest::SHA256.hexdigest(nonce.to_s)
			history << nonce
		end while hashed[0..4] != '00000'
		history
	end

	def my_blocks
		@number_of_blocks
	end
end


