# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :apps
  has_many :data_sources

  validates :email, uniqueness: true
end
