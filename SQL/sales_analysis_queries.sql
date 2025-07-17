-- Total revenue of all orders
SELECT
	SUM(total_price) AS total_revenue
FROM
	order_item;

-- Best selling pizzas
SELECT
	pt.pizza_name,
	SUM(oi.quantity) AS total_sold
FROM
	order_item oi
JOIN pizza p ON
	oi.pizza_id = p.pizza_id
JOIN pizza_type pt ON
	p.pizza_type_id = pt.pizza_type_id
GROUP BY
	pt.pizza_name
ORDER BY
	total_sold DESC
LIMIT 5;

-- Worst selling pizzas
SELECT
	pt.pizza_name,
	SUM(oi.quantity) AS total_sold
FROM
	order_item oi
JOIN pizza p ON
	oi.pizza_id = p.pizza_id
JOIN pizza_type pt ON
	p.pizza_type_id = pt.pizza_type_id
GROUP BY
	pt.pizza_name
ORDER BY
	total_sold ASC
LIMIT 5;

-- Top ingredient usage
SELECT
	i.ingredient_name,
	COUNT(*) AS usage_count
FROM
	pizza_ingredient pi
JOIN ingredient i ON
	pi.ingredient_id = i.ingredient_id
GROUP BY
	i.ingredient_name
ORDER BY
	usage_count DESC
LIMIT 10;