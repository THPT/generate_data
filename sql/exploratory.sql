
--Top best-selling items by age-group
SELECT product_id, count(1)
FROM product_ages
WHERE age > 20 AND age < 30
GROUP BY product_id
ORDER BY count(1) DESC