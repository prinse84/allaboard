class Event < ActiveRecord::Base
    validates_presence_of :name, :description, :date, :start_time, :location
    belongs_to :board
    
    before_validation :smart_add_url_protocol
    
    
    def formatted_date
      if !self.start_time.nil? && !self.end_time.nil?
        return self.date.strftime("%B %d, %Y") + " from " + self.start_time.strftime("%I:%M%p") + " to " + self.end_time.strftime("%I:%M%p")
      elsif !self.start_time.nil? && self.end_time.nil?
        return self.date.strftime("%B %d, %Y") + " starting at " + self.start_time.strftime("%I:%M%p") + "."
      else
        return self.date.strftime("%B %d, %Y")
      end 
    end
    
    protected
    
    def smart_add_url_protocol
      unless self.event_url[/\Ahttp:\/\//] || self.event_url[/\Ahttps:\/\//] || !self.event_url.blank?
        self.event_url = "http://#{self.event_url}"
      end
    end
    
end
