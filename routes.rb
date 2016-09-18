require 'sinatra'
require 'json'

set :port, 1337

get '/' do
  File.read('index.html')
end

post '/report' do
  content_type :json

  { :name => params['name'],
    :age => params['age'],
    :ethnicity => params['ethnicity']}.to_json
end

