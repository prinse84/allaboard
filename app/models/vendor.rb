class Vendor < ActiveRecord::Base

  # perform validations
  validates :name, presence: true, length: { minimum: 3 }
  validates :board_id, presence: true

  # define associations
  belongs_to :board
  has_many :vendor_reviews, dependent: :destroy

  before_validation :add_http_to_url
  before_save :default_values

  def get_random_review
    reviews = self.vendor_reviews
    max = reviews.count
    index = [*0..max-1].sample
    reviews[index]
  end

  def get_average_rating
    self.vendor_reviews.sum(:rating)/self.vendor_reviews.size
  end

  protected

  # function to add the 'http' prefix to vendor website urls that do not have this value
  # makes assumption that all URLs will be http instead of https
  # code snippet borrowed from the interwebs
  def add_http_to_url
    if !self.website_url.blank?
      unless self.website_url[/\Ahttp:\/\//] || self.website_url[/\Ahttps:\/\//]
        self.website_url = "http://#{self.website_url}"
      end
    end
  end

  private

    def default_values
      self.capacity ||= 0
      self.cost ||= 0
    end
end
