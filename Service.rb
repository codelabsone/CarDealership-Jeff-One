# this code is to capture the sales staff

class Service_Team
  attr_accessor :name, :email, :phone

  def initialize(name, email, phone)
    @name = name
    @email = email
    @phone = phone
  end

  def to_s
    "#{@name}, #{@email}, #{@phone}"
  end
end

class Service_Team1
  def initialize
    @service = []
  end

  def add_service(a_service)
    @service << a_service
  end

  def play
    puts "\nMeet our Service team:\n "
    @service.each do |service|
      puts service
    end
  end
end

service1 = Service_Team.new("Dustin", "Dustin@bling.com", "573-225-1234").to_s
service2 = Service_Team.new("Debbie", "Debbie@bling.com", "573-225-9876").to_s

service = Service_Team1.new
service.add_service(service1)
service.add_service(service2)
service.play
