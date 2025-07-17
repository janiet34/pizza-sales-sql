DROP TABLE IF EXISTS sale_order,
category,
pizza_type,
pizza,
order_item,
ingredient,
pizza_ingredient CASCADE;

-- Each order made from a customer
CREATE TABLE sale_order (
	order_id INT PRIMARY KEY,
    order_date DATE,
    order_time TIME
);

-- Category of pizzas i.e. Classic vs Veggie Pizzas
CREATE TABLE category(
	category_id smallserial PRIMARY KEY,
	category_name VARCHAR(50) NOT NULL
);

-- Type of pizza with a specific set of ingredients
CREATE TABLE pizza_type(
	pizza_type_id smallserial PRIMARY KEY,
	pizza_name varchar(50) NOT NULL,
	category_id int,
	FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- Type of pizza + size
-- pizza_id is raw_pizza_id(pizza_name_id)
CREATE TABLE pizza (
	pizza_id serial PRIMARY KEY,
	pizza_type_id INT,
	SIZE CHAR(5),
	unit_price DECIMAL(10, 2),
	FOREIGN KEY (pizza_type_id) REFERENCES pizza_type(pizza_type_id)
);

-- Each item/pizza in an order
-- item_id is raw_pizza_data(pizza_id)
CREATE TABLE order_item (
	item_id INT PRIMARY KEY,
	order_id INT,
	pizza_id INT,
	quantity SMALLINT,
	total_price DECIMAL(10, 2),
	FOREIGN KEY (order_id) REFERENCES sale_order(order_id),
	FOREIGN KEY (pizza_id) REFERENCES pizza(pizza_id)
);

-- raw_pizza_data(pizza_ingredients) will be separated
CREATE TABLE ingredient(
	ingredient_id SMALLSERIAL PRIMARY KEY,
	ingredient_name varchar(30)
);

-- Set of ingredients for each pizza type
CREATE TABLE pizza_ingredient(
	pizza_type_id INT,
	ingredient_id INT,
	PRIMARY KEY (pizza_type_id, ingredient_id),
	FOREIGN KEY (pizza_type_id) REFERENCES pizza_type(pizza_type_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id)
);
