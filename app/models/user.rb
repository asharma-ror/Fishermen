class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :monsters
  has_many :teams
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates_uniqueness_of :email, scope: :provider

  def self.from_omniauth(auth)
    email = auth.info.email
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end
end
