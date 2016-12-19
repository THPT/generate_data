
CREATE TABLE categories (
	id serial PRIMARY KEY NOT NULL,
	category_name text
);

CREATE TABLE selling_items (
	id serial PRIMARY KEY NOT NULL,
	product_id text,
	quantity int, 
	revenue bigint, 
	net_revenue double precision,
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
	location text,
	created_at timestamp WITH time ZONE
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

CREATE TABLE user_statistics (
	id serial PRIMARY KEY NOT NULL,
	user_id int,
	order_date timestamp with time zone,
	spend double precision
);

CREATE TABLE user_actives (
	id serial PRIMARY KEY NOT NULL,
	uuid text,
	created_at timestamp with time zone
);

CREATE TABLE device_usages (
	id serial PRIMARY KEY NOT NULL,
	device_family text,
	created_at timestamp WITH time ZONE,
	time_usage bigint
);

CREATE TABLE device_sellings (
	id serial PRIMARY KEY NOT NULL,
	device_family text,
	product_id text,
	created_at timestamp WITH time ZONE,
	time_usage bigint
);

CREATE TABLE video_sellings (
	id serial PRIMARY KEY NOT NULL,
	video_id text,
	amount BIGINT,
	created_at timestamp WITH time ZONE
);

CREATE TABLE video_view_counts (
	id serial PRIMARY KEY NOT NULL,
	video_id text,
	view_count BIGINT,
	created_at timestamp WITH time zone
);

CREATE TABLE videos (
	video_id varchar(50),
	url varchar(250),
	category varchar(200),
	title varchar(1000),
	description varchar(2000),
	thumbnail_image varchar(250),
	published_time  timestamp WITH time zone,
	channel_id varchar(50),
	channel_title varchar(500),
	product_id varchar(50)
);