class User < ApplicationRecord

before_create :generate_api_key
has_secure_password
before_validation :downcase_email

has_many :goals, dependent: :destroy

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

validates :first_name, presence: true
validates :last_name, presence: true

validates :email, presence: true,
                  uniqueness: { case_sensitive: false },
                  format: VALID_EMAIL_REGEX,
                  unless: :from_oauth?

  def full_name
    "#{first_name} #{last_name}".strip.squeeze(' ').titleize
  end

  def signed_in_with_twitter?
    uid.present? && provider == 'twitter'
  end

  def signed_in_with_facebook?
    uid.present? && provider == 'facebook'
  end

  def from_oauth?
    provider.present? && uid.present?
  end

  def self.create_from_oauth(oauth_data)
    full_name = oauth_data['info']['name'].split()
    user = User.create first_name: full_name[0],
                        last_name: full_name[1],
                        email:     oauth_data['info']['email'],
                        password:  SecureRandom.hex(32),
                        provider:  oauth_data['provider'],
                        uid:       oauth_data['uid'],
                        oauth_token: oauth_data['credentials']['token'],
                        oauth_secret: oauth_data['credentials']['secret'],
                        oauth_raw_data: oauth_data
  end

  def self.find_from_oauth(oauth_data)
    User.where(provider: oauth_data['provider'],
                    uid: oauth_data['uid']).first
  end

  def generate_api_key
    self.api_key = SecureRandom.hex(32)
    loop do
      if User.exists?(api_key: api_key)
        self.api_key = SecureRandom.hex(32)
      else
        break
      end
    end
  end

  private
  def downcase_email
    self.email.downcase! if email.present?
  end
end
