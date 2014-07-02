class AddFieldsToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :description, :text, :limit => nil
    add_column :boards, :parent_company, :string
    add_column :boards, :url, :string
  end
end
