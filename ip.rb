require_relative 'secrets'
require 'rubygems'
require 'watir'
require 'webdrivers'

proxy = {
  http: '185.10.166.130:8080',
  ssl:  '185.10.166.130:8080'
}

browser = Watir::Browser.new :chrome, proxy: proxy
browser.goto url
browser.button(class: 'button Lts($ls-s) Z(0) CenterAlign Mx(a) Cur(p) Tt(u) Bdrs(100px) Px(24px) Px(20px)--s Py(0) Mih(54px) Pos(r) Ov(h) C(#fff) Bg($c-pink):h::b Bg($c-pink):f::b Bg($c-pink):a::b Trsdu($fast) Trsp($background) Bg($primary-gradient) button--primary-shadow StyledButton Fw($semibold) focus-button-style Mb(20px) W(100%) P(0)').click

# Enter Facebook login details and click login
browser.window(:title => /Facebook/).use do
  browser.text_field(id: 'email').set email
  browser.text_field(id: 'pass').set password
  browser.button(type: 'submit').click
  browser.wait_until { browser.h1.text == 'Match. Chat. Date.' }
end

browser.wait_until { browser.h1.text != 'Match. Chat. Date.' }
