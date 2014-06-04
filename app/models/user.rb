class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, omniauth_providers: [:facebook, :vkontakte]
  has_many :posts, dependent: :destroy

  validates :username, length: {in: 4..20}


  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
    end
  end

 def self.find_for_vkontakte_oauth auth
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.extra.raw_info.screen_name + '@vk.com'
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
    end
  end
end
