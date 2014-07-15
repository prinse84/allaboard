class Vendor < ActiveRecord::Base
  validates :name, presence: true
  validates :board_id, presence: true
  belongs_to :user
  has_many :vendor_reviews

  def get_random_review
    reviews = self.vendor_reviews
    max = reviews.count
    index = [*0..max-1].sample
    reviews[index]
  end

  def get_average_rating
    self.vendor_reviews.sum(:rating)/self.vendor_reviews.size
  end
end
