class SearchController < ApplicationController
  def index
    @results = Post.search(params[:query])
  end
end
