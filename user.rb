class User
  attr_accessor :original_tinder_json, :id, :name, :bio, :gender

  def self.build_from_tinder_json(tinder_json)
    user = self.new
    user.original_tinder_json = tinder_json
    user.id = tinder_json['_id']
    user.name = tinder_json['name']
    user.bio = tinder_json['bio']
    user.gender = tinder_json['gender'] == 0 ? :male : :female
    user
  end
end
