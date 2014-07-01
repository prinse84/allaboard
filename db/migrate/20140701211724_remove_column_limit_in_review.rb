class RemoveColumnLimitInReview < ActiveRecord::Migration
  def change
    change_column :reviews, :pros, :text, :limit => nil
    change_column :reviews, :cons, :text, :limit => nil
  end
end
