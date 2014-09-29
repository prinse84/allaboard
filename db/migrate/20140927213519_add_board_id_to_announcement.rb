class AddBoardIdToAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :board_id, :integer
  end
end
