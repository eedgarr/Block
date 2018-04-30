require 'sinatra'
require './block'

b = BlockChain.new

get '/' do
	message = ""
  	b.current_chain.each do |c|
  	message << "<hr>"
  	message << "블록 번호는 " + c['index'].to_s + "번 입니다.<br>"
  	message << "Nonce는 " + c['nonce'].to_s + "입니다.<br>"
  	message << "시간은 " + c['time'].to_s + " 입니다.<br>"
  	message << "앞 주소는 " + c['previous_block'].to_s + " 입니다.<br>"
  	message << "나의 주소는 " + Digest::SHA256.hexdigest(c.to_s) + " 입니다.<br>"
	message << "<hr>"
	end
	message
end

get '/mine' do
	b.mining
   "Mined!!"
end

get '/transaction' do
	"보내는 사람:" + params["sender"] + "받는 사람:" + params["receiver"]
end	