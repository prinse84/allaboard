class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  has_many :boards
  has_many :articles
  has_many :comments
  
  def get_name
    self.first_name + ' ' + self.last_name
  end
  
  def self.generate_csv(fields)
    CSV.generate do |csv|
      csv << fields.collect(&:humanize)
      all.each do |record|
        csv << record.attributes.values_at(*fields)
      end
    end
  end

end
