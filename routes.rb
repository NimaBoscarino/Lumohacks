require 'sinatra'
require 'json'

set :port, 1337

get '/' do
  File.read('index.html')
end

post '/report' do
  content_type :json
  request.body.rewind
  request_payload = JSON.parse request.body.read

  #a = `Rscript helloworld.r`
  { :name => request_payload['name'],
    :age => request_payload['age'],
    :ethnicity => request_payload['ethnicity']}.to_json
end

post '/upload' do
  File.open('uploads/' + params['myfile'][:filename], "w") do |f|
        f.write(params['myfile'][:tempfile].read)
          end
    return "The file was successfully uploaded!"
end

