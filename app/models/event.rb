class Event < ActiveRecord::Base

  # perform validations
  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :slug, uniqueness: { case_sensitive: false }
  validates :board_id, presence: true

  before_validation :create_slug, :add_http_to_url

  # define associations
  belongs_to :board
  has_and_belongs_to_many :categories

  # public functions

  # helper function to return other events in the same category as this one
  # will return as many as necessary depending on the criteria parameter
  # Note: function will not include current event even if event falls within the criteria period
  def get_other_events_tagged_like_this_one(criteria)
    # Identify all categories related this event. Fyi, this is the 'tag' for the event
    categories = self.categories.order('name')

    # Assuming this event was tagged with a category(ies)
    # For each category, grab all the events based on criteria (for example last month) into an array
    # return only the unique set
    other_events_by_categories = []
    if !categories.blank?
      categories.each do |category|
        events = category.events.where("date >= ? and date <= ? and event_id != ?", criteria, Time.now, self.id)
        events.each do |event|
          other_events_by_categories << event
        end
      end
      other_events_by_categories = other_events_by_categories.uniq
    end
    return other_events_by_categories
  end

  # helper function to return a formatted date in views.
  # function will return a formatted date depending on the presence of start_time and/or end_time
  def formatted_date
    if !self.start_time.nil? && !self.end_time.nil?
      return self.date.strftime("%B %d, %Y") + " from " + self.start_time.strftime("%I:%M%p") + " to " + self.end_time.strftime("%I:%M%p")
    elsif !self.start_time.nil? && self.end_time.nil?
      return self.date.strftime("%B %d, %Y") + " starting at " + self.start_time.strftime("%I:%M%p")
    else
      return self.date.strftime("%B %d, %Y")
    end
  end

  private

  # function to create slug (i.e. parameterized value of name column. This will be used for unique URLs)
  # Example: Baller Event will result in slug value: baller-event
  # logic added to handle occurrence of non-unique events being created
  # this will result in creating a unique slug value that includes the event date
  # Example: A duplicate Baller Event with on Oct 19th 2015 will result in slug value: baller-event-2015-10-19
  def create_slug
    if !self.name.nil? && !self.date.nil?
      slug = self.name.parameterize
      # look for other slugs with the same name
      s = Event.where(slug: self.slug)
      if !s.nil?
        slug = slug + "-" + self.date.strftime("%Y") + "-" + self.date.strftime("%m") + "-" + self.date.strftime("%d")
      end
    end
    self.slug = slug
  end

  protected

  # function to add the 'http' prefix to event urls that do not have this value
  # makes assumption that all URLs will be https instead of https
  # code snippet borrowed from the interwebs
  def add_http_to_url
    if !self.event_url.blank?
      unless self.event_url[/\Ahttp:\/\//] || self.event_url[/\Ahttps:\/\//]
        self.event_url = "http://#{self.event_url}"
      end
    end
  end

end
