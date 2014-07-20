class VendorReview < ActiveRecord::Base
  validates :title, presence: true
  validates :rating, presence: true
  validates :pros, presence: true
  validates :cons, presence: true
  validates :vendor_id, presence: true
  belongs_to :vendor
end
