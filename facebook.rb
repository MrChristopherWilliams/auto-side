require 'watir'
require 'webdrivers'
require 'json'
require 'open-uri'
require 'faraday_middleware'
require_relative 'secrets'

proxy = {
  http: '185.10.166.130:8080',
  ssl:  '185.10.166.130:8080'
}


def facebook_authentication_token
  browser = Watir::Browser.new :chrome, :switches => %w[--disable-notifications]
  browser.goto 'https://m.facebook.com/v2.6/dialog/oauth?redirect_uri=fb464891386855067%3A%2F%2Fauthorize%2F&scope=user_birthday%2Cuser_photos%2Cuser_education_history%2Cemail%2Cuser_relationship_details%2Cuser_friends%2Cuser_work_history%2Cuser_likes&response_type=token%2Csigned_request&client_id=464891386855067&ret=login&fallback_redirect_uri=221e1158-f2e9-1452-1a05-8983f99f7d6e&ext=1556057433&hash=Aea6jWwMP_tDMQ9y'

  # Enter Facebook login details and click login
  browser.text_field(id: 'm_login_email').set $email
  browser.text_field(id: 'm_login_password').set $password
  browser.button(type: 'button').click

  sleep(5)

  # Get FB authentication token
  if browser.form.id == 'platformDialogForm'
    browser.button(type: 'submit').click
    auth_url = browser
    auth_html = auth_url.html
    facebook_authentication_token = auth_html.scan(/access_token=(.*)&data_access/).last.first
    return facebook_authentication_token
  else
    print "error: Login failed. Check your username and password."
  end
end

def facebook_user_id(facebook_authentication_token)
  browser = Watir::Browser.new :chrome, :switches => %w[--disable-notifications]
  browser.goto 'https://m.facebook.com/v2.6/dialog/oauth?redirect_uri=fb464891386855067%3A%2F%2Fauthorize%2F&scope=user_birthday%2Cuser_photos%2Cuser_education_history%2Cemail%2Cuser_relationship_details%2Cuser_friends%2Cuser_work_history%2Cuser_likes&response_type=token%2Csigned_request&client_id=464891386855067&ret=login&fallback_redirect_uri=221e1158-f2e9-1452-1a05-8983f99f7d6e&ext=1556057433&hash=Aea6jWwMP_tDMQ9y'

  # Enter Facebook login details and click login
  browser.text_field(id: 'm_login_email').set $email
  browser.text_field(id: 'm_login_password').set $password
  browser.button(type: 'button').click

  sleep(5)

  # Get FB user id
  url = 'https://graph.facebook.com/me?access_token=' + facebook_authentication_token
  fb_seralized = open(url).read
  fb = JSON.parse(fb_seralized)
  facebook_user_id = fb['token']
end

def tinder_authentication_token(facebook_authentication_token, facebook_user_id)
  # Tinder auth token
  @connection = Faraday.new(url: 'https://api.gotinder.com') do |faraday|
    faraday.request :json
    faraday.response :logger
    faraday.adapter Faraday.default_adapter
  end
  @connection.headers['User-agent'] = 'Tinder/7.5.3 (iPhone; iOS 10.3.2; Scale/2.00)'

  rsp = @connection.post '/v2/auth/login/facebook', {'token': facebook_authentication_token, 'facebook_id': facebook_user_id}
  puts "parsing"
  jrsp = JSON.parse(rsp.body)
  puts "extracting token"
  jrsp_array = jrsp.map do |key, value|
    value.each do |k,v|
    end
  end

  tinder_authentication_data = jrsp_array[1]
  tinder_api_token = tinder_authentication_data["api_token"]
  tinder_refresh_token = tinder_authentication_data["refresh_token"]
end
