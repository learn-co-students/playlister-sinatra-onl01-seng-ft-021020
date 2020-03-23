require 'rack-flash'

class SongsController < ApplicationController
  set :views, Proc.new { File.join(root, "../views/songs/") }
  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :index
  end

  post '/songs' do
    @song = Song.create(name: params[:name])
    @song.artist = Artist.find_or_create_by(name: params[:artist])
    @song.genre_ids = params[:genres]
    @song.save

    flash[:message] = 'Succesfully created song.'
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/new' do
    erb :new
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug]).first
    erb :show
  end
end
