require 'sinatra'
require './block'

b = BlockChain.new

get '/' do
   "Total number of blocks : " + b.my_blocks.to_s
end

get '/mine' do
   b.mining.to_s
end