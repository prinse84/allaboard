class Review < ActiveRecord::Base
  validates :title, presence: true
  validates :rating, presence: true  
  belongs_to :board
end
