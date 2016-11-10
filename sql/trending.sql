--Top best-selling
SELECT product_id, sum(quantity) AS total
FROM selling_items
GROUP BY product_id
ORDER BY total DESC

--Top best-selling BY category
SELECT product_id, sum(quantity) AS total
FROM selling_items
JOIN products ON selling_items.product_id = products.id
WHERE products.category = 'Các loại tai nghe'
GROUP BY product_id
ORDER BY total DESC

--Top best-selling BY DAY
SELECT product_id, sum(quantity) AS total
FROM selling_items
WHERE order_date = '2015-12-31 00:00:00'
GROUP BY product_id
ORDER BY total DESC

--Top best-selling BY MONTH
SELECT product_id, sum(quantity) AS total
FROM selling_items
WHERE date_trunc('month', order_date) = date_trunc('month', timestamp '2016-01-01 00:00:00')
GROUP BY product_id
ORDER BY total DESC

--Top best-selling BY QUARTER
SELECT product_id, sum(quantity) AS total
FROM selling_items
WHERE date_trunc('quarter', order_date) = date_trunc('quarter', timestamp '2016-12-01 00:00:00')
GROUP BY product_id
ORDER BY total DESC
