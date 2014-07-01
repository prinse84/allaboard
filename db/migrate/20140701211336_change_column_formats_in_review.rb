class ChangeColumnFormatsInReview < ActiveRecord::Migration
  def change
    change_column :reviews, :pros, :text
    change_column :reviews, :cons, :text
  end
end
