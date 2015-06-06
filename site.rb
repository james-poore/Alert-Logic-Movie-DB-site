require 'rubygems'
require 'bundler'
require 'ruby-tmdb3'

Bundler.require

# Sinatra Configuration
set :port, 4567
set :logging, true

set :environment, :development


# TMDB Configuration

#Try to read API key from file, if file not present produce error and set key to nil
begin
	tmdb_api_key_file = File.open("config/tmdb_api_key", mode = "r")
	Tmdb.api_key = tmdb_api_key_file.readline
rescue
	raise IOError, "The API key file could not be opened. Check that the file exists and the first line is the API key."
	Tmdb.api_key = nil
end

Tmdb.default_language = "en"


#Pages

get '/' do

	haml :home
end

get '/movie/:movie_title' do |movie_title|


end

get '/person/:person_name' do |person_name|


end