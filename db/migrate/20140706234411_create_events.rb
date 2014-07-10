class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description, :limit => nil
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :location
      t.string :location_address
      t.string :event_url
      t.integer :board_id

      t.timestamps
    end
  end
end
