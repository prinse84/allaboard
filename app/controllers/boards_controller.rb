class BoardsController < ApplicationController
  
  before_action :authenticate_user!, :only => [:claim, :new, :edit, :destroy]
  helper_method :sort_column, :sort_direction, :tag_param
  
  def index
    if params[:tag]
      #category = Category.find_by(name: params[:tag])
      category = Category.where("name = ? AND for = ?", tag_param, 'Board').take
        if !category.blank?
          @boards = category.boards.paginate(:page => params[:page], :per_page => 20).order(sort_column + ' ' + sort_direction)
        else 
          @boards = Board.all.paginate(:page => params[:page], :per_page => 20).order(sort_column + ' ' + sort_direction)
        end  
    else
      @boards = Board.all.paginate(:page => params[:page], :per_page => 20).order(sort_column + ' ' + sort_direction)
    end
    
    @reviews = Review.all
    ids = Review.pluck(:board_id).shuffle[0]
    @board_reviews = Board.where(id: ids) 
    @categories = Category.where(:for => 'Board').order('name')   
  end
  
  def show
    @board = Board.find_by(slug: params[:slug])
    if !@board.blank?
      @reviews = @board.reviews.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
      @events = @board.events.where("date >= ?", Time.now).paginate(:page => params[:page], :per_page => 5).order('date')
      @total_upcoming_events = @board.events.where("date >= ?", Time.now)
      #@vendors = @board.vendors.paginate(:page => params[:page], :per_page => 2).order('name')
      @vendors = @board.vendors.order('name')
      @total_vendors = @board.vendors
      @announcements = @board.announcements.where("created_at >= ?", Time.now.last_month).order('created_at DESC')
    else
      flash[:warning] = "The board you are looking for does not exist"
      redirect_to boards_path
    end
  end
  
  def new
    @board = Board.new
    @all_users = User.all    
    @categories = Category.where(:for => 'Board').order('name')
  end
  
  def edit
    @board = Board.find_by(slug: params[:slug])
    if !@board.blank?
      @all_users = User.all
      @categories = Category.where(:for => 'Board').order('name')    
      if !@board.board_admin?(current_user) 
        flash[:notice] = "You are not the admin of this board. Therefore, you cannot edit details."
        redirect_to board_path(@board)
      end
    else 
      flash[:warning] = "The board you are looking for does not exist"
      redirect_to boards_path
    end
  end
  
  def create
    @board = Board.new(board_params)
    if @board.save
      @board.category_ids = board_params[:category_ids]
      flash[:success] = "Board added to directory."
      redirect_to board_path(@board.slug)
    else
      render 'new'
    end
  end
  
  def update
    @board = Board.find(params[:slug])
    if @board.update_attributes(board_params)
      @board.category_ids = board_params[:category_ids]
      flash[:success] = "Board details updated."
      redirect_to board_path(@board.slug)
    else
      render "edit"
    end
  end

  def destroy
    Board.find_by(slug: params[:slug]).destroy
    if !@board.blank?
      flash[:success] = "The board has been deleted."
      redirect_to boards_path
    else
      flash[:warning] = "The board you are looking for does not exist"
      redirect_to boards_path
    end
    
  end
  
  def claim
    @board = Board.find_by(slug: params[:board_slug])
    if @board.blank?   
      flash[:warning] = "The board you are looking for does not exist"
      redirect_to boards_path
    end     
  end
  
  def unclaim
    @board = Board.find_by(slug: params[:board_slug])
    if @board.blank?   
      flash[:warning] = "The board you are looking for does not exist"
      redirect_to boards_path
    end    
  end
  
  def assign
    @board = Board.find_by(slug: params[:board_slug])    
    if !@board.blank?    
      @board.update_attribute(:user_id, current_user.id)
      if @board.save
        # Tell the BoardMailer to send a notification to the administrators after save
        BoardMailer.board_claim_email(current_user.id, @board.id).deliver
        flash[:success] = "Congratulations, you are now the administrator of this board."
        redirect_to board_path(@board.slug)
      else
        render 'claim'
      end
    else
      flash[:warning] = "The board you are looking for does not exist"
      redirect_to boards_path
    end
  end
  
  def unassign
    @board = Board.find_by(slug: params[:board_slug])
    if !@board.blank?     
      @board.update_attribute(:user_id, nil)
      if @board.save
        flash[:success] = "You have been removed as the administrator of " + @board.name
        redirect_to user_path(current_user)
      else
        render 'unclaim'
      end
    else
      flash[:warning] = "The board you are looking for does not exist"
      redirect_to boards_path
    end
  end
  
  def suggestion
    @suggestion = Suggestion.new
  end
  
  def suggestion_create
    @suggestion = Suggestion.new(suggestion_params)
    if @suggestion.save
      # Tell the BoardMailer to send a suggestion over email after save
      BoardMailer.suggestion_email(@suggestion).deliver
      flash[:success] = "Thank you for your submission."
      redirect_to boards_path
    else
      render 'suggestion'
    end
  end
  
  private
    def board_params
      params.require(:board).permit(:name, :description, :parent_company, :url, :user_id, {category_ids: []})
    end
    
    def suggestion_params
      params.require(:suggestion).permit(:suggested_board_name, :suggester_email)
    end
    
    def sort_column
      %w[name contact].include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
    
    def tag_param
      Category.where(:for => 'Board').pluck(:name).include?(params[:tag]) ? params[:tag] : ""
    end
    

end
