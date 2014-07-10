class Board < ActiveRecord::Base
    validates :name, presence: true
    has_many :reviews, dependent: :destroy
    has_many :events, dependent: :destroy
    belongs_to :user
    
    before_validation :smart_add_url_protocol
    
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
    
    def board_admin?(user)
      if self.user_id == user.id
        true
      else 
        false
      end
    end
    
    protected
    
    def smart_add_url_protocol
      unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//] || !self.url.blank?
        self.url = "http://#{self.url}"
      end
    end
end
