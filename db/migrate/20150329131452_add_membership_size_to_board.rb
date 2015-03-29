class AddMembershipSizeToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :membership_size_id, :integer
  end
end
