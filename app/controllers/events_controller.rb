class EventsController < ApplicationController
  
  
  def new
    @board = Board.find(params[:board_id])
    @event = Event.new(:board_id =>params[:board_id])
  end
  
  def create
    @board = Board.find(params[:board_id])
    @event = @board.events.new(event_params)
    if @event.save
      flash[:success] = "New Event added Saved."  
      redirect_to board_path(@board)
    else
      render 'new'
    end    
  end
  
  def edit
    @board = Board.find(params[:board_id])
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    @board = Board.find(params[:board_id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event details updated."
      redirect_to board_path(@board)
    else
      render "edit"
    end
  end
  
  
  private
     def event_params
       params.require(:event).permit(:name, :description, :date, :start_time, :end_time, :location, :event_url)
     end
end
