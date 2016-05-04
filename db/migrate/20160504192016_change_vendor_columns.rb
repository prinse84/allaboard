class ChangeVendorColumns < ActiveRecord::Migration
  def change
    change_column :vendors, :capacity, :string
    change_column :vendors, :capacity, :string
    add_column :vendors, :website_url, :string
  end
end
