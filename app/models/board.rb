class Board < ActiveRecord::Base
    validates :name, presence: true
    has_many :reviews, dependent: :destroy
    
    def get_random_rating
      reviews = self.reviews
      max = reviews.count
      index = [*0..max-1].sample
      reviews[index]
    end
    
    def get_average_rating
      self.reviews.sum(:rating) / self.reviews.size
    end
end
