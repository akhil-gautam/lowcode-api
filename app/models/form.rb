class Form < ApplicationRecord
  enum status: ['draft', 'active']

  belongs_to :app
  has_many :form_elements, dependent: :destroy
  validates_presence_of :title, :form_query
  delegate :data_source, to: :app
end
