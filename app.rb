require 'sinatra'
require 'sass'

get '/' do
  @events = Meetup.events_with_photos
  erb :index, layout: :'layouts/application'
end

not_found do
  erb :not_found, layout: :'layouts/application'
end

error do
  erb :error, layout: :'layouts/application'
end
