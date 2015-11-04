class AddParentOrganizationIdToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :parent_organization_id, :integer
  end
end
