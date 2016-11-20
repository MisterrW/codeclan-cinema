require('pry-byebug')
require_relative('models/customers')
require_relative('models/films')
require_relative('models/tickets')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({
  "name" => "Bob",
  "funds" => 30
  })

customer2 = Customer.new({
  "name" => "Alice",
  "funds" => 25
  })

customer3 = Customer.new({
  "name" => "Ford",
  "funds" => 50
  })

customer1.save
customer2.save
customer3.save

film1 = Film.new({
  "title" => "Rogue One",
  "price" => 8.5
  })

film2 = Film.new({
  "title" => "A new hope",
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
  "film_id" => film1.id
  })

ticket1.save
ticket1.save
ticket1.save
ticket1.save

binding.pry
nil