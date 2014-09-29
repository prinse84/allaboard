class ChangeColumnDefinitionForTextOnAnnouncements < ActiveRecord::Migration
  def change
    change_column :announcements, :text, :string
  end
end
