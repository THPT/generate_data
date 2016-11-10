
--Order this week
SELECT sum(total_order)
FROM order_statistics
WHERE date_trunc('week', order_date) = date_trunc('week', timestamp '2016-01-01 00:00:00')
--WHERE store_id=?

--Order this month
SELECT sum(total_order)
FROM order_statistics
WHERE date_trunc('month', order_date) = date_trunc('month', timestamp '2016-01-01 00:00:00')
--WHERE store_id=?

--Total order
SELECT sum(total_order)
FROM order_statistics

--Revenue earn today
SELECT sum(revenue) 
FROM order_statistics
WHERE date_trunc('day', order_date) = date_trunc('day', timestamp '2016-01-01 00:00:00')

--Revenue earn month
SELECT sum(revenue) 
FROM order_statistics
WHERE date_trunc('month', order_date) = date_trunc('month', timestamp '2016-01-01 00:00:00')

--Revenue BY category AND time
SELECT sum(revenue) 
FROM selling_items
JOIN products ON 
products.id = selling_items.product_id
WHERE products.category = 'Các loại tai nghe'
AND date_trunc('month', order_date) = date_trunc('month', timestamp '2016-01-01 00:00:00')


--Profit BY category AND time
SELECT sum(net_revenue) 
FROM selling_items
JOIN products ON 
products.id = selling_items.product_id
WHERE products.category = 'Các loại tai nghe'
AND date_trunc('month', order_date) = date_trunc('month', timestamp '2016-01-01 00:00:00')