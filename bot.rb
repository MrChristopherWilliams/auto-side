def like(user_or_user_id)
  like_from_user_id(user_or_user_id.id)
  puts "Liked #{user_or_user_id.id} (#{user_or_user_id.name})"
end

def like_from_user_id(user_id)
  @connection.get "like/#{user_id}"
 end
