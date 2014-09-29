class StaticPagesController < ApplicationController
  layout "home"
  
  def home
    @events = Event.where("date >= ?", Time.now).order('date').limit(5)
    @announcements = Announcement.where("created_at >= ?",Time.now.last_month).order('created_at DESC').limit(5)
  end
  
  def contact
    @contact = Contact.new
  end
  
  def existing_members
  end
  
  def interested_member
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
