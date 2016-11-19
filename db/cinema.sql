DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE customers (
  name VARCHAR(255),
  funds INT2,
  id SERIAL8 primary key
);

CREATE TABLE films (
  title VARCHAR(255),
  price INT2,
  id SERIAL8 primary key
);

CREATE TABLE tickets (
  customer_id INT8 references customers(id),  
  film_id INT8 references films(id)
);