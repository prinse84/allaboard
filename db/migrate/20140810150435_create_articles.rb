class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body, :limit => nil

      t.timestamps
    end
  end
end
