class Page < ApplicationRecord
  acts_as_paranoid

  belongs_to :app
  has_one :data_source, through: :app
  has_many :components, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :page_order
  validates :page_order, uniqueness: { scope: :app_id }

  default_scope  { order(:page_order => :asc) }

  delegate :user, to: :app
end
