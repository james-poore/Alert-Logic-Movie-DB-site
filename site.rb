require 'rubygems'
require 'bundler'
require 'ruby-tmdb3'
require 'themoviedb'
require 'pp'

Bundler.require

# Sinatra Configuration
set :port, 4567
set :logging, true

set :environment, :development


# TMDB Configuration
tmdb_api_key_file = File.open(File.join(File.dirname(__FILE__), "config/tmdb_api_key"), mode = "r")
Tmdb::API.key(tmdb_api_key_file.readline)

Tmdb::API.language("en")


#Pages

get '/' do

  @now_playing = Tmdb::Movie.now_playing

	haml :home, :locals => {:now_playing => @now_playing}
end

get '/movie/:movie_id' do |movie_id|


end

get '/person/:person_id' do |person_id|


end

post '/search' do

	search_string = params[:search_string]

	# Search movies and people
  @movies = Tmdb::Movie.find(search_string)
  @people = Tmdb::Person.find(search_string)

	@movies.each do |movie|
		puts movie.title
    pp movie
		puts "-----------------------------"
	end
	puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	@people.each do |person|
		puts person.name
    pp person
		puts "-----------------------------"
  end


	haml :search, :locals => {:movies => @movies, :people => @people}
end