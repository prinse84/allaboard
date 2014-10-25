class AddClaimDateToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :claim_date, :date
  end
end
