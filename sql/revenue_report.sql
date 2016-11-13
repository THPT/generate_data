
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
WITH time_range AS (
	select generate_series({{range_start}}, {{range_end}}, '1 day'::interval) AS day_d
)
SELECT date_trunc({{period}}, time_range.day_d), coalesce(sum(revenue), 0) as revenue
FROM time_range
LEFT JOIN selling_items ON selling_items.order_date = time_range.day_d
LEFT JOIN products ON
products.id = selling_items.product_id
WHERE [[products.category = {{category}}]]
AND
[[date_trunc({{period}}, time_range.day_d) >= date_trunc({{period}}, timestamp {{range_start}})
AND date_trunc({{period}}, time_range.day_d) <= date_trunc({{period}}, timestamp {{range_end}})]]
GROUP BY date_trunc({{period}}, time_range.day_d)
ORDER BY date_trunc({{period}}, time_range.day_d) DESC

--Profit BY category AND time
WITH time_range AS (
	select generate_series({{range_start}}, {{range_end}}, '1 day'::interval) AS day_d
)

SELECT date_trunc({{period}}, time_range.day_d), coalesce(sum(net_revenue), 0) as revenue
FROM time_range
LEFT JOIN selling_items ON selling_items.order_date = time_range.day_d
LEFT JOIN products ON
products.id = selling_items.product_id
WHERE [[products.category = {{category}}]]
AND
[[date_trunc({{period}}, time_range.day_d) >= date_trunc({{period}}, timestamp {{range_start}})
AND date_trunc({{period}}, time_range.day_d) <= date_trunc({{period}}, timestamp {{range_end}})]]
GROUP BY date_trunc({{period}}, time_range.day_d)
ORDER BY date_trunc({{period}}, time_range.day_d) DESC