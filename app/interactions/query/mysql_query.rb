class MysqlQuery < ActiveInteraction::Base
  object :data_source, class: DataSource
  string :db_query

  validates :db_query, :data_source, presence: true

  def execute
    ActiveRecord::Base.transaction do
      username = data_source.settings.delete('user')
      connection = Mysql2::Client.new(data_source.settings.merge({ username: username }))
      connection.query(db_query).to_a
    end
  end
end
