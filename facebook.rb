require_relative 'secrets'
require 'mechanize'

LOGIN_URL = 'https://www.facebook.com/v2.6/dialog/oauth?redirect_uri=fb464891386855067%3A%2F%2Fau' \
            'thorize%2F&scope=user_birthday,user_photos,user_education_history,email,user_relatio' \
            'nship_details,user_friends,user_work_history,user_likes&response_type=token%2Csigned' \
            '_request&client_id=464891386855067'.freeze

ARGV = [email, password]

def get_fb_auth_token
  if ARGV.count != 2
    puts 'Wrong number of args. Usage example: ruby get_fb_auth_token.rb [email] [password]'
    return
  end

  mechanize = Mechanize.new
  login_form = mechanize.get(LOGIN_URL).form do |f|
    f.email = ARGV[0]
    f.pass = ARGV[1]
  end
  p login_form.submit.form.submit.body.split('access_token=')[0]
  login_form.submit.form.submit.body.split('access_token=')[1].split('&')[0]
end

puts get_fb_auth_token
