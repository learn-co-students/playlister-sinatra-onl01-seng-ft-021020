
class SongsController < ApplicationController 
    
    get '/songs' do 
        
        @song = Song.all 
        erb :'/songs/index'
    end 

    get '/songs/new' do 
        erb :"/songs/new"
    end 

    get '/songs/:slug' do 
        
        slug = params[:slug]
        @song = Song.find_by_slug(slug)
        erb :"/songs/show"
    end 

    post '/songs' do 
        
        @song = Song.create(name: params[:Name])
        @song.artist = Artist.find_or_create_by(name: params["Artist Name"])
        
        @song.genre_ids= params[:genres]
        @song.save
        
       
        flash[:message] = "Successfully created song."
       
        redirect "/songs/#{@song.slug}"
    end 
    

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :"/songs/edit"
        # binding.pry
    end

    patch '/songs/:slug' do 
        
        @song = Song.find_by_slug(params[:slug])

        if !params["Artist Name"].empty?
            @song.artist = Artist.find_or_create_by(name: params["Artist Name"])
        end
       
        
      
        #cant use find_by cause it only returns one 
        @genres = Genre.find(params[:genres])
    
        @song.song_genres.clear
        @genres.each do |genre|
          song_genre = SongGenre.new(song: @song, genre: genre)
          song_genre.save
        end
    
        @song.save

        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"

    end
end 