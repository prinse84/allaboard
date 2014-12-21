class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :forr, presence: true  
  
  has_and_belongs_to_many :boards
  has_and_belongs_to_many :events
  
end
