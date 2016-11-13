--How many usrs do we have
SELECT count(*) FROM users


--How many users are actively making
WITH time_d AS (
	SELECT distinct date_trunc('month', order_date)
	FROM user_statistics
	WHERE date_trunc('month', order_date) >= '2016-01-01 00:00:00' AND date_trunc('month', order_date) <= '2016-02-01 00:00:00'
),
statis_d AS (
	SELECT user_id, date_trunc('month', order_date), RANK() OVER (PARTITION BY user_id ORDER BY date_trunc('month', order_date)) AS rank_d   
	FROM user_statistics
	WHERE date_trunc('month', order_date) >= '2016-01-01 00:00:00' AND date_trunc('month', order_date) <= '2016-02-01 00:00:00'
	GROUP BY user_id,  date_trunc('month', order_date)
	ORDER BY user_id,  date_trunc('month', order_date)
)
SELECT count(*)
FROM statis_d 
WHERE statis_d.rank_d = (SELECT count(*) FROM time_d)


--When do people buy stuff the most (by hour/day/weekday/month)
WITH time_range AS (
	select generate_series('2016-11-01', '2016-12-01', '1 day'::interval) AS day_d
),
statis AS (
	SELECT order_date::timestamp::date, count(*) AS total_order
	FROM order_statistics
	WHERE order_date >= '2016-11-01' AND order_date <= '2016-12-01'
	GROUP BY order_date
)
SELECT date_trunc('month', time_range.day_d), COALESCE(SUM(total_order),0)
FROM time_range
LEFT JOIN statis ON time_range.day_d = statis.order_date
GROUP BY date_trunc('month', time_range.day_d)
ORDER BY date_trunc('month', time_range.day_d)


--How much does a user spend every (day/week/month)
WITH usr_spend AS (
SELECT user_id, date_trunc('day', order_date) AS order_date, sum(spend) AS spend
FROM user_statistics
WHERE date_trunc('day', order_date) >= '2016-01-01 00:00:00' AND date_trunc('day', order_date) <= '2016-02-01 00:00:00'
GROUP BY user_id, date_trunc('day', order_date)
)
SELECT usr_spend.order_date, avg(usr_spend.spend)
FROM usr_spend
GROUP BY usr_spend.order_date
ORDER BY usr_spend.order_date

/* User: Pham Huynh Minh Triet (id:1886) - Report: 3 - When do people buy stuff the most (by hourdayweekdaymonth) (id:4956) - Hash: 88998e7 - Job ID:  */
WITH time_range AS (
	select generate_series('2016-10-13', '2016-11-13', '1 day'::interval) AS day_d
),
statis AS (
	SELECT order_date::timestamp::date, count(*) AS total_order
	FROM order_statistics
	WHERE order_date >= '2016-10-13' AND order_date <= '2016-11-13'
	GROUP BY order_date
)
SELECT date_trunc('day', time_range.day_d), COALESCE(SUM(total_order),0) as total_order
FROM time_range
LEFT JOIN statis ON time_range.day_d = statis.order_date
GROUP BY date_trunc('day', time_range.day_d)
ORDER BY date_trunc('day', time_range.day_d)

