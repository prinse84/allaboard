class EventsController < ApplicationController
  
  def index
    if params[:past]
      criteria = Time.now.last_month
    else
      criteria = Time.now
    end
    
    if params[:tag]
      category = Category.find_by(name: params[:tag])
      if !category.blank?
        @events = category.events.where("date >= ?",criteria).paginate(:page => params[:page], :per_page => 20).order('date')
      else 
        @events = Event.where("date >= ?", criteria).paginate(:page => params[:page], :per_page => 20).order('date')
      end  
    else
      @events = Event.where("date >= ?",criteria).paginate(:page => params[:page], :per_page => 20).order('date')
    end 
    @categories = Category.where(:for => 'Event').order('name')   
  end

  def show
    @event = Event.find_by(slug: params[:slug])
    if !@event.blank?
      @board = @event.board
      @categories = @event.categories.order('name')   
      @other_events_by_board = @board.events.where.not(id: @event.id).order('date')
      @other_events_by_categories = []
      if !@categories.blank?
        @categories.each do |category|
          @other_events_by_categories = category.events.where.not(id: @event.id).order('date')            
        end
      end
    else
      flash[:warning] = "The event you are looking for does not exist"
      redirect_to events_path
    end
  end
  
  def new
    @board = Board.find_by(slug: params[:board_slug])
    if !@board.blank?
      @event = Event.new(:board_id => @board.id)
      @categories = Category.where(:for => 'Event').order('name')
    else
      flash[:warning] = "The board that owns this event that you are looking for does not exist"
      redirect_to events_path
    end
  end
  
  def create
    @board = Board.find(params[:board_slug])
    @event = @board.events.new(event_params)
    if @event.save
      @event.category_ids = event_params[:category_ids]
      flash[:success] = "New Event added Saved."  
      redirect_to board_path(@board.slug)
    else
      render 'new'
    end    
  end
  
  def edit
    @board = Board.find_by(slug: params[:board_slug])
    if !@board.blank?    
      @event = Event.find_by(slug: params[:slug])
      if !@event.blank?
        @categories = Category.where(:for => 'Event').order('name')
      else
        flash[:warning] = "The event that you are looking for does not exist"
        redirect_to events_path
      end
    else
      flash[:warning] = "The board that owns this event that you are looking for does not exist"
      redirect_to events_path      
    end
    
  end
  
  def update
    @event = Event.find(params[:slug])
    @board = Board.find(params[:board_slug])
    if @event.update_attributes(event_params)
      @event.category_ids = event_params[:category_ids]      
      flash[:success] = "Event details updated."
      redirect_to board_path(@board.slug)
    else
      render "edit"
    end
  end
  
  def destroy
    @board = Board.find_by(slug: params[:board_slug])
    if !@board.blank?  
      Event.find_by(slug: params[:slug]).destroy
      flash[:success] = "This event has been deleted."
      redirect_to board_path(@board.slug)
    else
      flash[:warning] = "The board that owns this event that you are looking for does not exist"
      redirect_to events_path
    end
  end
  
  
  private
     def event_params
       params.require(:event).permit(:name, :description, :date, :start_time, :end_time, :location, :event_url, {category_ids: []})
     end
end
