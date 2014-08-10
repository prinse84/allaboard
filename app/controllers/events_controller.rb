class EventsController < ApplicationController
  
  def index
    @events = Event.all.paginate(:page => params[:page], :per_page => 20).order('date')
  end

  def show
    @event = Event.find(params[:id])
    @board = @event.board
    @other_events = @board.events.where.not(id: @event.id).order('date')
  end
  
  def new
    @board = Board.find_by(slug: params[:board_slug])
    @event = Event.new(:board_id => @board.id)
  end
  
  def create
    @board = Board.find(params[:board_slug])
    @event = @board.events.new(event_params)
    if @event.save
      flash[:success] = "New Event added Saved."  
      redirect_to board_path(@board.slug)
    else
      render 'new'
    end    
  end
  
  def edit
    @board = Board.find_by(slug: params[:board_slug])
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    @board = Board.find(params[:board_slug])
    if @event.update_attributes(event_params)
      flash[:success] = "Event details updated."
      redirect_to board_path(@board.slug)
    else
      render "edit"
    end
  end
  
  
  private
     def event_params
       params.require(:event).permit(:name, :description, :date, :start_time, :end_time, :location, :event_url)
     end
end
