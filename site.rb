require 'rubygems'
require 'bundler'
require 'ruby-tmdb3'
require 'pp'

Bundler.require

# Sinatra Configuration
set :port, 4567
set :logging, true

set :environment, :development


# TMDB Configuration
tmdb_api_key_file = File.open(File.join(File.dirname(__FILE__), "config/tmdb_api_key"), mode = "r")
Tmdb.api_key = tmdb_api_key_file.readline

Tmdb.default_language = "en"


#Pages

get '/' do

	haml :home
end

get '/movie/:movie_id' do |movie_id|


end

get '/person/:person_id' do |person_id|


end

post '/search' do

	search_string = params[:search_string]

	#Seearch movies and people
	@movies = TmdbMovie.find(:title => search_string, :expand_results => true)
	@people = TmdbCast.find(:name => search_string, :expand_results => true)

	pp @movies
	puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	pp @people


	haml :search
end