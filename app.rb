require 'rubygems'
require 'sinatra'
# require 'aws/s3'

# include AWS::S3
    
set :views, File.join(File.dirname(__FILE__),'views')

# AWS::S3::Base.establish_connection!(
#   :access_key_id      => ENV['AMAZON_ACCESS_KEY_ID'],
#   :secret_access_key  => ENV['AMAZON_SECRET_ACCESS_KEY']
# )
# BASEURL = 'http://s3.amazonaws.com/'
# BUCKET = 'rhodes-app-logs'

post '/client_log' do
  name = params[:log_name] ? params[:log_name] + '_' : 'R'
  name += Time.now.getlocal.strftime('%d_%b_%Y_%H_%M') + "\n"
  
  open('log.out', 'a') do |f|
    f << name
    f << "~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ \n"
    f << params[:blob][:tempfile].read if params[:blob]
  end
end

get '/' do
  file = File.open("log.out", "r")
  @contents = file.read
  
  erb :index
end

get '/delete' do
  open('log.out', 'w') do |f|
  end
  redirect "/"
end