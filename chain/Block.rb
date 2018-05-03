require 'securerandom'
require 'digest'
require 'httparty'
require 'json'

class BlockChain

	def initialize
		@number_of_blocks = 1
		@chain = []
		@transaction =[]
		@wallet = {}
		@node = []
	end

	def make_a_wallet
		new_wallet_address = SecureRandom.uuid
		@wallet[new_wallet_address] = 1000
		@wallet
	end

	def trans(s, r, a) #줄임말
		if @wallet[s].nil?
			"없는 지갑입니다."
		elsif @wallet[r].nil?
			"없는 지갑입니다."
		elsif @wallet[s].to_f < a.to_f
			"잔액이 부족합니다."
		else

		t = {
			"sender" => s,
			"receiver" => r,
			"amount" => a
		}
		@wallet[r] = @wallet[r] + a.to_f
		@wallet[s] = @wallet[s] - a.to_f
		@transaction << t
		"거래가 완료되었습니다."
		end
	end

	def show_all_wallet
		@wallet
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

	def get_other_blocks
		@node.each do |n|
			other_blocks = HTTParty.get("http://localhost:" + n.to_s + "/total_blocks").body
			if @chain.size < other_blocks.to_i
				HTTParty.get("http://localhost:" + n.to_s + "/get_blocks?blocks=" + @chain.to_json)
			end
		end
	end

	def add_node(node)
		@node << node
		node
	end

	def total_nodes
		@node
	end
end


