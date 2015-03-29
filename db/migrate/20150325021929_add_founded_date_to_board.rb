class AddFoundedDateToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :founding_date, :date
  end
end
