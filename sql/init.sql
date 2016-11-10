CREATE TABLE categories (
	id serial PRIMARY KEY NOT NULL,
	category_name text
);

CREATE TABLE selling_items (
	id serial PRIMARY KEY NOT NULL,
	product_id text,
	quantity int, 
	revenue bigint, 
	net_revenue double,
	order_date timestamp with time zone
);

CREATE TABLE products (
	id text PRIMARY KEY NOT NULL,
	product_name text,
	price       bigint,
	subcategory text,
	category    text,
	store_id     int
);

CREATE TABLE stores (
	id serial PRIMARY KEY NOT NULL,
	category_name text,
	user_id int
);

CREATE TABLE users (
	id serial PRIMARY KEY NOT NULL,
	age int,
	gender int, 
	location text
);

CREATE TABLE product_ages (
	id serial PRIMARY KEY NOT NULL,
	product_id text,
	age int
);

CREATE TABLE order_statistics (
	id serial PRIMARY KEY NOT NULL,
	store_id int,
	order_date timestamp with time zone,
	revenue bigint,
	total_order int
);