require 'rubygems'
require 'bundler'
require 'themoviedb'
require 'pp'

Bundler.require

# Sinatra Configuration
set :port, 4567
set :logging, true

set :environment, :development


# TMDB Configuration
tmdb_api_key_file = File.open(File.join(File.dirname(__FILE__), "config/tmdb_api_key"), mode = "r")
Tmdb::Api.key(tmdb_api_key_file.readline)

Tmdb::Api.language("en")


#Pages

get '/' do

  @now_playing = Tmdb::Movie.now_playing

	haml :home, :locals => {:now_playing => @now_playing}
end

get '/movie/:movie_id' do |movie_id|

  movie = Tmdb::Movie.detail(movie_id)

end

get '/person/:person_id' do |person_id|

  person = Tmdb::Person.detail(person_id)

end

get '/movies' do

  @popular_movies = Tmdb::Movie.popular

  haml :movies, :locals => {:popular_movies => @popular_movies}
end

get '/people' do

  @popular_people = Tmdb::Person.popular

  haml :people, :locals => {:popular_people => @popular_people}
end

post '/search' do

	search_string = params[:search_string]

	# Search movies and people
  @movies = Tmdb::Movie.find(search_string)
  @people = Tmdb::Person.find(search_string)

	haml :search, :locals => {:movies => @movies, :people => @people}
end