require 'sinatra'
require './block'
require 'json'

b = BlockChain.new

get '/' do
	message = ""
  	b.current_chain.each do |c|
  	message << "<hr>"
  	message << "블록 번호는 " + c['index'].to_s + "번 입니다.<br>"
  	message << "Nonce는 " + c['nonce'].to_s + " 입니다.<br>"
  	message << "시간은 " + c['time'].to_s + " 입니다.<br>"
  	message << "앞 주소는 " + c['previous_block'].to_s + " 입니다.<br>"
  	message << "나의 주소는 " + Digest::SHA256.hexdigest(c.to_s) + " 입니다.<br>"
  	message << "거래 내역 " + c['transaction'].to_s + "<br>"
	message << "<hr>"
	end
	message
end

get '/mine' do
	b.mining
   "Mined!!"
end

get '/transaction' do
	b.trans(params["sender"], params["receiver"], params["amount"])
end	

get '/new_wallet' do
	b.make_a_wallet.to_s
end

get '/all_wallet' do
	b.show_all_wallet.to_s
end

get '/total_blocks' do
	b.current_chain.size.to_s
end

get '/other_blocks' do
	b.get_other_blocks.to_s
end

get '/register' do
	b.add_node(params["node"])
end

get '/my_nodes' do
	b.total_nodes.to_s
end

get '/get_blocks' do
  new_blocks = JSON.parse(params["blocks"])
  b.add_new_blocks(new_blocks)
  puts b.current_chain.to_json
  b.current_chain.to_json
end
