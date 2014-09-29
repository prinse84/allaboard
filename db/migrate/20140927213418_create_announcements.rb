class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :text, :limit => nil

      t.timestamps
    end
  end
end
