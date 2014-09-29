class AnnouncementsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
  end
  
  def new
    @board = Board.find_by(slug: params[:board_slug])
    @announcement = Announcement.new
  end
  
  def create
    @board = Board.find(params[:board_slug])
    @announcement = @board.announcements.new(announcement_params)
      if @announcement.save
        flash[:success] = "New announcement saved."  
        redirect_to board_path(@board.slug)
      else
        render 'new'
      end
  end
  
  def edit 
    @board = Board.find_by(slug: params[:board_slug])    
    if !@board.blank?
      @announcement = Announcement.find(params[:id]) 
      if !@board.board_admin?(current_user) 
        flash[:notice] = "You are not the admin of this board. Therefore, you cannot edit details."
        redirect_to board_path(@board)
      end 
    else 
      flash[:warning] = "The board you are looking for does not exist"
      redirect_to boards_path
    end 
  end
  
  def update
    @announcement = Announcement.find(params[:id])
    @board = Board.find(params[:board_slug])
    if @announcement.update_attributes(announcement_params)
      flash[:success] = "Announcement details updated."
      redirect_to board_path(@board.slug)
    else
      render "edit"
    end    
  end
  
  def destroy
    @board = Board.find_by(slug: params[:board_slug])
    if !@board.blank?  
      Announcement.find(params[:id]).destroy
      flash[:success] = "This announcement has been deleted."
      redirect_to board_path(@board.slug)
    else
      flash[:warning] = "The board that owns this announcement that you are looking for does not exist"
      redirect_to boards_path
    end
  end
  
  
  private
    def announcement_params
      params.require(:announcement).permit(:text, :board_id)
    end
  
end