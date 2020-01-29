require 'watir'
require 'webdrivers'
require 'json'
require 'open-uri'
require 'faraday_middleware'
require_relative 'secrets'

class Client
  TINDER_API_URL = 'https://api.gotinder.com'
  CONNECTION_USER_AGENT = 'Tinder/7.5.3 (iPhone; iOS 10.3.2; Scale/2.00)'

  attr_accessor :connection, :logs_enabled

  def initiaize(options = {})
    @logs_enabled = options[:logs_enabled]
    build_connection
  end

  def build_connection
    @connection = Faraday.new(url: 'https://api.gotinder.com/') do |faraday|
      faraday.request :json
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
    @connection.headers[:user_agent] = CONNECTION_USER_AGENT
    @connection.headers[:content_type]= 'application/json'
    @connection
  end

  def sign_in1(authentication_token)
    @connection.headers['X-Auth-Token'] = authentication_token
    puts @connection.headers
  end

  def profile
    User.build_from_tinder_json(JSON.parse(@connection.get('profile').body))
  end

  def user(user_id)
    User.build_from_tinder_json JSON.parse(@connection.get("user/#{user_id}").body)['results']
  end

  def recommended_users
    json_results = JSON.parse(@connection.post('user/recs').body)['results']
    users = json_results.select { |r| r['name'] != 'Tinder Team' }.map { |r| User.build_from_tinder_json r } if json_results
    users || []
  end

end
