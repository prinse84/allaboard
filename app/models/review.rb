class Review < ActiveRecord::Base
  validates :title, presence: true
  validates :rating, presence: true 
  validates :pros, presence: true  
  validates :cons, presence: true    
  validates :board_id, presence: true  
  validates :reviewer_type_id, presence: true    
  belongs_to :board
  belongs_to :reviewer_type
  

end