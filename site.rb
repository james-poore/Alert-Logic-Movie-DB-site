require 'rubygems'
require 'bundler'

Bundler.require

# Sinatra Configuration
set :port, 4567
set :logging, true

set :environment, :development

get '/' do

	haml :home

end