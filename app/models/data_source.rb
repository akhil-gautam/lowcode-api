# frozen_string_literal: true

class DataSource < ApplicationRecord
  enum source: { "postgres" => 0, "mysql" => 1 }

  has_many :apps, dependent: nil

  validates :source, presence: true
  validates :settings, presence: true
end
