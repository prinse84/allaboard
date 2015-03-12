class ChangeColumnFormatsInVendorReviews < ActiveRecord::Migration
  def change
    change_column :vendor_reviews, :pros, :text
    change_column :vendor_reviews, :cons, :text
  end
end
