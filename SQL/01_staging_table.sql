-- Staging table for csv
CREATE TABLE raw_pizza_data (
    pizza_id VARCHAR,
    order_id INT,
    pizza_name_id VARCHAR,
    quantity SMALLINT,
    order_date DATE,
    order_time TIME,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    pizza_size CHAR(5),
    pizza_category VARCHAR,
    pizza_ingredients TEXT,
    pizza_name VARCHAR
);