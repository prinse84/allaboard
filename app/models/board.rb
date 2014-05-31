class Board < ActiveRecord::Base
    validates :name, presence: true
    has_many :reviews
    
    def average_rating
      self.reviews.sum(:rating) / self.reviews.size
    end
end
