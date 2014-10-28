require 'bundler'
Bundler.require(:default)
require 'sass/plugin/rack'

require 'dotenv'
Dotenv.load

require './meetup'
require './app'

Sass::Plugin.options[:style] = :compressed
Sass::Plugin.options[:sourcemap] = :none
use Sass::Plugin::Rack

run Sinatra::Application
