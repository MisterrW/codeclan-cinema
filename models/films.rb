require_relative('../db/sql_er')

class Film
  attr_accessor :title, :price
  attr_reader :id
  def initialize( options )
    @title = options['title']
    @price = options['price'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "
    INSERT INTO films
    (title, price)
    VALUES
    ('#{@title}', #{@price})
    returning *
    ;"
    result = SqlEr.run(sql)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "
    UPDATE films
    SET (title, price) = ('#{@title}', #{@price}) WHERE id = #{@id}
    ;"
    SqlEr.run(sql)
  end

  def delete()
    return unless @id
    sql = "
    DELETE FROM films WHERE id = #{@id}
    ;"
    SqlEr.run(sql)
  end

  def self.delete_all()
    sql = "
    DELETE FROM films
    ;"
    SqlEr.run(sql)
  end

  def self.all
    sql = "
    SELECT * FROM films
    ;"
    result = SqlEr.run(sql)
    return result.map{ |hash| Film.new(hash) }
  end
end

# update
# delete