class ReviewsController < ApplicationController
  def new
    if current_user != nil
      @parent = parent_object
      @parent_name = @parent.class.name.downcase.pluralize
      @review = Review.new
      if request.xhr?
        render 'reviews/_review_form.html.erb', locals: {parent: @parent, review: @review}, layout: false
      else
        render 'reviews/new.html.erb'
      end
    else
      redirect_to login_path
    end
  end

  def create
    @parent = parent_object
    @review = @parent.reviews.build(responder_id: current_user.id, content: params[:review][:content])
    if @review.save
      if request.xhr?
        render 'reviews/_review.html.erb', locals: {review: @review}, layout: false
      else
        redirect_to parent_url(@parent)
      end
    else
      flash.now[:alert] = "Review must have content."
      render :new
    end
  end

  # def create
  #   @review = Review.new(params[:review].permit(:content))
  #   @review.recipe = Recipe.find(params[:recipe_id])
  #   @review.reviewer = current_user
  #   if @review.save
  #     if request.xhr?
  #       render 'reviews/_review.html.erb', locals: {review: @review}, layout: false
  #     else
  #       redirect_to recipe_path(@review.recipe)
  #     end
  #   else
  #     @recipe = Recipe.find(params[:recipe_id])
  #     @errors = @review.errors.full_messages
  #     render 'recipes/show.html.erb'
  #   end
  # end

  private

  def parent_object
    case
      when params[:recipe_id] then Recipe.find(params[:recipe_id])
      when params[:answer_id] then Answer.find(params[:answer_id])
    end
  end

  def parent_url(parent)
    case
      when params[:recipe_id] then recipe_path(parent)
      when params[:answer_id] then recipe_path(parent.recipe_id)
    end
  end
end