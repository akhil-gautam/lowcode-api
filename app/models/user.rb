class User < ApplicationRecord
  has_secure_password
  has_many :apps
  has_many :data_sources

  validates_uniqueness_of :email
end
