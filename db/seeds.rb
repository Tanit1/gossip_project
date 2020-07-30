# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'colorize'

nb_user = 10
nb_city = 10
nb_gossip = 20
nb_tags = 10
nb_messages = 20
nb_comments = 20
nb_likes = 20

count_users = 0
count_cities = 0
count_gossip = 0
count_gossip_tag = 0
count_tags = 0
count_messages = 0
count_comments = 0
count_likes = 0

# CITIES
nb_city.times do
  city = City.create(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )

  count_cities += 1 unless city.nil?
end

# Confirm seed it's OK
if count_cities == nb_city
  puts '   City:             '.green + "#{count_cities}/#{nb_city}".green + '  ont été créées !'.green
else
  puts '   City:             '.red + "#{count_cities}/#{nb_city}".red + '  ont été créé !'.red
end

# USERS
nb_user.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.paragraph,
    email: Faker::Internet.email,
    age: rand(16..80),
    city_id: Faker::Number.between(from: 0, to: nb_city - 1)
  )

  count_users += 1 unless user.nil?
end

# Confirm seed it's OK
if count_users == nb_user
  puts '   User:             '.green + "#{count_users}/#{nb_user}".green + '  ont été créées !'.green
else
  puts '   User:             '.red + "#{count_users}/#{nb_user}".red + '  ont été créé !'.red
end

# GOSSIPS
nb_gossip.times do
  gossip = Gossip.create(
      title: Faker::Book.title,
      content: Faker::Lorem.paragraph,
      user_id: Faker::Number.between(from: 0, to: nb_user - 1)
    )

  count_gossip += 1 unless gossip.nil?
end

# Confirm seed it's OK
if count_gossip == nb_gossip
  puts '   Gossip:           '.green + "#{count_gossip}/#{nb_gossip}".green + '  ont été créées !'.green
else
  puts '   Gossip:           '.red + "#{count_gossip}/#{nb_gossip}".red + '  ont été créé !'.red
end

# TAGS
nb_tags.times do
  tag = Tag.create(
    title: Faker::Book.genre
  )

  count_tags += 1 unless tag.nil?
end

# Confirm seed it's OK
if count_tags == nb_tags
  puts '   Tags:             '.green + "#{count_tags}/#{nb_tags}".green + '  ont été créées !'.green
else
  puts '   Tags:             '.red + "#{count_tags}/#{nb_tags}".red + '  ont été créé !'.red
end

# JOIN_GOSSIP_TAGS
nb_gossip.times do
  gossip_tag = GossipTag.create(
      gossip_id: Faker::Number.between(from: 0, to: nb_gossip - 1),
      tag_id: Faker::Number.between(from: 0, to: nb_tags - 1)
    )

  count_gossip_tag += 1 unless gossip_tag.nil?
end

# Confirm seed it's OK
if count_gossip_tag == nb_gossip
  puts '   Gossip_tag:           '.green + "#{count_gossip_tag}/#{nb_gossip}".green + '  ont été créées !'.green
else
  puts '   Gossip_tag:           '.red + "#{count_gossip_tag}/#{nb_gossip}".red + '  ont été créé !'.red
end

# Add 10 tags
10.times do
  GossipTag.create(
    gossip_id: Faker::Number.between(from: 0, to: nb_gossip - 1),
    tag_id: Faker::Number.between(from: 0, to: nb_tags - 1)
  )

  count_gossip_tag += 1 unless gossip_tag.nil?
end

# MESSAGES
nb_messages.times do
  message = PrivateMessage.create(
    sender_id: users[rand(0..nb_user-1)].id,
    content: Faker::Lorem.paragraph
  )

  count_messages += 1 unless message.nil?
end

nb_messages.times do
  message = RecipientList.create(
    private_message_id: messages[x].id,
    recipient_id: users[rand(0..nb_user-1)].id
  )

  count_messages += 1 unless message.nil?
end

# RECIPIENTS
nb_messages.times do
  message = RecipientList.create(
    private_message_id: messages[rand(0..nb_messages-1)].id,
    recipient_id: users[rand(0..nb_user-1)].id
  )

  count_messages += 1 unless message.nil?
end

# COMMENTS
nb_comments.times do
  comment = Comment.create(
      content: Faker::Lorem.paragraph,
      user_id: Faker::Number.between(from: 0, to: nb_user* - 1),
      gossip_id: Faker::Number.between(from: 0, to: nb_gossip - 1)
    )

  count_comments += 1 unless comment.nil?
end

# LIKES > COMMENTS
nb_likes.times do
  like = Like.create(
    comment_id: Faker::Number.between(from: 0, to: nb_comments - 1)
  )

  count_likes += 1 unless like.nil?
end
# LIKES > GOSSIPS
nb_likes.times do
  like = Like.create(
    gossip_id: Faker::Number.between(from: 0, to: nb_gossip - 1)
  )

  count_likes += 1 unless like.nil?
end

# Comments of comments
nb_comments.times do
  comment = Comment.create(
      content: Faker::Lorem.paragraph,
      user_id: Faker::Number.between(from: 0, to: nb_user - 1),
      comment_id: Faker::Number.between(from: 0, to: nb_comments - 1)
    )

  count_comments += 1 unless comment.nil?
end
