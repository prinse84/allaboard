class Event < ActiveRecord::Base
    validates_presence_of :name, :description, :date, :start_time, :location
    belongs_to :board
    
    before_validation :smart_add_url_protocol
    
    protected
    
    def smart_add_url_protocol
      unless self.event_url[/\Ahttp:\/\//] || self.event_url[/\Ahttps:\/\//] || !self.event_url.blank?
        self.event_url = "http://#{self.event_url}"
      end
    end
    
end
