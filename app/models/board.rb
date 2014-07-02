class Board < ActiveRecord::Base
    validates :name, presence: true
    has_many :reviews, dependent: :destroy
    belongs_to :user
    
    def get_random_review
      reviews = self.reviews
      max = reviews.count
      index = [*0..max-1].sample
      reviews[index]
    end
    
    def get_average_rating
      self.reviews.sum(:rating) / self.reviews.size
    end
    
    def board_claimed?
      if self.user_id == nil
        false
      else 
        true
      end
    end
end
