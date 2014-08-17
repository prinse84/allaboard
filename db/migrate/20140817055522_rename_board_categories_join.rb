class RenameBoardCategoriesJoin < ActiveRecord::Migration
  def change
    rename_table :categories_boards, :boards_categories
  end
end
