# frozen_string_literal: true

class Form < ApplicationRecord
  enum status: { "draft" => 0, "active" => 1 }

  belongs_to :app
  has_many :form_elements, dependent: :destroy
  validates :title, :form_query, presence: true
  delegate :data_source, to: :app
end
