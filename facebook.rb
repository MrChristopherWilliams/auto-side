require 'rubygems'
require 'watir'
require 'webdrivers'
require 'mechanize'
require 'httparty'
require_relative 'secrets'

# agent = Mechanize.new
# agent.get('http://facebook.com') do |page|
#   login_page = agent.click(page.link_with(:text => /Log In/ ))
# end

proxy = {
  http: '185.10.166.130:8080',
  ssl:  '185.10.166.130:8080'
}

browser = Watir::Browser.new :chrome
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
  puts auth_url.html
  # puts auth_url
  # sleep(20)
  # response = HTTParty.get(auth_url)
  # sleep(20)
  # puts response.code
  # puts response.body
  facebook_authentication_token = 'x'
  puts facebook_authentication_token
else
  print "error: Login failed. Check your username and password."
end

# browser.wait_until { browser.h1.text == 'Match. Chat. Date.' }


# <script type="text/javascript">window.location.href="fb464891386855067:\/\/authorize\/#signed_request=mChMtAENhJ2hvSclwSE3Sb13ai0kyEnNVFgtrN9R6MM.eyJ1c2VyX2lkIjoiMTAxNTM5NDc0OTQ0MTUzMzMiLCJjb2RlIjoiQVFBTlkweFFmZk0weTFYLWNYbGZpcVdBaTZHRUplclZkRm55NHhBQUpjMXBMRDdNazQ0QWRRNy1WbW1XMzNPSGEwM0J0YkhJV0R3VWVDaHBTeWdGcmF5Q3JUNWF4aWhaem1hemFjZEwyWXRwUDVrbmV0NVpmYnE0bHpWMnFFeWhoclEtdGVuZFRLOWVPb0N2SGRPR3hGWUdSdVBNR2Zfa3pTS2wtZ2VUU1NUaW9lWlZ5Sy1QWk10amRKdFE4eXB1bnJnNENhRXJmd1FyQVNvRjJOZXFXQlJyUmUyTGZlWno2OWh6WXVHcHBNRjdja2JnZFFtbWJMMUEyNVVvTS04enRib1FCTXotTHhuSEYzbjVnODhtVXFzYjVKTjBHdzFFX2hRS3RVRTZZUjhMT1NuMDRWcnZvbmkyZ0pjMGZxNlpIT1RaR1ZLV1RKWjFzejM0c1MyalZfQUEiLCJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImlzc3VlZF9hdCI6MTU3OTA4NzIwMn0&access_token=EAAGm0PX4ZCpsBAG17ZApPqSOJeLYmMRPSzdwZBoJYUL4wrHzCnG6aTaS4HTlxdQXjNWSjqLUr6jjmcBZCGyBrGZAZCdt0XMfK6fwCeNRcXG3jGuZCh4sOtzqJww8AzQaOxocmc0oRP4bvbP5vZAVmwTaqzo0GqqJavKFedEqRRBL8VHuVB97vYgZBClTP38LZCc7IZD&data_access_expiration_time=1586863202&expires_in=5998";</script>
