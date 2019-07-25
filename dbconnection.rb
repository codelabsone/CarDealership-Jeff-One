require 'sqlite3'

class DbConnection

  def initialize(f_name)
    @db = SQLite3::Database.open f_name
    @VMY = "VehicleModelYear"
  end

  def list(field)
    return_list = []
    query = @db.prepare "SELECT DISTINCT(#{field}) FROM #{@VMY};"
    result = query.execute

    result.each do |r|
      return_list.append(r[0].to_s)
    end

    return_list
  end

  def count(field)
    res = self.list(field)
    res.size
  end
end
