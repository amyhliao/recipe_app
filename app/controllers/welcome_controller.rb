class WelcomeController < ApplicationController
  def index
    if params[:order_by] == 'votes'
      @recipes = Recipe.sort_by_votes
    elsif params[:order_by] == 'trendiness'
      @recipes = Recipe.sort_by_trendiness
    elsif params[:order_by] == 'recentness'
      @recipes = Recipe.sort_by_recentness
    else
      @recipes = Recipe.all
    end
    if request.xhr?
      if params[:order_by] == 'votes'
        @recipes = Recipe.sort_by_votes
      elsif params[:order_by] == 'trendiness'
        @recipes = Recipe.sort_by_trendiness
      elsif params[:order_by] == 'recentness'
        @recipes = Recipe.sort_by_recentness
      else
        @recipes = Recipe.all
      end
      render '/welcome/_recipes_list.html.erb', locals: {recipes: @recipes}, layout: false
    else
      render '/welcome/index.html.erb'
    end
  end

  def search
    search_terms = params[:terms].downcase.split(" ")
    @matches = []
    search_terms.each do |term|
      @matches += Recipe.all.select { |recipe| recipe.title.downcase.include?(term) }
    end
    @matches = @matches.uniq
    render 'search'
  end
end