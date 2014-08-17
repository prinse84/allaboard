class CategoriesBoardJoin < ActiveRecord::Migration
  def change
    create_table :categories_boards, :id => false do |t|
      t.column :category_id, :integer
      t.column :board_id, :integer
    end
  end
end
