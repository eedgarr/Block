require 'sinatra'
require './block'

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
  	message << "거래 " + c['transaction'].to_s + "<br>"
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
	"거래가 완료되었습니다."
end	

get '/new_wallet' do
	b.make_a_wallet.to_s
end
