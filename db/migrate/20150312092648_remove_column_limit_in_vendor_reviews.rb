class RemoveColumnLimitInVendorReviews < ActiveRecord::Migration
  def change
    change_column :vendor_reviews, :pros, :text, :limit => nil
    change_column :vendor_reviews, :cons, :text, :limit => nil
  end
end
