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
      #for each board created, create 3 random vendors
      3.times do |v|
        Vendor.create!(name: Faker::Company.name,
                          address: Faker::Address.street_address + '\r\n' + Faker::Address.city + ', ' + Faker::Address.state_abbr + ' ' + Faker::Address::zip_code,
                          phone: Faker::PhoneNumber.cell_phone.to_i,
                          email: Faker::Internet.email,
                          contact: Faker::Name.name,
                          board_id: b.id
                          )
      end
    end
  end
end
