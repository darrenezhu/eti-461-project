DROP DATABASE IF EXISTS Airdnd;
CREATE DATABASE Airdnd;

USE Airdnd;

DROP TABLE IF EXISTS Guest;
CREATE TABLE Guest (
    guestID INT AUTO_INCREMENT PRIMARY KEY,
    fName VARCHAR(100) NOT NULL,
    lName VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    addr VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip VARCHAR(20) NOT NULL,
    dob DATE NOT NULL,
    idForm VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS Amenities;
CREATE TABLE Amenities (
    amenitiesID INT AUTO_INCREMENT PRIMARY KEY,
    amenity VARCHAR(100),
    description VARCHAR(100)
);

DROP TABLE IF EXISTS Host;
CREATE TABLE Host (
    hostID INT AUTO_INCREMENT PRIMARY KEY,
    hostFName VARCHAR(100) NOT NULL,
    hostLName VARCHAR(100)
);

DROP TABLE IF EXISTS BankAccount;
CREATE TABLE BankAccount (
    bankAccountID INT AUTO_INCREMENT PRIMARY KEY,
    routingNum VARCHAR(9) NOT NULL,
    accountNum VARCHAR(20) NOT NULL,
    hostID INT NOT NULL,
    FOREIGN KEY (hostID) REFERENCES Host(hostID) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS PropertyType;
CREATE TABLE PropertyType (
    propertyTypeID INT AUTO_INCREMENT PRIMARY KEY,
    propertyType VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS Location;
CREATE TABLE Location (
	locationID INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Listing;
CREATE TABLE Listing (
    listingID INT AUTO_INCREMENT PRIMARY KEY,
    pricing FLOAT NOT NULL,
    cleaningFee FLOAT NOT NULL,
    title VARCHAR(300),
    description VARCHAR(500),
    maxGuests INT NOT NULL,
    bedrooms INT NOT NULL,
    beds INT NOT NULL,
    baths INT NOT NULL,
    image VARCHAR(300) NOT NULL,
    hostID INT NOT NULL,
    propertyTypeID INT NOT NULL,
    locationID INT NOT NULL,
    FOREIGN KEY (hostID) REFERENCES Host(hostID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (propertyTypeID) REFERENCES PropertyType(propertyTypeID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (locationID) REFERENCES Location(locationID) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS ListingAmenities;
CREATE TABLE ListingAmenities (
    listingID INT,
    amenitiesID INT,
    PRIMARY KEY (listingID, amenitiesID),
    FOREIGN KEY (listingID) REFERENCES Listing(listingID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (amenitiesID) REFERENCES Amenities(amenitiesID) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Strike;
CREATE TABLE Strike (
    strikeID INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    reason VARCHAR(100),
    guestID INT NOT NULL,
    FOREIGN KEY (guestID) REFERENCES Guest(guestID) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS ReviewRating;
CREATE TABLE ReviewRating (
    reviewRatingID INT AUTO_INCREMENT PRIMARY KEY,
    review VARCHAR(200),
    rating DECIMAL(3, 2),
    guestID INT NOT NULL,
    listingID INT NOT NULL,
    FOREIGN KEY (guestID) REFERENCES Guest(guestID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (listingID) REFERENCES Listing(listingID) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Booking;
CREATE TABLE Booking (
    bookingID INT AUTO_INCREMENT PRIMARY KEY,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    guestID INT NOT NULL,
    listingID INT NOT NULL,
    FOREIGN KEY (guestID) REFERENCES Guest(guestID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (listingID) REFERENCES Listing(listingID) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS PaymentType;
CREATE TABLE PaymentType (
	paymentTypeID INT AUTO_INCREMENT PRIMARY KEY,
    paymentOption VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS Payment;
CREATE TABLE Payment (
    paymentID INT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    bookingID INT NOT NULL,
    paymentTypeID INT NOT NULL,
    FOREIGN KEY (bookingID) REFERENCES Booking(bookingID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (paymentTypeID) REFERENCES PaymentType(paymentTypeID) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Guest (fName, lName, phone, email, addr, city, state, zip, dob, idForm, password)
VALUES ('John', 'Doe', '1234567890', 'john.doe@email.com', '123 Maple St', 'Springfield', 'PA', '19064', '1990-01-01', 
'Passport', 'password123');

INSERT INTO Amenities (amenity, description)
VALUES ('Wi-Fi', 'High-speed wireless internet'), ('Pool', 'Swimming pool'), ('Air Conditioning', 'Central air'), 
('Private Parking', 'On-site parking'), ('Kitchen', 'Fully-equipped kitchen'), ('TV', 'Smart TV'), 
('EV Charger', 'Faster charging'), ('Pets allowed', 'Allow cats and dogs'), ('Gym', 'Full gym');

INSERT INTO Host (hostFName, hostLName)
VALUES ('Jane', 'Smith'), ('Brian', 'Miller'), ('Locale', NULL), ('Hiroshi', NULL), ('Peishan', NULL), ('At Mine', NULL), 
('William', 'Stevens'), ('Michael', 'Garcia'), ('Sarai', NULL);

INSERT INTO BankAccount (routingNum, accountNum, hostID)
VALUES ('123456789', '987654321', 1);

INSERT INTO PropertyType (propertyType)
VALUES ('Entire home'), ('Loft'), ('Apartment'), ('Condo'), ('Studio'), ('Entire cabin');

INSERT INTO Location (city, state)
VALUES ('Philadelphia', 'Pennsylvania'), ('Rhinebeck', 'New York'), ('Kerhonkson', 'New York'), 
('Washington', 'District of Columbia'), ('Princeton', 'New Jersey');

INSERT INTO Listing (pricing, cleaningFee, title, description, maxGuests, bedrooms, beds, baths, image, hostID, propertyTypeID, locationID)
VALUES (540.0, 150.0, 'Architectural wonder in the woods', 'Unique experience, secluded. Enjoy a weekend or a few days eco-friendly 
retreat in an architectural, geometric masterpiece on 30 preserved acres just minutes from all that Rhinebeck and the Hudson Valley 
have to offer. The house is an open plan and can sleep 4!', 4, 1, 4, 2, 'listing1full.png', 1, 1, 2),
(85.0, 50.0, 'Luxury Loft -Tesla - Private Parking 21', 'Longshore Lofts features Boutique Luxury Lofts. Where industrial meets modern with 
13ft ceilings & windows. Once a former warehouse during the sawmill era. Each space includes in-suite laundry & top amenities, 
perfect for a weekend or a year-long stay. With lots of greenery & newly furnished.', 4, 2, 2, 1, 'listing2full.png', 2, 2, 1), 
(128.0, 50.0, 'Locale N Broad Retreat | Spacious & Modern 1BR', 'Locale combines the comfort of home with the reliability of 
hotel standards. Elevate your stay in this spacious one-bedroom unit, featuring ample living and seating areas and styled with modern 
mid-century and industrial design. Located above Santuccis Pizza, and near the iconic Osteria, this unit also has access to an exclusive 
rooftop offering downtown views. It is a great way to experience all that Philly has to offer!', 2, 1, 1, 1, 'listing3full.png', 3, 3, 1), 
(69.0, 50.0, 'Spacious & Modern 1BR Apt | Old City | 2 Beds', 'Unwind in the stylish 1-bedroom apt in Philadelphia. City is full of 
award-winning restaurants, bars, shops, historic landmarks, and attractions. Adventure through Philadelphia and the region easily 
from this prime location. Once you are ready to relax, retreat to the comfy apt.', 4, 1, 2, 1, 'listing4full.png', 4, 3, 1), 
(207.0, 155.0, 'A Black A- Frame: Sustainable Catskills Cabin', 'The Black A-frame is a two bed two bath 1961 cabin set on a 
private road in the heart of the Catskills in Kerhonkson, NY. It was named the Coolest A-frame in NY by the New York Post in 2020. 
Relax in the open dinning room with original wood ceilings and beams. Enjoy a walk outdoors to soak in the magic of the Catskills 
through the endless wooded views from the back yard!', 4, 2, 2, 2, 'listing5full.png', 5, 6, 3), 
(85.0, 25.0, 'King Suite in Philly Downtown', 'Experience the essence of Pennsylvania in Philadelphia Downtown. Nestled in 
the city center, our hotel offers seamless travel connectivity. Relax in upscale rooms with city views, ergonomic workspaces, 
and unwind with American cuisine at our dining spots.', 2, 1, 1, 1, 'listing6full.png', 6, 5, 1),
(135.0, 85.0, 'Capitol Hill Rowhouse Suite', 'This is the quintessential DC rowhouse garden-level apartment. Guests will enjoy 
a well-appointed apartment focused on privacy, comfort, and convenience, nestled in an unparalleled location with nearby access to 
reliable mass transit and complimentary on-street neighborhood parking. The Capitol Hill neighborhood is beautiful, historic, 
and perfectly situated in DC.', 3, 1, 1, 1, 'listing7full.png', 7, 3, 4),
(175.0, 75.0, 'Handsome stylish apartment for a Princeton escape!', 'A stylish, convenient and tranquil location that is perfect 
for a quick getaway, vacation, or a quiet and relaxing place to call home for an extended period of time. The 1-bedroom apartment has 
everything you need to feel at home.', 2, 1, 1, 1, 'listing8full.png', 8, 3, 5),
(112.0, 105.0, 'Big & Bright 1BR - Center City - Walk Everywhere!', 'This spacious , sun filled apartment is the perfect place to 
call home while you’re in Philly. We are centrally located and the neighborhood is very safe and walkable. Our extra tall ceilings 
and large bay windows make the space feel open and inviting. Enjoy our fully stocked kitchen, complete with coffee and tea. Relax 
after a day of sight seeing on our plush queen canopy bed.', 3, 1, 2, 1, 'listing9full.png', 9, 3, 1),
(81.0, 35.0, 'Oaks Studio| Rooftop, Gym, Free parking, Game Room', 'Welcome to the Oaks Studio, your perfect starting point for a 
memorable stay in Philadelphia! This stunning property offers an array of amenities to enhance your trip. Enjoy the convenience of 
central location and revel in the breathtaking city views from our rooftop. Take advantage of our in-building gym, game room, and 
golf simulator for ultimate relaxation and entertainment. Experience the pinnacle of luxury in the vibrant city of Philly.', 
2, 1, 1, 1, 'listing10full.png', 8, 5, 1);

INSERT INTO ListingAmenities (listingID, amenitiesID)
VALUES (1, 1), (1, 3), (1, 4), (1, 5), (1, 6), (2, 1), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (3, 1), (3, 3), (3, 4), (3, 5), 
(3, 6), (4, 1), (4, 3), (4, 4), (4, 5), (4, 6), (5, 1), (5, 3), (5, 4), (5, 6), (6, 1), (6, 3), (6, 4), (7, 1), (7, 3), (7, 4), (7,5), 
(7, 6), (8, 1), (8, 3), (8, 4), (8, 5), (8, 6), (9, 1), (9, 3), (9, 4), (9, 6), (10, 1), (10, 3), (10, 4), (10, 5), (10, 6), (10, 8);

INSERT INTO Strike (date, reason, guestID)
VALUES ('2024-04-01', 'Damaged property', 1);

INSERT INTO ReviewRating (review, rating, guestID, listingID)
VALUES ('Great place to stay!', 4.5, 1, 1);

INSERT INTO Booking (startDate, endDate, guestID, listingID)
VALUES ('2024-04-01', '2024-04-03', 1, 1);

INSERT INTO PaymentType (paymentOption)
VALUES ('Credit or debit card'), ('PayPal'), ('Google Pay');

INSERT INTO Payment (amount, date, bookingID, paymentTypeID)
VALUES (1328.40, '2024-04-01', 1, 1);
