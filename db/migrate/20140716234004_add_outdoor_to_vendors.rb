class AddOutdoorToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :outdoor, :boolean
    add_column :vendors, :indoor, :boolean
    add_column :vendors, :capacity, :integer
    add_column :vendors, :cost, :integer
  end
end
