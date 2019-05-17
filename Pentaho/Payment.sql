CREATE SCHEMA Payment;

DROP TABLE IF EXISTS Payment.dim_time;
CREATE TABLE Payment.dim_time(
    date_id int auto_increment,
    payment_date datetime,
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

DROP TABLE IF EXISTS Payment.fact_payment;
CREATE TABLE Payment.fact_payment (
    payment_id INT,
    date_id INT,
    cantidad_pagos_por_dia INT,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (date_id) REFERENCES dim_time(date_id)
);
