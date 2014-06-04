class BoardsController < ApplicationController
  
  def index
    @boards = Board.all.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

end
