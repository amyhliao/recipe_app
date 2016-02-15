class IngredientsController < ApplicationController
  def new
    if logged_in?
      @recipe = Recipe.new
      @category = Category.new
    else
      redirect_to login_path
    end
  end


end