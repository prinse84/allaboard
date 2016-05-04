class ChangeVendorColumnsAgain < ActiveRecord::Migration
  def change
    change_column :vendors, :cost, :string
  end
end
