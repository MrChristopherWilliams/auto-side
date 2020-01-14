require 'rubygems'
require 'watir'
require 'webdrivers'
require 'mechanize'

agent = Mechanize.new
agent.get('http://facebook.com') do |page|
  login_page = agent.click(page.link_with(:text => /Log In/ ))
end

proxy = {
  http: '185.10.166.130:8080',
  ssl:  '185.10.166.130:8080'
}

browser = Watir::Browser.new :chrome, proxy: proxy
browser.goto 'facebook.com'

# Enter Facebook login details and click login
browser.text_field(id: 'email').set '****'
browser.text_field(id: 'pass').set '****'
browser.button(type: 'submit').click

browser.wait_until { browser.h1.text == 'Match. Chat. Date.' }


