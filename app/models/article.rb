class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  
  belongs_to :user
  
  before_validation :create_slug
  
  
  private
    def create_slug
      self.slug = title.parameterize
    end
  
end
