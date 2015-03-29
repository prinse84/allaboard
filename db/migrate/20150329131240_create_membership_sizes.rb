class CreateMembershipSizes < ActiveRecord::Migration
  def change
    create_table :membership_sizes do |t|
      t.string :name

      t.timestamps
    end
  end
end
