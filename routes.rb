require 'sinatra'
require 'json'

set :port, 1337

get '/' do
  File.read('index.html')
end

post '/report' do
  content_type :json
  a = `ls`
  { :key1 => a }.to_json
end
