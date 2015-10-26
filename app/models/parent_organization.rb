class ParentOrganization < ActiveRecord::Base
  
  # perform validations
  validates :name, presence: true, length: { minimum: 3 } 
  validates :ein, presence: true, length: { maximum: 9, minimum: 9}, numericality: { only_integer: true }
  
  # public functions

  # helper function to return a formatted ein for a specific organization
  # format: nn-nnnnnnn
  def formatted_ein
    self.ein.at(0..1) + "-" + self.ein.at(2..8)
  end
  
end
