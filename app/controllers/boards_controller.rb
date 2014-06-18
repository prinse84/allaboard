class BoardsController < ApplicationController
  
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
  
  private
    def board_params
      params.require(:board).permit(:name)
    end

end
