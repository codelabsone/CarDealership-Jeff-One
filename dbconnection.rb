require 'sqlite3'
require_relative 'vmy'
require_relative 'car'

class DbConnection

  def initialize(f_name)
    @db = SQLite3::Database.open f_name
    @db.results_as_hash = true
  end

  def list(table_field)
    return_list = []
    tf = table_field.split('.')
    table, field = tf
    query = @db.prepare "SELECT DISTINCT(#{field}) FROM #{table};"
    result = query.execute

    result.each do |r|
      return_list.append(r[field].to_s)
    end

    return_list
  end

  def count(table_field)
    list(table_field).size
  end

  def get_vmy_id(vmy)
    rtn = nil
    q_str = "SELECT id FROM VehicleModelYear WHERE year=#{vmy.year.to_i} AND make='#{vmy.make}' and model='#{vmy.model}';"
    puts q_str
    query = @db.prepare q_str
    result = query.execute

    result.each do |r|
      rtn = r['id']
    end

    rtn
  end

  def get_vmy()
    return_list = []
    query = @db.prepare "SELECT * FROM VehicleModelYear;"
    results = query.execute
    results.each do |result|
      return_list.append(Vmy.new(result['year'], result['make'], result['model']))
      return_list[return_list.length-1].id = result['id']
    end
    return_list
  end

  def add_car(c)
    insert_query_string = "INSERT INTO inventory (vmy_id, msrp, sale_price, new, mileage, door_count, engine, transmission, body_style, color, description)"
    insert_query_string += " VALUES (#{c.vmy.id}, #{'%.2f' % c.msrp}, #{'%.2f' % c.sale_price}, #{c.is_new}, #{c.mileage}, #{c.door_count}, '#{c.engine}', '#{c.transmission}', '#{c.body_style}', '#{c.color}', '#{c.description}');"
    query = @db.prepare insert_query_string
    query.execute
  end


end
