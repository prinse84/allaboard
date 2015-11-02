namespace :cleanup do

  desc "clean up the board organizations to line with up with parent organizations"
  task board_organization: :environment do
    boards = Board.all
    # for each board, grab the parent_company.
    # search parent_organization for the value and line up the id
    counter = 0
    boards.each do |b|
      parent_organization = ParentOrganization.find_by(name: b.parent_company)
      if !parent_organization.nil?
        counter += 1
      end
    end
    p counter.to_s + " record".pluralize(counter) + " updated"
  end

end
