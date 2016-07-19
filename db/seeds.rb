# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Category.count == 0
  ["Controversial Posts", "Infographics", "Podcast Show Notes", "Videos", "Interviews", "Guest Posts", "Blog Series"].each do |cat|
    Category.create title: cat
  end
end


50.times do
  Article.create title: Faker::Book.title,
                 text: Faker::Lorem.sentences,
                 user_id: Faker::Number.between(1, 3)
end
