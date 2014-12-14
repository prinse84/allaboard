class AddArticleAndUserToComments < ActiveRecord::Migration
  def change
    add_column :comments, :article_id, :integer
    add_column :comments, :user_id, :integer
  end
end
