require 'sinatra'
require 'sass'

get '/' do
  erb :index, layout: :application
end
