-- Temp table
CREATE TEMPORARY TABLE day_sales AS
SELECT
	order_date,
	COUNT(*) AS sales
FROM
	sale_order s
JOIN order_item o ON
	s.order_id = o.order_id
GROUP BY
	order_date;

-- Best selling days
SELECT *
FROM day_sales
ORDER BY sales DESC
LIMIT 5;

-- Worst selling days
SELECT *
FROM day_sales
ORDER BY sales ASC
LIMIT 5;

-- Day of week that has most orders
SELECT
	TO_CHAR(order_date, 'Day') AS day_of_week,
	COUNT(*) AS total_orders
FROM
	sale_order
GROUP BY
	day_of_week
ORDER BY
	total_orders DESC;

-- Hour of day with most orders
SELECT
	date_trunc('hour', order_time) AS HOUR,
	COUNT(*) AS total_orders
FROM
	sale_order
GROUP BY
	HOUR
ORDER BY
	total_orders DESC;
