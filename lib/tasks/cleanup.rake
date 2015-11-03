namespace :cleanup do

  desc "clean up the board organizations to line with up with parent organizations"
  task board_organization: :environment do
    boards = Board.all
    # search for the parent_organization by the name provided on the
    # associate board parent_company field
    counter = 0
    boards.each do |b|
      parent_organization = ParentOrganization.find_by(name: b.parent_company)
      if !parent_organization.nil?
        b.update_attribute(:parent_organization_id, parent_organization.id)
        p b.id.to_s + '||' + b.name + '||' +  b.parent_organization.name
        counter += 1
      end
    end
    p counter.to_s + " record".pluralize(counter) + " updated"
  end

end
