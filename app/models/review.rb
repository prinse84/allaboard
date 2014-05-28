class Review < ActiveRecord::Base
  validates :title, presence: true
  validates :rating, presence: true  
end
