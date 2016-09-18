require 'sinatra'
require 'json'

set :port, 1337

get '/' do
  File.read('index.html')
end

post '/report' do
  params.to_s
end

