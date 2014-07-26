class BoardsController < ApplicationController
  
  before_action :authenticate_user!, :only => [:claim, :edit, :destroy]
  
  def index
    @boards = Board.all.paginate(:page => params[:page], :per_page => 20).order('name')
  end
  
  def show
    @board = Board.find(params[:id])
    @reviews = @board.reviews.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
    @events = @board.events.where("date >= ?", Time.now).paginate(:page => params[:page], :per_page => 3).order('date')
  end
  
  def new
    @board = Board.new
  end
  
  def edit
    @board = Board.find(params[:id])
    if !@board.board_admin?(current_user) 
      flash[:notice] = "You are not the admin of this board. Therefore, you cannot edit details."
      redirect_to board_path(@board)
    end
  end
  
  def create
    @board = Board.new(board_params)
    if @board.save
      flash[:success] = "Board added to directory."
      redirect_to board_reviews_path(@board)
    else
      render 'new'
    end
  end
  
  def update
    @board = Board.find(params[:id])
    if @board.update_attributes(board_params)
      flash[:success] = "Board details updated."
      redirect_to board_path(@board)
    else
      render "edit"
    end
  end

  def destroy
    Board.find(params[:id]).destroy
    flash[:success] = "The board has been deleted."
    redirect_to boards_path
  end
  
  def claim
    @board = Board.find(params[:board_id])
  end
  
  def assign
    @board = Board.find(params[:board_id])
    @board.update_attribute(:user_id, current_user.id)
    if @board.save
      flash[:success] = "Congratulations, you are now the administrator of this board."
      redirect_to board_path(@board)
    else
      render 'claim'
    end
  end
  
  def suggestion
    @suggestion = Suggestion.new
  end
  
  def suggestion_create
    @suggestion = Suggestion.new(suggestion_params)
    if @suggestion.save
      flash[:success] = "Thank you for your submission."
      redirect_to boards_path
    else
      render 'suggestion'
    end
  end
  
  private
    def board_params
      params.require(:board).permit(:name, :description, :parent_company, :url)
    end
    
    def suggestion_params
      params.require(:suggestion).permit(:suggested_board_name, :suggester_email)
    end

end
