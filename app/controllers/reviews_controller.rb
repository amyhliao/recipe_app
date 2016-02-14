class ReviewsController < ApplicationController
  def new
    if current_user != nil
      @parent = parent_object
      @parent_name = @parent.class.name.downcase.pluralize
      @response = Review.new
      if request.xhr?
        render 'reviews/_review_form.html.erb', locals: {parent: @parent, review: @review}, layout: false
      else
        render 'reviews/new.html.erb'
      end
    else
      redirect_to login_path
    end
  end

end