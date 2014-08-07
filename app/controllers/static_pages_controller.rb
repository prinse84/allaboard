class StaticPagesController < ApplicationController
  def home
    @reviews = Review.all
    ids = Review.pluck(:board_id).shuffle[0..1]
    @boards = Board.where(id: ids)
    @events = Event.where("date >= ?", Time.now).order('date').limit(7)
  end
  
  def contact
    @contact = Contact.new
  end
  
  def send_contact_message
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash[:error] = nil
      flash[:notice] = 'Thank you for your message!'
      redirect_to root_path
    else
      flash[:error] = 'Cannot send message.'
      render :contact
    end
  end
  
end
