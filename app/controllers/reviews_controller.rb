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

end