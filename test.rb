require 'sinatra'

set :port, 9494

get '/' do
File.read('index.html')
end

get '/frank-says' do
'Pdasdasdut this in your pipe & smoke it!'
end
