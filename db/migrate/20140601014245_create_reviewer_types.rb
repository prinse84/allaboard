class CreateReviewerTypes < ActiveRecord::Migration
  def change
    create_table :reviewer_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
