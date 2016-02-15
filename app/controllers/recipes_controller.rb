class RecipesController < ApplicationController
  def index
  end

  def new
    if logged_in?
      @recipe = Recipe.new
      @category = Category.new
    else
      redirect_to login_path
    end
  end

  def create
    if logged_in?
      @recipe = Recipe.new(params[:recipe].permit(:title, :content))
      @recipe.asker_id = current_user.id
      @category = Category.new
      if @recipe.save
        if category_params != nil
          Category.make_categories(category_params[:name], @recipe)
        end
        redirect_to recipe_path(@recipe)
      else
        flash.now[:alert] = @recipe.errors.full_messages.join(", ")
        render :new
      end
    else
      redirect_to root_path
    end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.update_attributes(view_count: (@recipe.view_count + 1))
    @review = Review.new
    @vote = Vote.new
  end

  private

  def category_params
    params.require(:recipe).require(:category).permit(:name)
  end
end
