require 'sinatra'
require './block'

b = BlockChain.new

get '/' do
  b.current_chain.to_s
end

get '/mine' do
	b.mining
   "Mined"
end