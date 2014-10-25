class StaticPagesController < ApplicationController
  layout "home"
  
  def home
    @events = Event.where("date >= ?", Time.now).order('date').limit(5)
    @announcements = get_all_announcements_created_over_the_past_month
    @new_boards = get_all_boards_claimed_this_week
    @new_events = get_all_events_created_this_week
    @recent_articles = get_five_most_recent_articles
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
  
  private
  def get_all_boards_claimed_this_week
    boards = Board.where("user_id is not null and claim_date >= ?", Time.now.beginning_of_week)
  end
  
  def get_all_events_created_this_week
    events = Event.where("created_at >= ?", Time.now.beginning_of_week)
  end
  
  def get_all_announcements_created_over_the_past_month
    announcements = Announcement.where("created_at >= ?",Time.now.last_month).order('created_at DESC').limit(5)
  end
  
  def get_five_most_recent_articles
    articles = Article.order("created_at DESC").limit(5)
  end
  
end
