Use Ola;

CREATE TABLE bookings (
    Date DATE,
    Time TIME,
    Booking_ID VARCHAR(50) PRIMARY KEY,
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(50),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(150),
    Drop_Location VARCHAR(150),
    V_TAT DECIMAL(10,2),
    C_TAT DECIMAL(10,2),
    Canceled_Rides_by_Customer VARCHAR(100),
    Canceled_Rides_by_Driver VARCHAR(100),
    Incomplete_Rides VARCHAR(50),
    Incomplete_Rides_Reason VARCHAR(255),
    Booking_Value DECIMAL(10,2),
    Payment_Method VARCHAR(50),
    Ride_Distance DECIMAL(10,2),
    Driver_Ratings DECIMAL(3,2),
    Customer_Rating DECIMAL(3,2),
    Vehicle_Images VARCHAR(255)
);

CREATE VIEW successful_bookings AS
SELECT *
FROM bookings_cleaned
WHERE Booking_Status = 'Success';

#Retrieve all successful bookings:
SELECT * FROM successful_bookings
LIMIT 10;


Create View ride_distance_for_each_vehicle As
SELECT Vehicle_Type ,AVG (Ride_Distance)
as avg_distance FROM Bookings_cleaned
GROUP BY Vehicle_Type;

# Find the average ride distance for each vehicle type:
SELECT * from ride_distance_for_each_vehicle;

Create View canceled_rides_by_customers As
SELECT COUNT(*) FROM Bookings_cleaned
WHERE Booking_Status = 'Canceled by Customer'; 

# Get the total number of cancelled rides by customers:
SELECT * from canceled_rides_by_customers;

Create View top_5_customers As
SELECT Customer_Id,COUNT(Booking_Id) As total_rides
FROM Bookings_cleaned 
GROUP BY Customer_Id
ORDER BY total_rides DESC LIMIT 5 ;

#  List the top 5 customers who booked the highest number of rides:
SELECT * from top_5_customers;

Create View Rides_Canceled_by_Drivers_P_C_issues As
SELECT COUNT(*) FROM Bookings_cleaned
WHERE Canceled_Rides_by_Driver ='Personal & Car related issue';

# Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT * FROM Rides_Canceled_by_Drivers_P_C_issues;

# Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT MAX(Driver_Ratings) as max_ratings,
MIN(Driver_Ratings) as min_ratings
FROM Bookings_cleaned WHERE Vehicle_Type ='Prime Sedan';

 # Retrieve all rides where payment was made using UPI:
 SELECT * from Bookings_cleaned
 WHERE Payment_Method='UPI';
 
 # Find the average customer rating per vehicle type:
 SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating
 FROM Bookings_cleaned
 GROUP BY Vehicle_Type;
 
 # Calculate the total booking value of rides completed successfully:
 SELECT SUM(Booking_Value) as total_sucessful_ride_value
 FROM Bookings_cleaned
 WHERE Booking_Status='Success';
 
 # List all incomplete rides along with the reason:
 SELECT Booking_Id , Incomplete_Rides_Reason
 FROM Bookings_cleaned
 WHERE Incomplete_Rides='Yes';