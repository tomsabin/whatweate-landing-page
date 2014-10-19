require 'sinatra'
require 'sass'

get '/' do
  erb :index, layout: :'layouts/application'
end
