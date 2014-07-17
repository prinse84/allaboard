class AddFoodToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :food, :boolean
    add_column :vendors, :catering, :boolean
  end
end
