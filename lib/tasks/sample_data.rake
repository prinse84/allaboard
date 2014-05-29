namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Board.create!(name: "Example User")
    99.times do |n|
      name  = Faker::Company.name
      Board.create!(name: name)
    end
  end
end