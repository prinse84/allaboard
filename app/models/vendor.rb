class Vendor < ActiveRecord::Base

  # perform validations
  validates :name, presence: true, length: { minimum: 3 } 
  validates :board_id, presence: true

  # define associations
  belongs_to :board
  has_many :vendor_reviews, dependent: :destroy

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

  private
    
    def default_values
      self.capacity ||= 0
      self.cost ||= 0
    end
end
