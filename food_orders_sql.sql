--OVERVIEW
--Total number of restaurants available on the app

SELECT COUNT(DISTINCT restaurant_name)
FROM food_order;

--Number of restaurants per cuisine type are available on the app

SELECT DISTINCT ON(cuisine_type) cuisine_type, COUNT(DISTINCT restaurant_name)
FROM food_order
GROUP BY cuisine_type
ORDER BY cuisine_type, COUNT(restaurant_name) DESC;

--Total number of orders placed

SELECT COUNT(*)
FROM food_order;



--ORDER BREAKDOWN
--Percentage of orders were placed on the weekend vs weekdays

SELECT a1.day_of_the_week, COUNT(a1.order_id), COUNT(a1.order_id) * 1.0/(SELECT COUNT(order_id) FROM food_order) Pct_To_Total
FROM food_order a1
GROUP BY a1.day_of_the_week
ORDER BY COUNT(a1.order_id) DESC;



--WEEKEND ORDER BREAKDOWN
--Percent of orders by type of cuisine

SELECT a1.cuisine_type, COUNT(a1.order_id), COUNT(a1.order_id) * 1.0/(SELECT COUNT(order_id) FROM food_order WHERE day_of_the_week = 'Weekend') Pct_To_Total
FROM food_order a1
WHERE a1.day_of_the_week = 'Weekend'
GROUP BY a1.cuisine_type
ORDER BY COUNT(a1.order_id) DESC;

--Percent of order by restaurant for each cuisine
--Focused on American, Japanese, Italian, and Chinese cuisines

SELECT a1.restaurant_name, COUNT(a1.order_id)*1.0/(SELECT COUNT(order_id) FROM food_order WHERE day_of_the_week = 'Weekend' AND cuisine_type = 'American') Pct_To_Total
FROM food_order a1
WHERE a1.cuisine_type = 'American' AND a1.day_of_the_week = 'Weekend'
GROUP BY a1.restaurant_name
ORDER BY COUNT(a1.order_id)*1.0/(SELECT COUNT(order_id) FROM food_order WHERE day_of_the_week = 'Weekend' AND cuisine_type = 'American') DESC;

--Which restaurant, per cuisine, is most popular

SELECT DISTINCT ON(cuisine_type) cuisine_type, restaurant_name, COUNT(order_id)
FROM food_order
WHERE day_of_the_week = 'Weekend'
GROUP BY cuisine_type, restaurant_name
ORDER BY cuisine_type, COUNT(order_id) DESC;



--COST BREAKDOWN
--Average cost of order overall

SELECT ROUND(AVG(cost_of_the_order), 2)
FROM food_order
WHERE day_of_the_week = 'Weekend';

--Average cost of order per cuisine

SELECT cuisine_type, ROUND(AVG(cost_of_the_order), 2)
FROM food_order
WHERE day_of_the_week = 'Weekend'
GROUP BY cuisine_type
ORDER BY AVG(cost_of_the_order) DESC;

--Average cost of order per restaurant
--Focused on American, Japanese, Italian, and Chinese cuisines

SELECT restaurant_name, ROUND(AVG(cost_of_the_order), 2)
FROM food_order
WHERE day_of_the_week = 'Weekend' AND cuisine_type = 'Chinese'
GROUP BY restaurant_name
ORDER BY AVG(cost_of_the_order) DESC;



--PREP AND DELIVERY TIME BREAKDOWN
--Average total time to delivery

SELECT ROUND(AVG(total_time), 2)
FROM food_order
WHERE day_of_the_week = 'Weekend';

--Average total time to delivery by cuisine

SELECT cuisine_type, ROUND(AVG(total_time), 2)
FROM food_order
WHERE day_of_the_week = 'Weekend'
GROUP BY cuisine_type
ORDER BY AVG(total_time) DESC;

--Average total time to delivery by restaurant

SELECT restaurant_name, ROUND(AVG(total_time), 2)
FROM food_order
WHERE day_of_the_week = 'Weekend' AND cuisine_type = 'Italian'
GROUP BY restaurant_name
ORDER BY AVG(total_time) DESC;



--RATINGS BREAKDOWN
--Percent of customers that left a rating

SELECT a1.day_of_the_week, COUNT(a1.rating) * 1.0/(SELECT COUNT(rating) FROM food_order) Pct_To_Total
FROM food_order a1
WHERE a1.rating <> 0 
GROUP BY a1.day_of_the_week;

--Average rating overall

SELECT ROUND(AVG(rating), 2)
FROM food_order
WHERE rating <> 0 AND day_of_the_week = 'Weekend';

--Rating per cuisine

SELECT cuisine_type, COUNT(rating), ROUND(AVG(rating), 2)
FROM food_order
WHERE day_of_the_week = 'Weekend' AND rating <> 0
GROUP BY cuisine_type
ORDER BY COUNT(rating) DESC;

--Ratings per restaurant

SELECT restaurant_name, COUNT(rating), ROUND(AVG(rating), 2)
FROM food_order
WHERE rating <> 0 AND day_of_the_week = 'Weekend'
GROUP BY restaurant_name
ORDER BY COUNT(rating) DESC;