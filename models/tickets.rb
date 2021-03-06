require('time')
require_relative('../db/sql_er')

class Ticket
  attr_reader :id
  def initialize( options )
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
    @id = options['id'].to_i if options['id']
    @time = Time.parse(options['film_time'])
  end

  def get_film_price()
    sql = "
    SELECT price FROM films
    WHERE id = #{@film_id}
    ;"
    result = SqlEr.run(sql)
    return result[0]['price'].to_i
  end

  def decrease_customer_funds(amount)
    sql = "
    UPDATE customers
    SET (funds) = (funds - #{amount})
    WHERE id = #{@customer_id}
    ;"
    SqlEr.run(sql)
  end

  def save
    cost = get_film_price()
    decrease_customer_funds(cost)
    sql = "
    INSERT INTO tickets
    (customer_id, film_id, film_time)
    VALUES
    (#{@customer_id}, #{@film_id}, '#{@time}')
    returning *
    ;"
    result = SqlEr.run(sql)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "
    UPDATE tickets
    SET (customer_id, film_id, film_time) = (#{@customer_id}, #{@film_id}, '#{@time}') 
    WHERE id = #{@id}
    ;"
    SqlEr.run(sql)
  end

  def delete()
    return unless @id
    sql = "
    DELETE FROM tickets WHERE id = #{@id}
    ;"
    SqlEr.run(sql)
  end

  def self.delete_all()
    sql = "
    DELETE FROM tickets
    ;"
    SqlEr.run(sql)
  end

  def self.all()
    sql = '
    SELECT c.name AS "Customer",
    f.title AS "Film",
    t.film_time AS "Time"
    FROM customers c
    INNER JOIN tickets t
    ON c.id = t.customer_id
    INNER JOIN films f
    ON f.id = t.film_id
    ;'
    result = SqlEr.run(sql)
    result.each do |result|
        puts "Customer: #{result['Customer']}"
        puts "Film: #{result['Film']}"
        puts "Time: #{result['Time']}"
        puts ""
    end
  end

  def self.number_tickets_bought_by_customer(customer_id)
    sql = "
    SELECT * FROM tickets
    WHERE customer_id = #{customer_id}
    ;"
    result = SqlEr.run(sql)
    result2 = result.map{ |hash| Ticket.new(hash) }
    return result2.length
  end

  def self.number_tickets_bought_for_film(film_id)
    sql = "
    SELECT * FROM tickets
    WHERE film_id = #{film_id}
    ;"
    result = SqlEr.run(sql)
    result2 = result.map{ |hash| Ticket.new(hash) }
    return result2.length
  end

  def self.most_popular_time(film_title)
    sql1 = "
    SELECT * from films 
    WHERE title = '#{film_title}'
    ;"
    film_record = SqlEr.run(sql1)
    id_for_query = film_record[0]['id']
    
    sql2 = "
    SELECT film_time
    FROM tickets
    WHERE film_id = #{id_for_query}
    GROUP BY film_time
    ORDER BY count(*) DESC
    LIMIT 1
    ;"
    result = SqlEr.run(sql2)

    return "The most popular showtime for #{film_title} is #{result[0]["film_time"]}"
  end

end
