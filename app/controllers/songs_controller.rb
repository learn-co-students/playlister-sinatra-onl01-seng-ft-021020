class SongsController < ApplicationController
  set :views, Proc.new { File.join(root, "../views/songs/") }

  get '/songs' do
    @songs = Song.all
    erb :index
  end

  patch '/songs' do
    @song = Song.find(params[:song_id])
    @song.artist = Artist.find_or_create_by(name: params[:artist])
    @song.genre_ids = params[:genres]
    @song.save

    flash[:message] = 'Successfully updated song.'
    redirect to "/songs/#{@song.slug}"
  end

  post '/songs' do
    @song = Song.create(name: params[:name])
    @song.artist = Artist.find_or_create_by(name: params[:artist])
    @song.genre_ids = params[:genres]
    @song.save

    flash[:message] = 'Successfully created song.'
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/new' do
    erb :new
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :show
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = @song.genres.map{ |genre| genre.id }
    erb :edit
  end
end
