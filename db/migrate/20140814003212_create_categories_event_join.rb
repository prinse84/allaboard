class CreateCategoriesEventJoin < ActiveRecord::Migration
  def change
    create_table :categories_event_joins, :id => false do |t|
      t.column :category_id, :integer
      t.column :event_id, :integer
    end
  end
end
