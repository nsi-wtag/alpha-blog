# frozen_string_literal: true

require_relative 'concerns/email_validation'

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 },
                    format: { with: EmailValidator::VALID_EMAIL_REGEX }
  has_secure_password
end
