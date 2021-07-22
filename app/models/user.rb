class User < ApplicationRecord
  attr_accessor :password

  before_save :encrypt_password

  private

  def encrypt_password
    return unless password.present? && !password.blank?

    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end
end
