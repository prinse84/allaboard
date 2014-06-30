class BoardsController < ApplicationController
  
  before_action :authenticate_user!, :only => [:claim]
  
  def index
    @boards = Board.all.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end
  
  def show
    @board = Board.find(params[:id])
  end
  
  def new
    @board = Board.new
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
  end
  
  def claim
    @board = Board.find(params[:board_id])
  end
  
  def assign
    @board = Board.find(params[:board_id])
    @board.update_attribute(:user_id, current_user.id)
    if @board.save
      redirect_to boards_path
    else
      render 'claim'
    end
  end
  
  private
    def board_params
      params.require(:board).permit(:name)
    end

end
