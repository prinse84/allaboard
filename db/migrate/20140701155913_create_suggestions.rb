class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :suggester_email
      t.string :suggested_board_name

      t.timestamps
    end
  end
end
