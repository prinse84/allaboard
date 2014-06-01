class AddReviewerTypeToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :review_type_id, :integer
  end
end
