class Board < ActiveRecord::Base
    validates :name, presence: true
    validates :slug, presence: true, uniqueness: { case_sensitive: false }
    has_many :reviews, dependent: :destroy
    has_many :events, dependent: :destroy
    has_many :vendors, dependent: :destroy
    belongs_to :user
    belongs_to :period
    belongs_to :membership_size
    has_many :announcements, dependent: :destroy

    has_and_belongs_to_many :categories
    
    before_validation :smart_add_url_protocol, :create_slug
    
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
        #return user.admin
        return false
      end
    end
    
    private
    def create_slug
      self.slug = name.parameterize
    end
    
    protected
    def smart_add_url_protocol
      unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//] || self.url.blank?
        self.url = "http://#{self.url}"
      end
    end
end
