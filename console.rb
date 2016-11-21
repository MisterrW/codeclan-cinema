require('pry-byebug')
require_relative('models/customers')
require_relative('models/films')
require_relative('models/tickets')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({
  "name" => "Zaphod Beeblebrox",
  "funds" => 30
  })

customer2 = Customer.new({
  "name" => "Trisha McMillan",
  "funds" => 25
  })

customer3 = Customer.new({
  "name" => "Ford Prefect",
  "funds" => 50
  })

customer1.save
customer2.save
customer3.save

binding.pry

film1 = Film.new({
  "title" => "Rogue One",
  "price" => 8.5
  })

film2 = Film.new({
  "title" => "A New Hope",
  "price" => 7
  })

film3 = Film.new({
  "title" => "The Empire Strikes Back",
  "price" => 9
  })

film4 = Film.new({
  "title" => "The Force Awakens",
  "price" => 8
  })

film1.save
film2.save
film3.save
film4.save

ticket1 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film1.id,
  "film_time" => "19:00"
  })

ticket2 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film2.id,
  "film_time" => "21:00"
  })

ticket3 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film1.id,
  "film_time" => "19:00"
  })

ticket4 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film1.id,
  "film_time" => "23:00"
  })

ticket5 = Ticket.new({
  "customer_id" => customer3.id,
  "film_id" => film3.id,
  "film_time" => "12:30"
  })

ticket6 = Ticket.new({
  "customer_id" => customer3.id,
  "film_id" => film4.id,
  "film_time" => "17:00"
  })


ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()

puts Ticket.all()

binding.pry

puts Ticket.most_popular_time("Rogue One")


nil