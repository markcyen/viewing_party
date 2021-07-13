class MoviesController < ApplicationController
  def index
    @user = current_user

    if !params[:search].present?
      @top_40 = MovieFacade.list_top_40
    else
      @search_movie = MovieFacade.search_for_movies(params[:search])
    end
  end
end
