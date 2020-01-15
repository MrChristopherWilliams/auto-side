require 'rubygems'
require 'watir'
require 'webdrivers'
require 'json'
require 'open-uri'
require_relative 'secrets'


proxy = {
  http: '185.10.166.130:8080',
  ssl:  '185.10.166.130:8080'
}

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

# Get FB user id
def facebook_user_id(facebook_authentication_token)
  url = 'https://graph.facebook.com/me?access_token=' + facebook_authentication_token
  fb_seralized = open(url).read
  fb = JSON.parse(fb_seralized)
  facebook_user_id = fb["id"]
  return facebook_user_id
end
