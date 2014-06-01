class ReviewsController < ApplicationController
 
  def index
    @board = Board.find(params[:board_id])
    @reviews = @board.reviews.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end
  
  
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
      params.require(:review).permit(:title, :pros, :cons, :board_id, :reviewer_type_id)
    end
  
end
