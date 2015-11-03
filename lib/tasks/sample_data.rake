namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar1234",
                 password_confirmation: "foobar1234")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password1234"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do |n|
        content = Faker::Lorem.paragraph(10)
        users.each do |user|
            title =  Faker::Hacker.say_something_smart.chop + Faker::Lorem.word + '?'
            user.questions.create!(title: title, content: content)
        end
    end
    
  end
end
