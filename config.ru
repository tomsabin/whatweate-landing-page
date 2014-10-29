require 'bundler'
Bundler.require(:default)
require 'sass/plugin/rack'

begin
  require 'dotenv'
rescue LoadError
end
Dotenv.load if defined? Dotenv

require './meetup'
require './app'

Sass::Plugin.options[:style] = :compressed
Sass::Plugin.options[:sourcemap] = :none
use Sass::Plugin::Rack

run Sinatra::Application
