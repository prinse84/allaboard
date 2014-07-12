class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :contact
      t.integer :board_id

      t.timestamps
    end
  end
end
