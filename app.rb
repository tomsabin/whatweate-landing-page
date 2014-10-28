require 'sinatra'
require 'sass'

get '/' do
  @events = Meetup.events
  erb :index, layout: :'layouts/application'
end
