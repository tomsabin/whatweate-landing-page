require 'sinatra'
require 'sass'

get '/' do
  @events = Meetup.events_with_photos
  erb :index, layout: :'layouts/application'
end
