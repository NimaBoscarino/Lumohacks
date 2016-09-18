require 'sinatra'

set: port, 1337

get '/' do
  File.read('index.html')
end
