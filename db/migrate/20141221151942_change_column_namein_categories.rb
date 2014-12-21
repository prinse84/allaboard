class ChangeColumnNameinCategories < ActiveRecord::Migration
  def change
    rename_column :categories, :for, :forr
  end
end
