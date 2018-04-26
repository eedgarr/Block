
class BlockChain
	def initialize
		@number_of_blocks = 1
	end

	def mining
		@number_of_blocks = @number_of_blocks + 1
		history = []
		begin
			nonce = rand(1000)
			history << nonce
		end while nonce != 0
		history
	end

	def my_blocks
		@number_of_blocks
	end
end


