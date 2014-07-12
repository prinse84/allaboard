class Vendor < ActiveRecord::Base
  validates :name, presence: true
end
