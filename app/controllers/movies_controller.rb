class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if !session.has_key?(:ratings)
	  session[:ratings]=Movie.get_all_rating
    end
    #if this was reached through refresh, params[:ratings] will be a hash whose keys wil be PG,R etc
    if params.has_key?(:ratings) and  params[:ratings].keys.length > 0
	  session[:ratings]=params[:ratings].keys
    end
    @movies = Movie.all
    if params.has_key?(:sort_by)
    session[:sort_by]=params[:sort_by]
    end
	  if session.has_key?(:sort_by)
	     @movies=@movies.order(session[:sort_by].to_s)
	     [Movie,'hilite']
	     if session[:sort_by]=='title'
	       @color='t';
	     end
	     if session[:sort_by]=='release_date'
	       @color='r'
	     end
	  end
	  @movies=@movies.where(rating: session[:ratings])
    @all_ratings=Movie.get_all_rating
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
