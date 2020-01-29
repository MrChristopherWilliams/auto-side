def like(user_or_user_id)
  like_from_user_id(user_or_user_id.id)
  puts "Liked #{user_or_user_id.id} (#{user_or_user_id.name})"
end

def like_from_user_id(user_id)
  @connection.get "like/#{user_id}"
end

def set_location
  { 'lat': '48.8566', 'lon': '2.3522' }
end

def post_location
  @connection.headers[:content_type] = 'application/json'
  @connection.headers['X-Auth-Token'] = @tinder_token
  @connection.post '/passport/user/travel', set_location
  puts 'Setting location'
end
