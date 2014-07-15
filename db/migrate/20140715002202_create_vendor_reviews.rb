class CreateVendorReviews < ActiveRecord::Migration
  def change
    create_table :vendor_reviews do |t|
      t.string :title
      t.float :rating
      t.string :pros
      t.string :cons
      t.integer :vendor_id

      t.timestamps
    end
  end
end
