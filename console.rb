require('pry-byebug')
require_relative('models/customers')
require_relative('models/films')
require_relative('models/tickets')

customer1 = Customer.new({
  "name" => "Bob",
  "funds" => 30
  })

customer1.save


film1 = Film.new({
  "title" => "Rogue One",
  "price" => 8.5
  })

film1.save

ticket1 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film1.id
  })

ticket1.save

binding.pry
nil