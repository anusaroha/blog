class User < ActiveRecord::Base

  has_many :likes, dependent: :destroy
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :last_name, presence: true
  validates :first_name, presence: true
  # validates :password, presence: true

  before_create {generate_token(:auth_token)}

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.create_from_twitter(twitter_data)
    user = User.new
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end


  attr_accessor :abc

end
