require 'sinatra'
require 'json'

set :port, 1337

get '/' do
  File.read('index.html')
end

post '/report' do
  content_type :json
  #a = `Rscript helloworld.r`
  { :message => "sup kayla" }.to_json
end

post '/upload' do
  File.open('uploads/' + params['myfile'][:filename], "w") do |f|
        f.write(params['myfile'][:tempfile].read)
          end
    return "The file was successfully uploaded!"
end

