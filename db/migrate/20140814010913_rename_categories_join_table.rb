class RenameCategoriesJoinTable < ActiveRecord::Migration
  def change
    rename_table :categories_event_joins, :categories_events
  end
end
