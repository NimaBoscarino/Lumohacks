require 'sinatra'
require 'CSV'

set :port, 8080
set :static, true
set :public_folder, "static"

get '/' do
    erb :index
end

get '/hello/' do
    erb :hello_form
end

post '/upload' do
  if params[:tsv_file] && params[:tsv_file][:filename]
    # Write file to disk
    File.open('uploads/' + params[:tsv_file][:filename], "wb") do |f|
      f.write(params[:tsv_file][:tempfile].read)
    end
      
    #result = `Rscript jamesscript.r #{params[:tsv_file][:filename]}`
    `Rscript jamesScript.r uploads/#{params[:tsv_file][:filename].to_s}`
    results = CSV.read("output.csv")
    p params[:name]
    erb :report, :locals => {:name => params[:name], :results => results}
  end
end