class RenameColumnOnReviews < ActiveRecord::Migration
  def change
    rename_column :reviews, :review_type_id, :reviewer_type_id
  end
end
