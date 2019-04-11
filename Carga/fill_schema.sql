INSERT INTO olap.dim_time
SELECT DISTINCT
	NULL AS date_id,
	r.rental_date AS rental_date,
    DATE(r.rental_date) AS is_date,
    DATE_FORMAT(r.rental_date, '%Y%M%D') AS full_date_description,
    DAY(r.rental_date) AS is_day,
    MONTH(r.rental_date) AS is_month,
    YEAR(r.rental_date) AS is_year,
    QUARTER(r.rental_date) AS is_quarter,
	WEEK(r.rental_date) AS  is_week,
    DAYOFMONTH(r.rental_date) AS day_of_month,
    DAYOFWEEK(r.rental_date) AS day_of_week,
	DAYOFYEAR(r.rental_date) AS day_of_year,
	LAST_DAY(r.rental_date) AS last_day_of_month,
	WEEKDAY(r.rental_date) AS is_weekday,
	WEEKOFYEAR(r.rental_date) AS week_of_year
FROM sakila.rental AS r;

INSERT INTO olap.dim_customer
SELECT c.customer_id, c.first_name, c.last_name 
FROM sakila.customer AS c;

INSERT INTO olap.dim_film
SELECT film.film_id, film.title, category.name, film.rental_rate
FROM sakila.film AS film
INNER JOIN sakila.film_category AS film_category ON film.film_id = film_category.film_id
INNER JOIN sakila.category AS category ON film_category.category_id = category.category_id;

INSERT INTO olap.dim_store
SELECT store.store_id, address.address, address.address2, 
	   address.district, city.city, country.country, address.postal_code
FROM sakila.store  AS store
INNER JOIN sakila.address AS address ON store.address_id = address.address_id
INNER JOIN sakila.city AS city ON address.city_id = city.city_id
INNER JOIN sakila.country AS country ON city.country_id = country.country_id;

INSERT INTO olap.fact_rental
SELECT sakila.rental.rental_id, olap.dim_customer.customer_id, olap.dim_store.store_id, olap.dim_film.film_id, olap.dim_time.date_id, 0, 0, 0, 0
FROM sakila.rental
INNER JOIN olap.dim_customer ON sakila.rental.customer_id = olap.dim_customer.customer_id
INNER JOIN sakila.customer ON sakila.customer.customer_id = sakila.rental.customer_id
INNER JOIN sakila.store ON sakila.store.store_id = sakila.customer.store_id
INNER JOIN olap.dim_store ON sakila.store.store_id = olap.dim_store.store_id
INNER JOIN sakila.inventory ON sakila.inventory.inventory_id = sakila.rental.inventory_id
INNER JOIN sakila.film ON sakila.inventory.film_id =  sakila.film.film_id
INNER JOIN olap.dim_film ON sakila.film.film_id = olap.dim_film.film_id
INNER JOIN olap.dim_time ON sakila.rental.rental_date = olap.dim_time.rental_date;