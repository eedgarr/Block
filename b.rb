 require 'sinatra'
 


get '/blockchain' do
   '<h1>you mine a block<h1>'
end

get 'edgar' do
   '<h1> Edgar is a professional trader and a blockchain enthusiast.<h1>'
end

max { |a, b|  }