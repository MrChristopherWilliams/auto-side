require_relative 'client'
require_relative 'application'
require_relative 'user'
require_relative 'bot'

new_client = create_client
puts new_client.profile.name

count = 0
new_client.recommended_users.each do |user|
  @connection.headers[:content_type] = 'application/json'
  @connection.headers['X-Auth-Token'] = @tinder_token
  random_number = rand(1..10)
  if count < 2
    if random_number < 8
      like_from_user_id(user.id)
      puts "liked user #{user.name}"
      puts @connection.headers
      sleep(rand(3.1..7.3))
      count += 1
    else
      puts 'Randomisation is cruel'
    end
  else
    puts 'Did not work'
  end
end
