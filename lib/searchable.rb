require_relative 'db_connection'
require_relative 'sql_object'

module Searchable
  def where(params)
    search_values = params.values

    where_line = params.keys.map do |key|
      "#{key} = ?"
    end.join(" AND ")

    results = DBConnection.execute(<<-SQL, *search_values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL

    parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
