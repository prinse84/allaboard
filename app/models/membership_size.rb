class MembershipSize < ActiveRecord::Base
  validates :name, presence: true   
  has_many :boards
end
