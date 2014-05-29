class ReviewsController < ApplicationController
  def new
     @review = Review.new
     #@boards = Board.all
  end
  
  def create
     @review = Review.new(review_params)
     @review.rating = params[:score]
     if @review.save
       flash[:success] = "Review Saved"  
       redirect_to root_path
     else
       render 'new'
     end
  end
  
  private
    def review_params
      params.require(:review).permit(:title, :pros, :cons, :board_id)
    end
  
end
