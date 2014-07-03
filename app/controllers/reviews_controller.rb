class ReviewsController < ApplicationController
 
  def index
    @board = Board.find(params[:board_id])
    @reviews = @board.reviews.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
  end
  
  def show
    @board = Board.find(params[:board_id])
    @review = Review.find(params[:id])
  end
  
  def new
     @review = Review.new(:board_id =>params[:board_id])
  end
  
  def create
     @review = Review.new(review_params)
     @review.rating = params[:score]
     if @review.save
       flash[:success] = "Review Saved."  
       redirect_to board_path(@review.board)
     else
       render 'new'
     end
  end
  
  private
    def review_params
      params.require(:review).permit(:title, :pros, :cons, :board_id, :reviewer_type_id)
    end
  
end
