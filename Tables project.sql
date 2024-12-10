CREATE DATABASE vacation_rentals;
USE vacation_rentals;
-- 1. Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255),
    user_rating FLOAT DEFAULT NULL
);

-- 2. Owners Table
CREATE TABLE Owners (
    owner_id INT PRIMARY KEY,
    owner_name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255)
);

-- 3. Properties Table
CREATE TABLE Properties (
    property_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    owner_id INT NOT NULL,
    location VARCHAR(255) NOT NULL,
    room_type VARCHAR(50),
    listing_price FLOAT NOT NULL,
    occupancy_rate FLOAT,
    FOREIGN KEY (owner_id) REFERENCES Owners(owner_id)
);

-- 4. Reviews Table
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    user_id INT NOT NULL,
    review_date DATE NOT NULL,
    comments TEXT,
    rating_cleanliness FLOAT CHECK (rating_cleanliness BETWEEN 0 AND 5),
    rating_host FLOAT CHECK (rating_host BETWEEN 0 AND 5),
    rating_location FLOAT CHECK (rating_location BETWEEN 0 AND 5),
    rating_overall FLOAT CHECK (rating_overall BETWEEN 0 AND 5),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 5. Requests Table
CREATE TABLE Requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    owner_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status ENUM('Pending', 'Accepted', 'Denied') DEFAULT 'Pending',
    booking_id INT DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (owner_id) REFERENCES Owners(owner_id),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- 6. Bookings Table
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    user_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    nights_booked INT NOT NULL,
    total_price FLOAT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 7. Cancellations Table
CREATE TABLE Cancellations (
    cancellation_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    cancellation_reason VARCHAR(255),
    cancellation_date DATE NOT NULL,
    refund_amount FLOAT,
    refund_status VARCHAR(50),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- 8. Transactions Table
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_amount FLOAT NOT NULL,
    transaction_type ENUM('Credit', 'Debit') NOT NULL,
    transaction_status ENUM('Successful', 'Pending', 'Failed') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- 9. Amenities Table
CREATE TABLE Amenities (
    amenity_id INT AUTO_INCREMENT PRIMARY KEY,
    amenity_name VARCHAR(255) NOT NULL
);

-- 10. Property Amenities Table
CREATE TABLE Property_Amenities (
    property_id INT NOT NULL,
    amenity_id INT NOT NULL,
    PRIMARY KEY (property_id, amenity_id),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (amenity_id) REFERENCES Amenities(amenity_id)
);

-- 11. User Feedback Table
CREATE TABLE User_Feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    owner_id INT NOT NULL,
    property_id INT NOT NULL,
    feedback_date DATE NOT NULL,
    rating FLOAT CHECK (rating BETWEEN 0 AND 5),
    comments TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (owner_id) REFERENCES Owners(owner_id),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id)
);

-- 12. Revenue Forecasts Table
CREATE TABLE Revenue_Forecasts (
    forecast_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    forecast_date DATE NOT NULL,
    forecast_period ENUM('Monthly', 'Quarterly', 'Yearly') NOT NULL,
    forecast_start_date DATE NOT NULL,
    forecast_end_date DATE NOT NULL,
    forecasted_revenue FLOAT NOT NULL,
    confidence_interval_lower FLOAT,
    confidence_interval_upper FLOAT,
    model_version VARCHAR(50),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id)
);
