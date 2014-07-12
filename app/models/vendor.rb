class Vendor < ActiveRecord::Base
  validates :name, presence: true
  validates :board_id, presence: true
end
