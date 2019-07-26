require 'sqlite3'

class DbConnection

  def initialize(f_name)
    @db = SQLite3::Database.open f_name
    @VMY = "VehicleModelYear"
  end

  def list(table_field)
    return_list = []
    tf = table_field.split('.')
    table, field = tf
    query = @db.prepare "SELECT DISTINCT(#{field}) FROM #{table};"
    result = query.execute

    result.each do |r|
      return_list.append(r[0].to_s)
    end

    return_list
  end

  def count(table_field)
    list(table_field).size
  end
end
