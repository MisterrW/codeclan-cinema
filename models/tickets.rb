require_relative('../db/sql_er')

class Ticket
  attr_reader :id
  def initialize( options )
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
    @id = options[:id].to_i if options[:id]
  end

  def save
    sql = "
    INSERT INTO tickets
    (customer_id, film_id)
    VALUES
    (#{@customer_id}, #{@film_id})
    returning *
    ;"
    result = SqlEr.run(sql)
    @id = result[0]['id'].to_i
  end

  def self.all
    sql = "
    SELECT * FROM tickets
    ;"
    result = SqlEr.run(sql)
    return result.map{ |hash| Ticket.new(hash) }
  end
end