class SearchesController < ApplicationController

  def create
    
    @search = UserSearch.new(params[:user_search][:criteria])

    if @search.valid?
      @search = @search.results_for()
      @search_completed = true
    end
    
    render 'show'
  end

  def show
  end

end