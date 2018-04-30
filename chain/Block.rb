require 'securerandom'
require 'digest'

class BlockChain

	def initialize
		@number_of_blocks = 1
		@chain = []
		@transaction =[]
		@wallet = {}
	end

	def make_a_wallet
		new_wallet_address = SecureRandom.uuid
		@wallet[new_wallet_address] = 1000
		@wallet
	end

	def trans(s, r, a) #줄임말
		t = {
			"sender" => s,
			"receiver" => r,
			"amount" => a
		}
		@transaction << t
	end


	def mining
		@number_of_blocks = @number_of_blocks + 1
		history = []
		begin
			nonce = rand(10000000)
			hashed = Digest::SHA256.hexdigest(nonce.to_s)
			history << nonce
		end while hashed[0..3] != '0000'

		block = {
			'index' => @chain.length + 1,
			'time' => Time.now,
			'nonce' => nonce,
			'previous_block' => Digest::SHA256.hexdigest(last_block.to_s),
			"transaction" => @transaction
		} 
		@transaction = []
		@chain << block
	end


	def current_chain
		@chain
	end

	def my_blocks
		@number_of_blocks
	end

	def last_block
		@chain[-1]
	end
end
