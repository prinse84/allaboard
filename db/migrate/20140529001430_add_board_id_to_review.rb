class AddBoardIdToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :board_id, :integer
  end
end
