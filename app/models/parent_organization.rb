class ParentOrganization < ActiveRecord::Base
  
  # perform validations
  validates :name, presence: true, length: { minimum: 3 } 
  validates :ein, presence: true, length: { maximum: 9, minimum: 9}, numericality: { only_integer: true }, uniqueness: true
  
  # public functions

  # helper function to return a formatted ein for a specific organization
  # format: nn-nnnnnnn
  def formatted_ein
    self.ein.at(0..1) + "-" + self.ein.at(2..8)
  end
  
  
  # function to import comma delimited data
  # no header is required
  def self.import(csv_data)
    arr = CSV.parse(csv_data)
    counter = 0
    arr.each do |a|
      name, ein = a
      parent_organization = self.create(name: name, ein: ein)
      #puts parent_organization.errors.full_messages if parent_organization.errors.any?
      counter += 1 if parent_organization.persisted?
    end
    return counter
  end
  
end
