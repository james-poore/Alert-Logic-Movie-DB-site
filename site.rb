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

configuration = Tmdb::Configuration.new


#Pages

get '/' do

  @now_playing = Tmdb::Movie.now_playing

	haml :home, :locals => {:now_playing => @now_playing}
end



get '/movie/:movie_id' do |movie_id|

  movie = Tmdb::Movie.detail(movie_id)
  cast = Tmdb::Movie.casts(movie_id)
  similar_movies = Tmdb::Movie.similar_movies(movie_id)
  trailers = Tmdb::Movie.trailers(movie_id)
  images = Tmdb::Movie.images(movie_id)['backdrops']

  haml :movie_info, :locals => {:movie => movie,
                                :cast => cast,
                                :similar_movies => similar_movies,
                                :trailers => trailers,
                                :images => images}
end



get '/tv/:show_id' do |show_id|

  show = Tmdb::TV.detail(show_id)
  cast = Tmdb::TV.casts(show_id)
  # trailers = Tmdb::TV.trailers(show_id)
  images = Tmdb::TV.images(show_id)['backdrops']

  haml :show_info, :locals => {:show => show,
                               :cast => cast,
                               # :trailers => trailers,
                               :images => images}
end



get '/person/:person_id' do |person_id|

  person = Tmdb::Person.detail(person_id)
  credits = Tmdb::Person.credits(person_id)

  haml :person_info, :locals => {:person => person, :credits => credits}
end



get '/movies' do

  @popular_movies = Tmdb::Movie.popular

  haml :movies, :locals => {:popular_movies => @popular_movies}
end

get '/tv' do

  @popular_movies = Tmdb::TV.popular

  haml :shows, :locals => {:popular_shows => @popular_shows}
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
  @shows = Tmdb::TV.find(search_string)

	haml :search_results, :locals => {:movies => @movies, :people => @people, :shows => @shows}
end