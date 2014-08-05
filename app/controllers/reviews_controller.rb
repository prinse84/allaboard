class ReviewsController < ApplicationController
  include ApplicationHelper
  before_action :site_admin_logged_in?, :only => [:edit, :update, :destroy]
 
  def index
    @board = Board.find(params[:board_id])
    @reviews = @board.reviews.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
  end
  
  def show
    @board = Board.find_by(slug: params[:board_slug])
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

  def edit
     @review = Review.find(params[:id])
  end

  def update
     @review = Review.find(params[:id])
     @review.rating = params[:score]
     if @review.update_attributes(review_params)
      flash[:success] = "Review updated"
      redirect_to board_path(@review.board)
     else
      render 'edit'
     end
  end

  def destroy
    @review = Review.find(params[:id])
    @board = @review.board
    @review.destroy
    flash[:success] = "The review has been deleted."
    redirect_to board_path(@board)
  end
  
  private
    def review_params
      params.require(:review).permit(:title, :pros, :cons, :board_id, :reviewer_type_id)
    end

end
