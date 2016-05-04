class AddFieldsToBoards < ActiveRecord::Migration
  def change
        add_column :boards, :twitter_name, :string
        add_column :boards, :facebook_page_url, :string
  end
end
