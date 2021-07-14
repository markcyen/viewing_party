class MoviesController < ApplicationController
  def index
    @user = current_user

    if !params[:search].present?
      @top_40 = MovieFacade.list_top_40
    else
      @search_movie = MovieFacade.search_for_movies(params[:search])
    end
  end

  def show
    @user = current_user
    @movie = MovieFacade.get_movie_details(params[:movie_id])
  end
end
