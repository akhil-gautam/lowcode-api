class FormElement < ApplicationRecord
  belongs_to :form

  validates :field_order, uniqueness: { scope: :form_id }
  validates_presence_of :label, :db_column, :field_type, :field_order
end
