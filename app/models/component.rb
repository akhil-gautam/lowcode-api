class Component < ApplicationRecord
  enum component_type: ['datatable', 'cards_list', 'chart', 'detail']

  belongs_to :page
  has_one :data_source, through: :page

  validates_presence_of :component_type
  validates_presence_of :component_query
  validates :component_order, uniqueness: { scope: :page_id }, presence: true

  default_scope  { order(:component_order => :asc) }

  delegate :user, to: :page
end
