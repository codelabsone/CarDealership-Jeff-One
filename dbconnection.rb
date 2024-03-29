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
    insert_query_string += " VALUES (#{c.id}, #{'%.2f' % c.msrp}, #{'%.2f' % c.sale_price}, #{c.is_new}, #{c.mileage}, #{c.door_count}, '#{c.engine}', '#{c.transmission}', '#{c.body_style}', '#{c.color}', '#{c.description}');"
    query = @db.prepare insert_query_string
    query.execute
  end

  def create_car_from_row(row)
    vmy = Vmy.new(row['year'], row['make'], row['model'])
    car = Car.new(vmy)
    car.msrp = row['msrp']
    car.sale_price = row['sale_price']
    car.is_new = row['new']
    car.mileage = row['mileage']
    car.door_count = row['door_count']
    car.engine = row['engine']
    car.transmission = row['transmission']
    car.body_style = row['body_style']
    car.color = row['color']
    car.description = row['description']

    car
  end

  def construct_where_clause(filters)
    clause = ''
    if filters.length > 0 # for at least one filter, add the where clause
      clause += ' WHERE'
      filters.keys.each do |key|

        clause += ' ('
        # For each set of filters by type/key
        filters[key].each do |filter|
          # for each filter of the type, add the clause
          clause += filter.clause

          if filter != filters[key].last
            # add OR operator if not the last of this filter type
            clause += ' OR'
          else
            clause += ')'
          end

        end

        if key != filters.keys.last

          # add AND operator if not the last filter type
          clause += ' AND'
        end

      end
    end
    clause # return the clause string
  end

  def create_select_query(filters, table_name)
    if table_name == 'inventory'
      base_query = "SELECT inventory.*, VehicleModelYear.* FROM inventory JOIN VehicleModelYear ON inventory.vmy_id = VehicleModelYear.id"
    elsif table_name == 'VehicleModelYear'
      base_query = "SELECT * FROM VehicleModelYear"
    end
    base_query += construct_where_clause(filters)
    base_query += ';'
    base_query
  end

  def get_cars(filters)
    cars = []
    query_string = create_select_query(filters, "inventory")
    query = @db.prepare query_string
    rows = query.execute
    rows.each do |row|
      cars.append(create_car_from_row(row))
    end
    cars
  end

  def get_models(filters)
    models = []
    query_string = create_select_query(filters, "VehicleModelYear")
    query = @db.prepare query_string
    rows = query.execute
    rows.each do |row|
      models.append(row["model"])
    end
    models
  end

end
