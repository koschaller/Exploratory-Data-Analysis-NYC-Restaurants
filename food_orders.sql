--Amount of restaurants available on app by cuisine

SELECT DISTINCT ON(cuisine_type) cuisine_type, COUNT(DISTINCT restaurant_name)
FROM food_order
GROUP BY cuisine_type
ORDER BY cuisine_type, COUNT(restaurant_name) DESC;


--Count of orders by day (weekday vs weekend)

SELECT day_of_the_week, COUNT(order_id)
FROM food_order
GROUP BY day_of_the_week
ORDER BY COUNT(order_id) DESC;


--Count of orders by restaurant

SELECT restaurant_name, COUNT(order_id)
FROM food_order
WHERE day_of_the_week = 'Weekend'
GROUP BY restaurant_name
ORDER BY COUNT(order_id) DESC;


--Count of orders by type of cuisine

SELECT cuisine_type, COUNT(order_id)
FROM food_order
WHERE day_of_the_week = 'Weekend'
GROUP BY cuisine_type
ORDER BY COUNT(order_id) DESC;


--Which restaurant, per cuisine, is most popular

SELECT DISTINCT ON(cuisine_type) cuisine_type, restaurant_name, COUNT(order_id)
FROM food_order
WHERE day_of_the_week = 'Weekend'
GROUP BY cuisine_type, restaurant_name
ORDER BY cuisine_type, COUNT(order_id) DESC;


--Average cost of order overall

SELECT ROUND(AVG(cost_of_the_order), 2)
FROM food_order;

SELECT day_of_the_week, ROUND(AVG(cost_of_the_order), 2)
FROM food_order
GROUP BY day_of_the_week;


--Average cost of order per restaurant

SELECT restaurant_name, ROUND(AVG(cost_of_the_order), 2)
FROM food_order
WHERE day_of_the_week = 'Weekend'
GROUP BY restaurant_name
ORDER BY AVG(cost_of_the_order) DESC;


--Average cost of order per cuisine

SELECT cuisine_type, ROUND(AVG(cost_of_the_order), 2)
FROM food_order
WHERE day_of_the_week = 'Weekend'
GROUP BY cuisine_type
ORDER BY AVG(cost_of_the_order) DESC;


--Time between placing order and receiving order average

SELECT ROUND(AVG(total_time), 2)
FROM food_order;

SELECT day_of_the_week, ROUND(AVG(total_time), 2)
FROM food_order
GROUP BY day_of_the_week;


--Time between placing order and receiving order by restaurant

SELECT restaurant_name, ROUND(AVG(total_time), 2)
FROM food_order
WHERE day_of_the_week = 'Weekend'
GROUP BY restaurant_name
ORDER BY AVG(total_time) DESC;


--Time between placing order and receiving order by cuisine

SELECT cuisine_type, ROUND(AVG(total_time), 2)
FROM food_order
WHERE day_of_the_week = 'Weekend'
GROUP BY cuisine_type
ORDER BY AVG(total_time) DESC;


--Time between placing order and receiving order by rating

SELECT rating, ROUND(AVG(total_time), 2)
FROM food_order
WHERE day_of_the_week = 'Weekend' AND rating <> 0
GROUP BY rating
ORDER BY AVG(total_time) DESC;


--Average rating overall

SELECT ROUND(AVG(rating), 2)
FROM food_order
WHERE rating <> 0;


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