require_relative('../db/sql_er')

class Customer
  attr_accessor :name, :funds
  def initialize( options )
    @name = options["name"]
    @funds = options["funds"].to_i
    @id = options["id"].to_i if options["id"]
  end

  def save
    sql = "
    INSERT INTO customers
    (name, funds)
    VALUES
    ('#{@name}', #{@funds})
    returning *
    ;"
    result = SqlEr.run(sql)
    @id = result[0]['id'].to_i
  end

  def self.all
    sql = "
    SELECT * FROM customers
    ;"
    result = SqlEr.run(sql)
    return result.map{ |hash| Customer.new(hash) }
  end
  
end