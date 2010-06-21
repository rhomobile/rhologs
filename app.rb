require 'rubygems'
require 'sinatra'
require 'aws/s3'

include AWS::S3
    
set :views, File.join(File.dirname(__FILE__),'views')

AWS::S3::Base.establish_connection!(
  :access_key_id      => ENV['AMAZON_ACCESS_KEY_ID'],
  :secret_access_key  => ENV['AMAZON_SECRET_ACCESS_KEY']
)
BASEURL = 'http://s3.amazonaws.com/'
BUCKET = 'rhodes-app-logs'

post '/client_log' do
  name = params[:log_name] ? params[:log_name] + '_' : 'R'
  name += Time.now.getlocal.strftime('%d_%b_%Y_%H_%M') + '.txt'
  
  S3Object.store(
    name,
    params[:blob][:tempfile].read,
    BUCKET,
    :access => :public_read
  ) if params[:blob]
end

get '/' do
  @items = []
  Bucket.find(BUCKET).objects.each do |entry|
    @items << BASEURL+BUCKET+'/'+File.basename(entry.key)
  end
  erb :index
end

get '/delete' do
  S3Object.delete File.basename(params[:file]), BUCKET
  redirect '/'
end