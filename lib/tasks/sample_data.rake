namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #Create 50 generic board names
    #Board.create!(name: "Example Board")
    50.times do |n|
      name  = Faker::Company.name
      description = Faker::Lorem.paragraphs.to_s
      parent_company = Faker::Company.name
      url = Faker::Internet.url
      b = Board.create!(name: name, 
                        description: description,
                        parent_company: parent_company, 
                        url: url)
      
      #for each board created, create 20 random ratings
      20.times do |r|
        b.reviews.create!(title: Faker::Lorem.sentence.to_s,
                          rating: [*1..5].sample,
                          pros: Faker::Lorem.sentences.to_s,
                          cons: Faker::Lorem.sentences.to_s,
                          reviewer_type_id: [*1..4].sample
                          )
      end
      
      #for each board created, create 5 random events
      5.times do |r|
        b.events.create!(name: Faker::Lorem.words(3).to_s,
                        description: Faker::Lorem.paragraphs.to_s,
                        date: rand(1.month).from_now,
                        start_time: rand(1.month).from_now.to_time,
                        location: Faker::Lorem.words.to_s,
                        event_url: Faker::Internet.url
                        )
      end
                        
    end
  end
end