
require 'rack-flash'
class SongController < ApplicationController

use Rack::Session::Cookie
use Rack::Flash
enable :sessions
  get '/songs/new' do
    erb :'songs/new'
  end
  get '/songs/:slug/edit' do
    @song=Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end
  get '/songs/:slug' do
    @song=Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end
  get '/songs' do
    @songs=Song.all
    erb :'songs/songs'
  end
  post '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.save
    flash[:message] = "Successfully updated song."
    binding.pry
    erb :'songs/show'
  end
  post '/songs' do
    @song = Song.create(:name => params["Name"])
     @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])
     @song.genre_ids = params[:genres]
     @song.save
     flash[:message] = "Successfully created song."
     redirect("/songs/#{@song.slug}")
  end

end
