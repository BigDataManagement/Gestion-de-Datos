CREATE SCHEMA Pentaho;

DROP TABLE IF EXISTS Pentaho.dim_time;
CREATE TABLE Pentaho.dim_time(
    date_id int auto_increment,
    rental_date datetime,
    is_date date,
    full_date varchar(256),
    is_day int,
    is_month varchar(10),
	is_year int,
    is_quarter int,
    is_week int,
    day_of_month int,
    day_of_week int,
    day_of_year int,
    last_day_of_month date,
    is_weekday int,
    week_of_year int,
    PRIMARY KEY(date_id)
);

DROP TABLE IF EXISTS Pentaho.dim_customer;
CREATE TABLE Pentaho.dim_customer (
	customer_id INT,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    PRIMARY KEY(customer_id)
);

DROP TABLE IF EXISTS Pentaho.dim_film;
CREATE TABLE Pentaho.dim_film (
	film_id INT,
    title VARCHAR(45),
    category VARCHAR(45),
    rental_rate DECIMAL,
    PRIMARY KEY(film_id)
);

DROP TABLE IF EXISTS Pentaho.dim_store;
CREATE TABLE Pentaho.dim_store (
    store_id INT,
    address VARCHAR(50),
    address2 VARCHAR(50),
    district VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(45),
    postal_code  VARCHAR(10),
    PRIMARY KEY (store_id)
);

DROP TABLE IF EXISTS Pentaho.fact_rental;
CREATE TABLE Pentaho.fact_rental (
    rental_id INT,
    customer_id INT,
    store_id INT,
    film_id INT,
    date_id INT,
    cantidad_rentas_por_dia_del_mes INT,
    cantidad_rentas_por_ano INT,
    PRIMARY KEY (rental_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id), 
    FOREIGN KEY (film_id) REFERENCES dim_film(film_id), 
    FOREIGN KEY (date_id) REFERENCES dim_time(date_id)
);
