class UpdateTextColumnOnAnnouncements < ActiveRecord::Migration
  def change
    change_column :announcements, :text, :text, :limit => nil
  end
end
