-- sale_order table ---------------------
INSERT
	INTO
	sale_order (order_id,
	order_date,
	order_time)
SELECT
	DISTINCT order_id,
	-- Handle different date formats
    CASE
		WHEN order_date LIKE '%/%' THEN TO_DATE(order_date, 'MM/DD/YYYY')
		WHEN order_date LIKE '%-%' THEN TO_DATE(order_date, 'DD-MM-YYYY')
		ELSE NULL
	END AS formatted_date,
	order_time::TIME
FROM
	raw_pizza_data;

-- category table ---------------------
INSERT
	INTO
	category (category_name)
SELECT
	DISTINCT pizza_category
FROM
	raw_pizza_data;

-- pizza_type table ---------------------
INSERT
	INTO
	pizza_type (pizza_name,
	category_id)
SELECT
	DISTINCT r.pizza_name,
	c.category_id
FROM
	raw_pizza_data r
JOIN category c ON
	r.pizza_category = c.category_name;

-- pizza table ---------------------
INSERT
	INTO
	pizza (pizza_type_id,
	size,
	unit_price)
SELECT
	DISTINCT pt.pizza_type_id,
	r.pizza_size,
	r.unit_price
FROM
	raw_pizza_data r
JOIN pizza_type pt ON
	r.pizza_name = pt.pizza_name;

-- order_item table ---------------------
INSERT
	INTO
	order_item (item_id,
	order_id,
	pizza_id,
	quantity,
	total_price)
SELECT
	r.pizza_id,
	r.order_id,
	p.pizza_id,
	r.quantity,
	r.total_price
FROM
	raw_pizza_data r
JOIN pizza_type pt ON
	r.pizza_name = pt.pizza_name
JOIN pizza p ON
	p.pizza_type_id = pt.pizza_type_id
	AND p.size = r.pizza_size;

-- ingredient table ---------------------
INSERT
	INTO
	ingredient (ingredient_name)
SELECT
	DISTINCT TRIM(ingr)
FROM
	(
	SELECT
		UNNEST(string_to_array(pizza_ingredients, ',')) AS ingr
	FROM
		raw_pizza_data
) sub;

-- pizza_ingredient table ---------------------
INSERT
	INTO
	pizza_ingredient (pizza_type_id,
	ingredient_id)
SELECT
	DISTINCT pt.pizza_type_id,
	i.ingredient_id
FROM
	raw_pizza_data r
JOIN pizza_type pt ON
	r.pizza_name = pt.pizza_name
JOIN LATERAL UNNEST(string_to_array(r.pizza_ingredients, ',')) AS ingr(ingredient)
    ON
	TRUE
JOIN ingredient i ON
	TRIM(ingr.ingredient) = i.ingredient_name;