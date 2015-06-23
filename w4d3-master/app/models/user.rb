# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string(255)
#  password_digest :string(255)
#  session_token   :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, :password_digest, presence: true
  validates :user_name, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token
  has_many(:cats)
  has_many(:requests, class_name: 'CatRentalRequest')

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_credentials(user_name, password)
    @user = User.find_by(user_name: user_name)
    @user.is_password?(password) ? @user : nil
  end

  def self.find_by_session_token(session_token)
    User.find_by(session_token: session_token)
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
