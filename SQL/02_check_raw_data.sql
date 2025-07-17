-- Find duplicates in raw data
SELECT pizza_id, COUNT(*)
FROM raw_pizza_data
GROUP BY pizza_id
HAVING COUNT(*) > 1;

-- Check ingredient strings
SELECT DISTINCT TRIM(ingredient)
FROM (
  SELECT unnest(string_to_array(pizza_ingredients, ',')) AS ingredient
  FROM raw_pizza_data
);


-- Check if pizza_category and pizza_name is a one-to-many relationship
SELECT
    pizza_name,
    COUNT(DISTINCT pizza_category)
FROM
    raw_pizza_data
GROUP BY
    pizza_name
HAVING
    COUNT(DISTINCT pizza_category) > 1;