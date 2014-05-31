namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #Create 50 generic board names
    Board.create!(name: "Example Board")
    49.times do |n|
      name  = Faker::Company.name
      b = Board.create!(name: name)
      #for each board created, create 20 random ratings
      20.times do |r|
        b.reviews.create!(title: Faker::Lorem.sentence.to_s,
                          rating: [*1..5].sample,
                          pros: Faker::Lorem.sentences.to_s,
                          cons: Faker::Lorem.sentences.to_s
                          )
      end
    end
  end
end