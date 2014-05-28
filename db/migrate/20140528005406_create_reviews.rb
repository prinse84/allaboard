class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :pros
      t.string :cons
      t.float :rating

      t.timestamps
    end
  end
end
