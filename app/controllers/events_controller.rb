class EventsController < ApplicationController
  
  # index action. This will respond to /events
  def index
     # set a time criteria for events
     if params[:past]
       criteria = Time.now.last_month
     else
       criteria = Date.today
     end
    
     # return events for a specific time frame and for certain categories
     # if the :tag parameter is passed in the URL grab the tag (category) and 
     # show only events from that category within the selected date range
     if params[:tag]
       category = Category.where("name = ? AND forr = ?", params[:tag], 'Event').take
       if !category.blank?
         @events = category.events.where("date >= ?",criteria).paginate(:page => params[:page], :per_page => 20).order('date')
       else 
         @events = Event.where("date >= ?", criteria).paginate(:page => params[:page], :per_page => 20).order('date')
       end  
     else
       # show events across all categories
       @events = Event.where("date >= ?",criteria).paginate(:page => params[:page], :per_page => 20).order('date')
     end 
     
     @categories = get_categories('Event')
  end

  # Show action. This will respond to /events/:slug
  def show
    # Check to see that a valid event was sent in. If not, redirect to events index page
    if @event = Event.find_by(slug: params[:slug])
      # A valid event was passed via :slug
      
      # get all categories (tags) associated with this event
      @categories = @event.categories.order('name')
      
      # Get previous events by this board over the past six months. 
      @other_events_by_board = @event.board.get_previous_events_past_6_months

      # Get other events that are tagged similar to this one. Show only the ones
      # from 30 days ago
      @other_events_by_categories = @event.get_other_events_tagged_like_this_one(Time.now.last_month)
    else
      flash[:warning] = "The event you are looking for does not exist"
      redirect_to events_path
    end
  end
  
  def new
    @board = Board.find_by(slug: params[:board_slug])
    if !@board.blank?
      @event = Event.new(:board_id => @board.id)
      @categories = Category.where(:forr => 'Event').order('name')
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
      flash[:success] = "New Event added."  
      redirect_to board_path(@board.slug)
    else
      @categories = Category.where(:forr => 'Event').order('name')
      render 'new'
    end    
  end
  
  def edit
    @board = Board.find_by(slug: params[:board_slug])
    if !@board.blank?    
      @event = Event.find_by(slug: params[:slug])
      if !@event.blank?
        @categories = Category.where(:forr => 'Event').order('name')
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
