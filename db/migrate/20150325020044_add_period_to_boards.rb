class AddPeriodToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :period_id, :integer
  end
end
