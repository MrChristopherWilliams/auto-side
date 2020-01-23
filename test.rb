require_relative 'client'
require_relative 'application'
require_relative 'user'
require_relative 'bot'

new_client = create_client
puts new_client.profile.name

def range (min, max)
    rand * (max-min) + min
end

new_client.recommended_users.each do |user|
  if like_from_user_id(user.id)
    puts "liked user #{user.name}"
    sleep(range(1..10))
  else
    puts "Did not work"
  end
end

