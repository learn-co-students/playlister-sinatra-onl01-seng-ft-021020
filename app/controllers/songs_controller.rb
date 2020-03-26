
class SongsController < ApplicationController
    get '/songs' do
        @songs = Song.all
        erb :"/songs/index"
    end
    
    get '/songs/new' do
        @genres = Genre.all
        erb :"/songs/new"
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :"/songs/show"
    end

    post '/songs' do
        @song = Song.new(name: params[:name])
        @artist = Artist.find_or_create_by(name: params[:artist])
        @genres = params[:genres].collect{|id| Genre.find_by_id(id)}
        @song.artist = @artist
        @genres.each do |g|
            @song.genres << g
        end
        @song.save
        session[:message] = "Create"
        redirect "/songs/#{@song.slug}"
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        erb :"/songs/edit"
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @artist = Artist.find_or_create_by(name: params[:artist])
        @genres = params[:genres].collect{|id| Genre.find_by_id(id)}
        @song.name = params[:name]
        @song.artist = @artist
        @song.genres.clear
        @genres.each do |g|
            @song.genres << g
        end
        @song.save
        session[:message] = "Edit"
        redirect "/songs/#{@song.slug}"
    end
end