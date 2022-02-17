class DataSource < ApplicationRecord
  enum source: ['postgres', 'mysql']

  has_many :apps

  validates_presence_of :source
  validates_presence_of :settings
end
