-- Create the Table
CREATE TABLE hotel_bookings (
    hotel VARCHAR,
    is_canceled INTEGER,
    lead_time INTEGER,
    arrival_date_year INTEGER,
    arrival_date_month VARCHAR,
    arrival_date_week_number INTEGER,
    arrival_date_day_of_month INTEGER,
    stays_in_weekend_nights INTEGER,
    stays_in_week_nights INTEGER,
    adults INTEGER,
    children VARCHAR,
    babies INTEGER,
    meal VARCHAR,
    country VARCHAR,
    market_segment VARCHAR,
    distribution_channel VARCHAR,
    is_repeated_guest INTEGER,
    previous_cancellations INTEGER,
    previous_bookings_not_canceled INTEGER,
    reserved_room_type VARCHAR,
    assigned_room_type VARCHAR,
    booking_changes INTEGER,
    deposit_type VARCHAR,
    agent VARCHAR,
    company VARCHAR,
    days_in_waiting_list INTEGER,
    customer_type VARCHAR,
    adr NUMERIC,
    required_car_parking_spaces INTEGER,
    total_of_special_requests INTEGER,
    reservation_status VARCHAR,
    reservation_status_date VARCHAR
);

-- Data Exploration Queries --
-- Select all data from the table
SELECT *
FROM hotel_bookings
LIMIT 100;

-- Check for any null values in all columns
SELECT 'hotel' as column_name, COUNT(hotel) as count_null
FROM hotel_bookings WHERE hotel IS NULL
UNION
SELECT 'is_canceled', COUNT(is_canceled) FROM hotel_bookings WHERE is_canceled IS NULL
UNION
SELECT 'lead_time', COUNT(lead_time) FROM hotel_bookings WHERE lead_time IS NULL
UNION
SELECT 'arrival_date_year', COUNT(arrival_date_year) FROM hotel_bookings WHERE arrival_date_year IS NULL
UNION
SELECT 'arrival_date_month', COUNT(arrival_date_month) FROM hotel_bookings WHERE arrival_date_month IS NULL
UNION
SELECT 'arrival_date_week_number', COUNT(arrival_date_week_number) FROM hotel_bookings WHERE arrival_date_week_number IS NULL
UNION
SELECT 'arrival_date_day_of_month', COUNT(arrival_date_day_of_month) FROM hotel_bookings WHERE arrival_date_day_of_month IS NULL
UNION
SELECT 'stays_in_weekend_nights', COUNT(stays_in_weekend_nights) FROM hotel_bookings WHERE stays_in_weekend_nights IS NULL
UNION
SELECT 'stays_in_week_nights', COUNT(stays_in_week_nights) FROM hotel_bookings WHERE stays_in_week_nights IS NULL
UNION
SELECT 'adults', COUNT(adults) FROM hotel_bookings WHERE adults IS NULL
UNION
SELECT 'children', COUNT(children) FROM hotel_bookings WHERE children IS NULL
UNION
SELECT 'babies', COUNT(babies) FROM hotel_bookings WHERE babies IS NULL
UNION
SELECT 'meal', COUNT(meal) FROM hotel_bookings WHERE meal IS NULL
UNION
SELECT 'country', COUNT(country) FROM hotel_bookings WHERE country IS NULL
UNION
SELECT 'market_segment', COUNT(market_segment) FROM hotel_bookings WHERE market_segment IS NULL
UNION
SELECT 'distribution_channel', COUNT(distribution_channel) FROM hotel_bookings WHERE distribution_channel IS NULL
UNION
SELECT 'is_repeated_guest', COUNT(is_repeated_guest) FROM hotel_bookings WHERE is_repeated_guest IS NULL
UNION
SELECT 'previous_cancellations', COUNT(previous_cancellations) FROM hotel_bookings WHERE previous_cancellations IS NULL
UNION
SELECT 'previous_bookings_not_canceled', COUNT(previous_bookings_not_canceled) FROM hotel_bookings WHERE previous_bookings_not_canceled IS NULL
UNION
SELECT 'reserved_room_type', COUNT(reserved_room_type) FROM hotel_bookings WHERE reserved_room_type IS NULL
UNION
SELECT 'assigned_room_type', COUNT(assigned_room_type) FROM hotel_bookings WHERE assigned_room_type IS NULL
UNION
SELECT 'booking_changes', COUNT(booking_changes) FROM hotel_bookings WHERE booking_changes IS NULL
UNION
SELECT 'deposit_type', COUNT(deposit_type) FROM hotel_bookings WHERE deposit_type IS NULL
UNION
SELECT 'agent', COUNT(agent) FROM hotel_bookings WHERE agent IS NULL
UNION
SELECT 'company', COUNT(company) FROM hotel_bookings WHERE company IS NULL
UNION
SELECT 'days_in_waiting_list', COUNT(days_in_waiting_list) FROM hotel_bookings WHERE days_in_waiting_list IS NULL
UNION
SELECT 'customer_type', COUNT(customer_type) FROM hotel_bookings WHERE customer_type IS NULL
UNION
SELECT 'adr', COUNT(adr) FROM hotel_bookings WHERE adr IS NULL
UNION
SELECT 'required_car_parking_spaces', COUNT(required_car_parking_spaces) FROM hotel_bookings WHERE required_car_parking_spaces IS NULL
UNION
SELECT 'total_of_special_requests', COUNT(total_of_special_requests) FROM hotel_bookings WHERE total_of_special_requests IS NULL
UNION
SELECT 'reservation_status', COUNT(reservation_status) FROM hotel_bookings WHERE reservation_status IS NULL
UNION
SELECT 'reservation_status_date', COUNT(reservation_status_date) FROM hotel_bookings WHERE reservation_status_date IS NULL
ORDER BY count_null DESC;

-- Check percentage for null values
SELECT 'company' AS column_name,
    ROUND(COUNT(hotel) * 100.0 / (SELECT COUNT(hotel) FROM hotel_bookings), 3) as null_percentage
FROM hotel_bookings WHERE company IS NULL
UNION
SELECT 'agent',
    ROUND(COUNT(hotel) * 100.0 / (SELECT COUNT(hotel) FROM hotel_bookings), 3)
FROM hotel_bookings WHERE agent IS NULL
UNION
SELECT 'country',
    ROUND(COUNT(hotel) * 100.0 / (SELECT COUNT(hotel) FROM hotel_bookings), 3)
FROM hotel_bookings WHERE country IS NULL
UNION
SELECT 'children',
    ROUND(COUNT(hotel) * 100.0 / (SELECT COUNT(hotel) FROM hotel_bookings), 3)
FROM hotel_bookings WHERE children IS NULL
ORDER BY null_percentage DESC;


-- Data Analysis Queries --
-- Total Bookings
SELECT COUNT(hotel) AS total_bookings
FROM hotel_bookings;

-- Total bookings in City and Resort hotels (Bookings by Hotel Type)
SELECT hotel, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY hotel;

-- Percentage of City and Resort hotel bookings (Percentage of Bookings by Hotel Type)
SELECT hotel, ROUND(COUNT(hotel) * 100.0 / (SELECT COUNT(hotel) FROM hotel_bookings), 2) AS percent_of_bookings
FROM hotel_bookings
GROUP BY hotel;

-- Total stayed and cancelled
SELECT is_canceled AS status, COUNT(is_canceled) AS total_status
FROM hotel_bookings
GROUP BY is_canceled;

-- Percentage of stayed and cancelled
SELECT is_canceled, ROUND(COUNT(hotel) * 100.0 / (SELECT COUNT(is_canceled) FROM hotel_bookings), 2) AS percent_of_status
FROM hotel_bookings
GROUP BY is_canceled;

-- Percentage of stayed and cancelled by hotel type
SELECT hotel, is_canceled AS status, ROUND(COUNT(hotel) * 100.0 / (SELECT COUNT(hotel) FROM hotel_bookings WHERE hotel = 'City Hotel'), 2) AS percentage
FROM hotel_bookings WHERE hotel = 'City Hotel'
GROUP BY hotel, status
UNION
SELECT hotel, is_canceled AS status, ROUND(COUNT(hotel) * 100.0 / (SELECT COUNT(hotel) FROM hotel_bookings WHERE hotel = 'Resort Hotel'), 2) AS percentage
FROM hotel_bookings WHERE hotel = 'Resort Hotel'
GROUP BY hotel, status;

-- Top 10 countries with most orders (Bookings by Country)
SELECT country, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY country
ORDER BY total_bookings DESC
LIMIT 10;

-- Total bookings in arrival date months (both hotels Bookings by Arrival Month)
SELECT CASE
        WHEN arrival_date_month = 'January' THEN 1
        WHEN arrival_date_month = 'February' THEN 2
        WHEN arrival_date_month = 'March' THEN 3
        WHEN arrival_date_month = 'April' THEN 4
        WHEN arrival_date_month = 'May' THEN 5
        WHEN arrival_date_month = 'June' THEN 6
        WHEN arrival_date_month = 'July' THEN 7
        WHEN arrival_date_month = 'August' THEN 8
        WHEN arrival_date_month = 'September' THEN 9
        WHEN arrival_date_month = 'October' THEN 10
        WHEN arrival_date_month = 'November' THEN 11
        WHEN arrival_date_month = 'December' THEN 12
    END AS months,
    COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY arrival_date_month
ORDER BY months;

-- Total bookings in arrival date months (separated by hotel type )
WITH AA AS (
    SELECT arrival_date_month, COUNT(hotel) AS ch_bookings
    FROM hotel_bookings
    WHERE hotel = 'City Hotel'
    GROUP BY arrival_date_month),
BB AS (
    SELECT arrival_date_month, COUNT(hotel) AS rh_bookings
    FROM hotel_bookings
    WHERE hotel = 'Resort Hotel'
    GROUP BY arrival_date_month)
SELECT CASE
        WHEN AA.arrival_date_month = 'January' THEN 1
        WHEN AA.arrival_date_month = 'February' THEN 2
        WHEN AA.arrival_date_month = 'March' THEN 3
        WHEN AA.arrival_date_month = 'April' THEN 4
        WHEN AA.arrival_date_month = 'May' THEN 5
        WHEN AA.arrival_date_month = 'June' THEN 6
        WHEN AA.arrival_date_month = 'July' THEN 7
        WHEN AA.arrival_date_month = 'August' THEN 8
        WHEN AA.arrival_date_month = 'September' THEN 9
        WHEN AA.arrival_date_month = 'October' THEN 10
        WHEN AA.arrival_date_month = 'November' THEN 11
        WHEN AA.arrival_date_month = 'December' THEN 12
    END AS months, AA.arrival_date_month, AA.ch_bookings, BB.rh_bookings
FROM AA
LEFT JOIN BB
ON AA.arrival_date_month = BB.arrival_date_month
ORDER BY months;

-- Popular Meal Types
SELECT meal, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY meal
ORDER BY total_bookings DESC;

-- Most Common Country
SELECT country, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY country
ORDER BY total_bookings DESC
LIMIT 1;

-- Bookings by Distribution Channel
SELECT distribution_channel, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY distribution_channel
ORDER BY total_bookings DESC;

-- Bookings by Market Segment
SELECT market_segment, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY market_segment
ORDER BY total_bookings DESC;

-- Bookings by Customer Type
SELECT customer_type, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY customer_type
ORDER BY total_bookings DESC;

-- Average Daily Rate (ADR) by Hotel Type
SELECT hotel, AVG(adr) AS avg_adr
FROM hotel_bookings
GROUP BY hotel;

-- Average Lead Time
SELECT AVG(lead_time) AS avg_lead_time
FROM hotel_bookings;

-- WPreferred Hotel and Seasonal Effects
SELECT hotel, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY hotel
ORDER BY total_bookings DESC
LIMIT 1;

-- Average Stay Duration and Special Requests
SELECT AVG(stays_in_weekend_nights + stays_in_week_nights) AS avg_stay_duration,
       AVG(total_of_special_requests) AS avg_special_requests
FROM hotel_bookings;

-- Meal Booking Preferences
SELECT meal AS meal_type, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY meal
ORDER BY total_bookings DESC;

-- Impact of Reserved Room Type on Cancellations
SELECT reserved_room_type, is_canceled, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY reserved_room_type, is_canceled;

-- Lead Time Impact on Cancellations
SELECT CASE 
          WHEN lead_time > 30 THEN 'High Lead Time'
          ELSE 'Low Lead Time'
       END AS lead_time_category,
       is_canceled,
       COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY lead_time_category, is_canceled;

-- Average Number of People per Reservation
SELECT AVG(adults + 
           CASE 
               WHEN children ~ '^[0-9]+$' THEN children::INTEGER 
               ELSE 0 
           END + babies) AS avg_people_per_reservation
FROM hotel_bookings;

-- Advanced Reservations by Hotel Type
SELECT hotel, AVG(lead_time) AS avg_lead_time
FROM hotel_bookings
GROUP BY hotel
ORDER BY avg_lead_time DESC;

-- Distribution Channels and Cancellations
SELECT distribution_channel, SUM(is_canceled) AS total_cancellations
FROM hotel_bookings
GROUP BY distribution_channel
ORDER BY total_cancellations DESC;

-- Market Segment Analysis
SELECT market_segment, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY market_segment
ORDER BY total_bookings DESC;

SELECT market_segment, SUM(is_canceled) AS total_cancellations
FROM hotel_bookings
GROUP BY market_segment
ORDER BY total_cancellations DESC;

-- ADR by Room Type
SELECT reserved_room_type AS room_type, AVG(adr) AS avg_adr
FROM hotel_bookings
GROUP BY reserved_room_type
ORDER BY avg_adr DESC;

-- Busiest Hotel Type
SELECT hotel, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY hotel
ORDER BY total_bookings DESC;

-- Busiest Month
SELECT arrival_date_month AS month, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY arrival_date_month
ORDER BY total_bookings DESC
LIMIT 1;

-- Revenue by Customer Type and Hotel Type
SELECT customer_type, hotel, SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)) AS total_revenue
FROM hotel_bookings
GROUP BY customer_type, hotel
ORDER BY total_revenue DESC;

-- Frequency of Parking Space Requests by Hotel Type
SELECT hotel, required_car_parking_spaces, COUNT(hotel) AS total_requests
FROM hotel_bookings
GROUP BY hotel, required_car_parking_spaces
ORDER BY total_requests DESC;

-- Most Common Number of Nights Booked by Customers
SELECT (stays_in_weekend_nights + stays_in_week_nights) AS total_nights, COUNT(hotel) AS total_bookings
FROM hotel_bookings
GROUP BY total_nights
ORDER BY total_bookings DESC
LIMIT 1;

-- Impact of Waiting Period on Booking Cancellations
SELECT CASE 
          WHEN days_in_waiting_list > 30 THEN 'Long Waiting List'
          ELSE 'Short Waiting List'
       END AS waiting_list_category,
       SUM(is_canceled) AS total_cancellations
FROM hotel_bookings
GROUP BY waiting_list_category;

-- Total Number of Reservations
SELECT COUNT(hotel) AS total_reservations
FROM hotel_bookings;

-- Reservations Falling on Weekends
SELECT COUNT(hotel) AS total_weekend_reservations
FROM hotel_bookings
WHERE stays_in_weekend_nights > 0;

-- Highest and Lowest Lead Time for Reservations
SELECT MAX(lead_time) AS max_lead_time, MIN(lead_time) AS min_lead_time
FROM hotel_bookings;

-- Cancellation rate for City Hotel vs. Resort Hotel
SELECT
    hotel,
    ROUND(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(hotel), 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY hotel;

-- Average stay duration (weekend + week nights) for each hotel type
SELECT
    hotel,
    AVG(stays_in_weekend_nights + stays_in_week_nights) AS avg_stay_duration
FROM hotel_bookings
GROUP BY hotel;

-- Compare cancellation rates with the number of special requests
SELECT
    total_of_special_requests,
    ROUND(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(hotel), 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY total_of_special_requests
ORDER BY total_of_special_requests;

-- Correlation between lead time and average daily rate (adr)
SELECT
    CORR(lead_time, adr) AS correlation_lead_time_adr
FROM hotel_bookings
WHERE adr IS NOT NULL AND lead_time IS NOT NULL;

-- Cancellation rate based on the number of booking changes
SELECT
    booking_changes,
    ROUND(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(hotel), 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY booking_changes
ORDER BY booking_changes;

-- Average daily rate for each type of customer
SELECT
    customer_type,
    AVG(adr) AS avg_adr
FROM hotel_bookings
GROUP BY customer_type;

-- Total bookings and cancellations by day of the week
SELECT
    EXTRACT(DOW FROM TO_DATE(arrival_date_day_of_month::TEXT, 'DD')) AS day_of_week,
    COUNT(hotel) AS total_bookings,
    SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS total_cancellations
FROM hotel_bookings
GROUP BY day_of_week
ORDER BY day_of_week;

-- Monthly ADR trends for different hotel types
SELECT
    arrival_date_year,
    arrival_date_month,
    hotel,
    AVG(adr) AS avg_adr
FROM hotel_bookings
GROUP BY arrival_date_year, arrival_date_month, hotel
ORDER BY arrival_date_year, arrival_date_month, hotel;

-- Cancellation rate for different deposit types
SELECT
    deposit_type,
    ROUND(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(hotel), 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY deposit_type;

-- Effectiveness of distribution channels based on bookings and cancellations
SELECT
    distribution_channel,
    COUNT(hotel) AS total_bookings,
    ROUND(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(hotel), 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY distribution_channel;

-- Analysis of lead time in relation to booking changes
SELECT
    booking_changes,
    AVG(lead_time) AS avg_lead_time
FROM hotel_bookings
GROUP BY booking_changes
ORDER BY booking_changes;

-- Compare ADR for reserved vs. assigned room types
SELECT
    reserved_room_type,
    AVG(adr) AS avg_adr_reserved,
    AVG(CASE WHEN reserved_room_type != assigned_room_type THEN adr ELSE NULL END) AS avg_adr_assigned
FROM hotel_bookings
GROUP BY reserved_room_type;

-- Analyse special requests in relation to reservation status
SELECT
    reservation_status,
    AVG(total_of_special_requests) AS avg_special_requests
FROM hotel_bookings
GROUP BY reservation_status;


