class Board < ActiveRecord::Base

  # perform validations
  validates :name, presence: true, length: { minimum: 3 }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

  before_validation :add_http_to_url, :create_slug

  # define associations
  has_many :reviews, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :vendors, dependent: :destroy
  has_many :announcements, dependent: :destroy
  has_and_belongs_to_many :categories
  belongs_to :user
  belongs_to :period
  belongs_to :membership_size
  belongs_to :parent_organization

  # public functions

  # helper function to return a random review
  # will only return one review for the board.
  def get_random_review
    reviews = self.reviews
    max = reviews.count
    index = [*0..max-1].sample
    reviews[index]
  end

  def get_previous_events_past_6_months
    # Grab all events for this board from the past 6 months.
    # Order by date, ascending
    self.events.where(date: 6.months.ago..Date.today).order('date')
  end

  def get_average_rating
    self.reviews.sum(:rating) / self.reviews.size
  end

  # helper function to determine whether a board has been claimed.
  # Assumes that if user id is not populated, the board has not been claimed
  # Lazy? Maybe, but it works :)
  def board_claimed?
    if self.user_id == nil
      false
    else
      true
    end
  end

  # helper function to determine whether the user is the admin of the board
  def board_admin?(user)
    if self.user_id == user.id
      true
    else
      false
    end
  end

  private

  # function to create slug (i.e. parameterized value of name column. This will be used for unique URLs)
  # Example: Baller board will result in slug value: baller-board
  def create_slug
    if !self.name.nil?
      slug = name.parameterize
      # look for other slugs with the same name
      #s = Board.where(slug: slug)
      #if !s.nil?
      #  slug = slug + "-" + Time.now.strftime("%Y%m%d")
      #end
      self.slug = slug
    end
  end

  protected

  # function to add the 'http' prefix to board urls that do not have this value
  # makes assumption that all URLs will be https instead of https
  # code snippet borrowed from the interwebs
  def add_http_to_url
    if !self.url.blank?
      unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
        self.url = "http://#{self.url}"
      end
    end
  end

end
