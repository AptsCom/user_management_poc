class SearchesController < ApplicationController

before_filter :scope_search

def create
  @results = @search.valid? && @search.results_for()
  params[:user_search].each {|key, value| instance_variable_set("@#{key}",value) }

  render 'show'
end

def show
end

private

def scope_search
  criteria = params[:user_search] || {}
  @search = UserSearch.new(criteria)
end  


end