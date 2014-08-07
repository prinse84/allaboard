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
       # Tell the ReviewMailer to send a notification of the review to admins over email after save
       ReviewMailer.new_review_email(@review, 'allaboardalliance@gmail.com').deliver   
       
       #Send notification email to board owner as well
       if @review.board.board_claimed?
         ReviewMailer.new_review_email(@review, @review.board.user.email).deliver
       end
       
       flash[:success] = "Thanks! Your review has been submitted."  
       redirect_to board_path(@review.board.slug)
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
      redirect_to board_path(@review.board.slug)
     else
      render 'edit'
     end
  end

  def destroy
    @review = Review.find(params[:id])
    @board = @review.board
    @review.destroy
    flash[:success] = "The review has been deleted."
    redirect_to board_path(@board.slug)
  end
  
  private
    def review_params
      params.require(:review).permit(:title, :pros, :cons, :board_id, :reviewer_type_id)
    end

end
