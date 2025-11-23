#Uber Assignment 
select * from drivers_table;
select * from passengers_table;
select * from rides_table;	

#Basic Level
#1 What are & how many unique pickup locations are there in the dataset?
select distinct pickup_location from rides_table rt;

#2 What is the total number of rides in the dataset?
select count(distinct ride_id) from rides_table rt;

#3 Calculate the average ride duration
select avg(ride_duration) from rides_table rt;

#4 List the top 5 drivers based on their total earnings
select driver_id, sum(earnings) as total_earnings from drivers_table group by driver_id order by driver_id desc limit 5;

#5 Calculate the total number of rides for each payment method
select payment_method, count(*) as ride_count from rides_table group by payment_method;

#6 Retrieve rides with a fare amount greater than 20
select * from rides_table where fare_amount >20;

#7 Identify the most common pickup location
select pickup_location, count(*) as ride_count from rides_table group by pickup_location order by ride_count desc limit 1;

#8 Calculate the average fare amount
select avg(fare_amount) from rides_table;

#9 List the top 10 drivers with the highest average ratings
select driver_name, avg(rating) as avg_rating from drivers_table group by driver_name order by avg_rating desc limit 10;

#10 Calculate the total earnings for all drivers
select sum(earnings) from drivers_table;

#11 How many rides were paid using the "Cash" payment method
select count(*) from rides_table where payment_method = "cash";

#12 Calculate the number of rides & average ride distance for rides originating from the 'Dhanbad' pickup location
select pickup_location, count(*), avg(ride_distance) from rides_table where pickup_location = 'Dhanbad';

#13 Retrieve rides with a ride duration less than 10 minutes
select * from rides_table where ride_duration <10;

#14 List the passengers who have taken the most number of rides
select passenger_id, count(*) as ride_count from rides_table group by passenger_id order by ride_count desc limit 1;

#15 Calculate the total number of rides for each driver in descending order
select driver_id, count(*) as ride_count from rides_table group by driver_id order by ride_count desc;

#16 Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location
select payment_method from rides_table where pickup_location = "Gandhinagar";

#17 Calculate the average fare amount for rides with a ride distance greater than 10
select avg(fare_amount) from rides_table where ride_distance > 10;

#18 List the drivers in descending order according to their total number of rides
select driver_id, driver_name, total_rides from drivers_table order by total_rides desc;

#19 Calculate the percentage distribution of rides for each pickup location
SELECT pickup_location, COUNT(*) AS ride_count, ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM rides_table), 2) AS percentage 
FROM rides_table GROUP BY pickup_location order by percentage desc;


#20 Retrieve rides where both pickup and dropoff locations are the same
select * from rides_table where pickup_location = dropoff_location; 

#Intermediate Level
#1 List the passengers who have taken rides from at least 300 different pickup locations
select passenger_id, count(distinct pickup_location) as distinct_location from rides_table group by passenger_id having distinct_location >= 300;

#2 Calculate the average fare amount for rides taken on weekdays
select avg(fare_amount) from rides_table where DAYOFWEEK(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i'))>5;

#3 Identify the drivers who have taken rides with distances greater than 19
select driver_id, ride_distance from rides_table where ride_distance >19;

#4 Calculate the total earnings for drivers who have completed more than 100 rides
select sum(earnings) from drivers_table where total_rides >100;
select * from drivers_table dt;
SELECT driver_id, SUM(earnings) AS total_earnings FROM drivers_table 
WHERE driver_id IN (SELECT driver_id FROM drivers_table GROUP BY driver_id HAVING COUNT(*) > 100) GROUP BY driver_id;

#5 Retrieve rides where the fare amount is less than the average fare amount
select * from rides_table where fare_amount <(select avg(fare_amount) from rides_table);

#6 Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods
select dt.driver_id, avg(rating) as avg_rating 
from drivers_table dt inner join rides_table rt 
on dt.driver_id = rt.driver_id 
where rt.payment_method in ("Cash", "Credit Card")
group by dt.driver_id
having count(distinct rt.payment_method)=2;

#7 List the top 3 passengers with the highest total spending
SELECT passenger_name, total_spent FROM passengers_table ORDER BY total_spent DESC LIMIT 3;

#8 Calculate the average fare amount for rides taken during different months of the year
SELECT 	month(ride_timestamp) AS month_of_year, AVG(fare_amount) AS avg_fare FROM rides_table GROUP BY month_of_year;

#9 Identify the most common pair of pickup and dropoff locations
select pickup_location, dropoff_location, count(*) as ride_count from rides_table group by pickup_location, dropoff_location;

#10 Calculate the total earnings for each driver and order them by earnings in descending order
select driver_name, sum(earnings) as total_earnings from drivers_table group by driver_name order by total_earnings desc;

#11 List the passengers who have taken rides on their signup date
select pt.passenger_id, pt.passenger_name 
from passengers_table pt inner join rides_table rt
on pt.passenger_id = rt.passenger_id 
where date(pt.signup_date) = date(rt.ride_timestamp);

#12 Calculate the average earnings for each driver and order them by earnings in descending order
select driver_name, avg(earnings) as Avg_earnings from drivers_table group by driver_name order by avg_earnings desc;

#13 Retrieve rides with distances less than the average ride distance
select ride_id, avg(ride_distance) from rides_table 
where ride_id< (select avg(ride_id) from rides_table ) group by ride_id;

#14 List the drivers who have completed the least number of rides
SELECT driver_name, total_rides FROM drivers_table ORDER BY total_rides ASC

#15 Calculate the average fare amount for rides taken by passengers who have taken at least 20 rides
select avg(rt.fare_amount) from rides_table rt 
where passenger_id in (select passenger_id from passengers_table pt where total_rides >=20);

#16 Identify the pickup location with the highest average fare amount
select pickup_location, avg(fare_amount) as Avg_fare from rides_table group by pickup_location order by avg_fare limit 1;

#17 Calculate the average rating of drivers who completed at least 100 rides
select avg(rating) from drivers_table where total_rides = 100;

#18 List the passengers who have taken rides from at least 5 different pickup locations
SELECT passenger_id, COUNT(DISTINCT pickup_location) as Distinct_locations 
FROM rides_table GROUP BY passenger_id HAVING COUNT(DISTINCT pickup_location) >= 5;

#19 Calculate the average fare amount for rides taken by passengers with ratings above 4
select avg(rt.fare_amount) from rides_table rt join passengers_table pt 
on rt.passenger_id = pt.passenger_id where pt.rating >4;

#20 Retrieve rides with the shortest ride duration in each pickup location
select * from rides_table where ride_duration = (select min(ride_duration) from rides_table);

#Advanced Level
#1 List the drivers who have driven rides in all pickup locations
SELECT driver_id FROM rides_table GROUP BY driver_id HAVING COUNT(DISTINCT pickup_location) = (SELECT COUNT(DISTINCT pickup_location) FROM rides_table);

#2 Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total
select avg(fare_amount) from rides_table rt where passenger_id in (select passenger_id from passengers_table where total_spent >300);

#3 List the bottom 5 drivers based on their average earnings
select driver_name, avg(earnings) as Avg_earnings from drivers_table 
group by driver_name order by avg_earnings asc limit 5;

#4 Calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods
select sum(fare_amount) from rides_table WHERE passenger_id IN 
(SELECT passenger_id FROM rides_table GROUP BY passenger_id HAVING COUNT(DISTINCT payment_method) > 1);

#5 Retrieve rides where the fare amount is significantly above the average fare amount
select * from rides_table where fare_amount > (select avg(fare_amount) from rides_table);

#6 List the drivers who have completed rides on the same day they joined
select dt.driver_id, dt.driver_name from drivers_table dt join rides_table rt 
on dt.driver_id = rt.driver_id
where dt.join_date = rt.ride_timestamp;

#7 Calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods
select avg(fare_amount) from rides_table WHERE passenger_id IN 
(SELECT passenger_id FROM rides_table GROUP BY passenger_id HAVING COUNT(DISTINCT payment_method) > 1); 

#8 Identify the pickup location with the highest percentage increase in average fare amount compared to the overall average fare
select pickup_location, avg(fare_amount) as Avg_fare, (AVG(fare_amount) - 
(SELECT AVG(fare_amount) from rides_table rt)) * 100.0 / (SELECT AVG(fare_amount) FROM rides_table rt ) AS percentage_increase
FROM rides_table rt
GROUP BY pickup_location
ORDER BY percentage_increase desc;
LIMIT 1;

#9 Retrieve rides where the dropoff location is the same as the pickup location
select * from rides_table where pickup_location = dropoff_location; 

#10 Calculate the average rating of drivers who have driven rides with varying pickup locations
select avg(rating) from drivers_table dt WHERE driver_id IN (SELECT driver_id FROM rides_table rt
GROUP BY driver_id HAVING COUNT(DISTINCT pickup_location) > 1);
