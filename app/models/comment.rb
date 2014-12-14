class Comment < ActiveRecord::Base

  validates :text, presence: true
  belongs_to :article
  belongs_to :user

end
