# frozen_string_literal: true

class PostgresQuery < ActiveInteraction::Base
  object :data_source, class: DataSource
  string :db_query

  validates :db_query, :data_source, presence: true

  def execute
    ActiveRecord::Base.transaction do
      connection = PG.connect(data_source.settings)
      connection.exec(db_query).to_a
    end
  end
end
