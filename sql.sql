-- (SQL Server / Oracle / MS Access)
/* ***********************************
/ Creation Section 
/* ***********************************/

-- create database
CREATE DATABASE test;

-- create users table
CREATE TABLE users (
    id int NOT NULL PRIMARY KEY,
    first_name varchar(255) NOT NULL,
    last_name varchar(255),
    age int
);

-- create products table
CREATE TABLE products (
    id int NOT NULL PRIMARY KEY,
    name varchar(255) NOT NULL,
    price decimal(10,2) NOT NULL,
    qty int NOT NULL
);

-- create orders table
CREATE TABLE orders (
    id int NOT NULL PRIMARY KEY,
    user_id int NOT NULL,
    order_number varchar(255) NOT NULL,
    order_date Date NOT NULL,

    CONSTRAINT FK_UserOrder FOREIGN KEY (user_id) REFERENCES users(id)
);

-- create order_histories table
CREATE TABLE order_histories (
    id int NOT NULL PRIMARY KEY,
    order_id int NOT NULL,
    product_id int NOT NULL,
    qty int NOT NULL,

    CONSTRAINT FK_OrderId FOREIGN KEY (order_id) REFERENCES orders(id),
    CONSTRAINT FK_ProductId FOREIGN KEY (product_id) REFERENCES products(id)
);


/* ***********************************
/ Insertion Section 
/* ***********************************/

-- in users table
INSERT INTO users (id, first_name, last_name, age) VALUES (1, 'Rahim', 'Hossain', '25');
INSERT INTO users (id, first_name, last_name, age) VALUES (2, 'Karim', '', '20');
INSERT INTO users (id, first_name, last_name, age) VALUES (3, 'Habib', '', '23');
INSERT INTO users (id, first_name, last_name, age) VALUES (4, 'Asif', '', '23');
INSERT INTO users (id, first_name, last_name, age) VALUES (5, 'Rizve', '', '21');

-- in products table
INSERT INTO products (id, name, price, qty) VALUES (1, 'wallet', '500', '10');
INSERT INTO products (id, name, price, qty) VALUES (2, 'belt', '800', '15');
INSERT INTO products (id, name, price, qty) VALUES (3, 'shoe', '1000', '17');
INSERT INTO products (id, name, price, qty) VALUES (4, 'bag', '1200', '8');

-- in orders table
INSERT INTO orders (id, user_id, order_number, order_date) VALUES (1, 2, '001', '2022-10-01');
INSERT INTO order_histories (id, order_id, product_id, qty) VALUES (1, 1, 1, 2);

INSERT INTO orders (id, user_id, order_number, order_date) VALUES (2, 3, '002', '2022-10-02');
INSERT INTO order_histories (id, order_id, product_id, qty) VALUES (2, 2, 3, 1);

INSERT INTO orders (id, user_id, order_number, order_date) VALUES (3, 4, '003', '2022-10-04');
INSERT INTO order_histories (id, order_id, product_id, qty) VALUES (3, 3, 4, 3);

/* ***********************************
/ some queries Section 
/* ***********************************/

-- get all data from a table
SELECT * FROM users;
SELECT * FROM products;

-- get specific data from a table
SELECT last_name, age FROM users;
SELECT name, qty FROM products;


/* ***********************************
/ joins Section 
/* ***********************************/

-- inner join
SELECT orders.order_number, users.first_name, orders.order_date
    FROM orders
        INNER JOIN users ON orders.user_id = users.id;

-- left join
SELECT users.first_name, orders.order_number, orders.order_date
    FROM users
        LEFT JOIN orders ON users.id = orders.user_id;


-- left join
SELECT users.first_name, orders.order_number, orders.order_date
    FROM users
        RIGHT JOIN orders ON users.id = orders.user_id;

/* ***********************************
/ some aggregate function
/* ***********************************/

-- get total order count
SELECT COUNT(id) FROM orders;

-- get total order qty sum
SELECT SUM(order_histories.qty) 
    FROM orders
        LEFT JOIN order_histories ON orders.id = order_histories.order_id;

-- get total order price sum
SELECT SUM(products.price) 
    FROM orders
        LEFT JOIN order_histories ON orders.id = order_histories.order_id
        LEFT JOIN products ON order_histories.product_id = products.id;


/* ***********************************
/ ALTER section
/* ***********************************/
ALTER TABLE users ADD Email varchar(255);

ALTER TABLE users DROP COLUMN Email;

-- DROP DATABASE test;