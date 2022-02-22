class App < ApplicationRecord
  acts_as_paranoid

  enum status: ['private_app', 'public_app'], _default: 'private_app'

  validates_presence_of :status
  validates_uniqueness_of :name

  belongs_to :data_source
  belongs_to :user
  has_many :pages, dependent: :destroy
  has_many :forms, dependent: :destroy
end
