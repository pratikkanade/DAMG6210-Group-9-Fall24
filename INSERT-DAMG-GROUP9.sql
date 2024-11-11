-- CREATE DATABASE PROJECT
USE PROJECT;
INSERT INTO Roommates (Username, Password, FirstName, LastName, Email, Phone, DOB, Address, Gender, Languages, WorkExp, FoodHabit, CleanlinessHabit, CookingSkills, Hobbies, Personality) 
VALUES
 ('user1', 'pass1', 'Alice', 'Johnson', 'alice.johnson@example.com', '1234567890', '1990-01-01', '123 Main St', 'Female', 'English, Spanish', 5, 'Vegetarian', 'Tidy', 'Advanced', 'Reading, Hiking', 'Friendly'), 
('user2', 'pass2', 'Bob', 'Smith', 'bob.smith@example.com', '0987654321', '1985-05-10', '456 Elm St', 'Male', 'English', 10, 'Non-Vegetarian', 'Clean', 'Intermediate', 'Cooking, Swimming', 'Outgoing'), 
('user3', 'pass3', 'Carol', 'Williams', 'carol.williams@example.com', '5555555555', '1992-02-20', '789 Oak St', 'Female', 'English, French', 2, 'Vegan', 'Organized', 'Beginner', 'Yoga, Reading', 'Calm'), 
('user4', 'pass4', 'David', 'Brown', 'david.brown@example.com', '4444444444', '1994-09-15', '101 Maple St', 'Male', 'English', 7, 'Non-Vegetarian', 'Tidy', 'Advanced', 'Travelling, Sports', 'Adventurous'), 
('user5', 'pass5', 'Eve', 'Davis', 'eve.davis@example.com', '3333333333', '1991-11-11', '202 Pine St', 'Female', 'English, German', 4, 'Vegetarian', 'Clean', 'Intermediate', 'Photography, Writing', 'Creative'),
 ('user6', 'pass6', 'Frank', 'Miller', 'frank.miller@example.com', '6666666666', '1988-07-07', '303 Cedar St', 'Male', 'English, Japanese', 8, 'Non-Vegetarian', 'Organized', 'Advanced', 'Gaming, Cooking', 'Energetic'), 
('user7', 'pass7', 'Grace', 'Wilson', 'grace.wilson@example.com', '7777777777', '1993-03-03', '404 Birch St', 'Female', 'English, Italian', 3, 'Vegan', 'Tidy', 'Beginner', 'Dancing, Painting', 'Optimistic'), 
('user8', 'pass8', 'Henry', 'Moore', 'henry.moore@example.com', '8888888888', '1995-06-06', '505 Willow St', 'Male', 'English', 6, 'Non-Vegetarian', 'Clean', 'Intermediate', 'Fishing, Travelling', 'Laid-back'), 
('user9', 'pass9', 'Ivy', 'Taylor', 'ivy.taylor@example.com', '9999999999', '1996-12-12', '606 Poplar St', 'Female', 'English, Mandarin', 1, 'Vegetarian', 'Organized', 'Beginner', 'Cooking, Blogging', 'Friendly'), 
('user10', 'pass10', 'Jack', 'Anderson', 'jack.anderson@example.com', '2222222222', '1987-10-10', '707 Fir St', 'Male', 'English, Russian', 9, 'Non-Vegetarian', 'Tidy', 'Advanced', 'Reading, Movies', 'Intellectual');

INSERT INTO Owner (FirstName, LastName, NoOfProperties, ContactMail, OfficeHours) VALUES 
('Alice', 'Johnson', 3, 'alice.johnson@example.com', '9 AM - 5 PM'),
('Bob', 'Smith', 5, 'bob.smith@example.com', '10 AM - 6 PM'), 
('Carol', 'Williams', 2, 'carol.williams@example.com', '8 AM - 4 PM'), 
('David', 'Brown', 4, 'david.brown@example.com', '9 AM - 5 PM'), 
('Eve', 'Davis', 1, 'eve.davis@example.com', '11 AM - 7 PM'), 
('Frank', 'Miller', 6, 'frank.miller@example.com', '7 AM - 3 PM'), 
('Grace', 'Wilson', 0, 'grace.wilson@example.com', '8 AM - 4 PM'), 
('Hank', 'Moore', 8, 'hank.moore@example.com', '12 PM - 8 PM'), 
('Ivy', 'Taylor', 3, 'ivy.taylor@example.com', '9 AM - 5 PM'), 
('Jack', 'Anderson', 7, 'jack.anderson@example.com', '6 AM - 2 PM'), 
('Karen', 'Thomas', 1, 'karen.thomas@example.com', '10 AM - 6 PM'), 
('Leo', 'Jackson', 5, 'leo.jackson@example.com', '9 AM - 5 PM'), 
('Mia', 'White', 3, 'mia.white@example.com', '11 AM - 7 PM'), 
('Nina', 'Harris', 0, 'nina.harris@example.com', '8 AM - 4 PM'), 
('Oscar', 'Martin', 9, 'oscar.martin@example.com', '12 PM - 8 PM'), 
('Paul', 'Garcia', 2, 'paul.garcia@example.com', '7 AM - 3 PM'), 
('Quinn', 'Martinez', 4, 'quinn.martinez@example.com', '10 AM - 6 PM'), 
('Rita', 'Rodriguez', 6, 'rita.rodriguez@example.com', '8 AM - 4 PM'), 
('Sam', 'Lewis', 5, 'sam.lewis@example.com', '9 AM - 5 PM'), 
('Tina', 'Walker', 2, 'tina.walker@example.com', '11 AM - 7 PM'),
('Uma', 'Scott', 3, 'uma.scott@example.com', '9 AM - 5 PM'), 
('Vera', 'Green', 2, 'vera.green@example.com', '8 AM - 4 PM'), 
('Walter', 'King', 4, 'walter.king@example.com', '10 AM - 6 PM'), 
('Xander', 'Hill', 0, 'xander.hill@example.com', '11 AM - 7 PM'), 
('Yara', 'Baker', 5, 'yara.baker@example.com', '7 AM - 3 PM'), 
('Zane', 'Adams', 3, 'zane.adams@example.com', '9 AM - 5 PM'), 
('Ava', 'Reed', 6, 'ava.reed@example.com', '6 AM - 2 PM'), 
('Ben', 'Perez', 1, 'ben.perez@example.com', '8 AM - 4 PM'), 
('Clara', 'Long', 2, 'clara.long@example.com', '12 PM - 8 PM'),
 ('Dylan', 'Price', 7, 'dylan.price@example.com', '9 AM - 5 PM');

INSERT INTO Bank (AccountID, RoutingNumber, BankName, BankAddress) VALUES 
(1000000000001, '111000025', 'Bank of America', '123 Elm St, NY'),
(1000000000002, '111000026', 'Chase Bank', '456 Pine Ave, CA'),
(1000000000003, '111000027', 'Wells Fargo', '789 Maple Rd, TX'),
(1000000000004, '111000028', 'Citibank', '321 Oak Ln, IL'),
(1000000000005, '111000029', 'HSBC', '654 Cedar St, FL'),
(1000000000006, '111000030', 'Capital One', '987 Willow Blvd, MA'),
(1000000000007, '111000031', 'PNC Bank', '123 Walnut Dr, NJ'),
(1000000000008, '111000032', 'TD Bank', '456 Spruce Ct, PA'),
(1000000000009, '111000033', 'U.S. Bank', '789 Birch Pl, CO'),
(1000000000010, '111000034', 'Ally Bank', '321 Aspen Blvd, WA'),
(1000000000011, '111000035', 'Regions Bank', '101 Pine St, GA'),
(1000000000012, '111000036', 'SunTrust Bank', '202 Oak Ave, VA'),
(1000000000013, '111000037', 'Fifth Third Bank', '303 Maple Blvd, MI'),
(1000000000014, '111000038', 'KeyBank', '404 Cedar Ln, OH'),
(1000000000015, '111000039', 'BB&T', '505 Willow Rd, NC'),
(1000000000016, '111000040', 'Santander Bank', '606 Spruce Ct, DE'),
(1000000000017, '111000041', 'M&T Bank', '707 Birch Blvd, MD'),
(1000000000018, '111000042', 'Comerica Bank', '808 Aspen St, TX'),
(1000000000019, '111000043', 'Huntington Bank', '909 Oak Dr, OH'),
(1000000000020, '111000044', 'Citizens Bank', '1010 Maple St, RI');

INSERT INTO RoommatesGroup (RentSplit, RoommateAgreement, RentersInsurance) VALUES
(500.00, 'Agreement signed for 6 months', 'Insurance active until Dec 2024'), 
(600.00, 'Agreement signed for 12 months', 'Insurance active until Jun 2025'),
(450.00, 'Agreement pending approval', 'Insurance in process'), 
(750.00, 'Agreement signed for 3 months', 'Insurance valid till Mar 2025'), 
(800.00, 'Agreement signed for 12 months', 'Insurance active until Dec 2025'), 
(550.00, 'Agreement signed for 6 months', 'Insurance active until Sep 2024'), 
(700.00, 'Agreement renewal in progress', 'Insurance renewed till Jun 2024'), 
(650.00, 'Agreement signed for 9 months', 'Insurance active until Oct 2025'), 
(900.00, 'Agreement signed for 6 months', 'Insurance active until Jul 2024'), 
(500.00, 'Agreement under legal review', 'Insurance active until Dec 2024');

INSERT INTO Property (OwnerID, Address, PropertyType, NoOfBeds, NoOfBaths, KitchenAppliances, FacilitiesIncluded)
VALUES
(1, '123 Main St, Cityville', 'Apartment', 2, 1, 'Refrigerator, Stove', 'Gym, Pool'),
(2, '456 Elm St, Townsville', 'House', 3, 2, 'Refrigerator, Oven, Dishwasher', 'Garage, Garden'),
(3, '789 Oak St, Metropolis', 'Condo', 1, 1, 'Microwave, Refrigerator', 'Rooftop Deck, Gym'),
(4, '101 Maple St, Village', 'Townhouse', 4, 3, 'Full Kitchen', 'Community Center, Pool'),
(5, '202 Pine St, Suburbia', 'Apartment', 2, 1, 'Microwave, Stove, Refrigerator', 'Laundry Room'),
(6, '303 Cedar St, Lakeside', 'Cabin', 2, 1, 'Stove, Refrigerator', 'Lake Access'),
(7, '404 Birch St, Uptown', 'Loft', 1, 1, 'Induction Cooktop, Refrigerator', 'Concierge Service'),
(8, '505 Walnut St, Downtown', 'Studio', 1, 1, 'Stove, Refrigerator, Microwave', 'Gym'),
(9, '606 Chestnut St, Midvale', 'House', 5, 4, 'Full Kitchen', 'Pool, Garden, Garage'),
(10, '707 Poplar St, Riverside', 'Apartment', 3, 2, 'Refrigerator, Stove', 'Community Gym, Parking');

INSERT INTO Preferences (PersonID, RoomType, NoOfRoommates, ApartmentType, RentRange, ApartmentArea, RoommateAge, RoommateCourse, RoommateGender, RoommateFoodHabits, RoommateCleanlinessHabits, RoommateOtherDetails) 
VALUES 
(1, 'Single', 1, 'Apartment', 1000, 700, 25, 'Engineering', 'F', 'Vegetarian', 'Very Clean', 'Prefers quiet roommates'), 
(2, 'Shared', 2, 'Apartment', 800, 600, 28, 'Arts', 'M', 'Non-Vegetarian', 'Moderate', 'Enjoys social gatherings'), 
(3, 'Single', 1, 'Studio', 1200, 500, 23, 'Science', 'F', 'Vegan', 'Very Clean', 'Looking for a tidy roommate'), 
(4, 'Shared', 3, 'House', 600, 900, 27, 'Business', 'M', 'Non-Vegetarian', 'Tidy', 'Preferably non-smoker'), 
(5, 'Single', 1, 'Apartment', 1500, 800, 26, 'Law', 'F', 'Vegetarian', 'Very Clean', 'Would like a quiet environment'),
 (6, 'Shared', 2, 'Apartment', 700, 650, 29, 'Medicine', 'M', 'Non-Vegetarian', 'Moderate', 'Open to pet-friendly roommates'),
 (7, 'Shared', 2, 'House', 850, 1000, 24, 'Engineering', 'M', 'Vegan', 'Organized', 'Prefers active lifestyle'), 
(8, 'Single', 1, 'Studio', 1100, 550, 22, 'Arts', 'F', 'Vegetarian', 'Very Clean', 'Non-smoker, quiet place preferred'),
 (9, 'Shared', 3, 'Apartment', 900, 750, 30, 'IT', 'M', 'Non-Vegetarian', 'Tidy', 'Flexible with quiet hours'), 
(10, 'Single', 1, 'Apartment', 1300, 700, 28, 'Design', 'F', 'Vegetarian', 'Very Clean', 'Prefers no pets');

INSERT INTO Broker (OwnerID, NoOfClients, LicenseNumber, Rating)
VALUES
    (1, 15, 'LIC12345A', 8.75),
    (2, 20, 'LIC12346B', 9.10),
    (3, 5, 'LIC12347C', 7.20),
    (4, 12, 'LIC12348D', 6.50),
    (5, 18, 'LIC12349E', 8.00),
    (6, 7, 'LIC12350F', 9.30),
    (7, 9, 'LIC12351G', 8.60),
    (8, 25, 'LIC12352H', 7.80),
    (9, 10, 'LIC12353I', 6.90),
    (10, 30, 'LIC12354J', 9.50);

INSERT INTO PropertyManager (OwnerID, NoOfPropertiesManaged, SSN)
VALUES
    (11, 10, '123-45-6789'),
    (12, 5, '234-56-7890'),
    (13, 7, '345-67-8901'),
    (14, 3, '456-78-9012'),
    (15, 8, '567-89-0123'),
    (16, 6, '678-90-1234'),
    (17, 12, '789-01-2345'),
    (18, 4, '890-12-3456'),
    (19, 15, '901-23-4567'),
    (20, 9, '012-34-5678');

INSERT INTO RoommateBank (AccountID, PersonID) VALUES 
(1000000000001, 1),
(1000000000002, 2),
(1000000000003, 3),
(1000000000004, 4),
(1000000000005, 5),
(1000000000006, 6),
(1000000000007, 7),
(1000000000008, 8),
(1000000000009, 9),
(1000000000010, 10);

INSERT INTO OwnerBank (AccountID, OwnerID) VALUES 
(1000000000011, 1),
(1000000000012, 2),
(1000000000013, 3),
(1000000000014, 4),
(1000000000015, 5),
(1000000000016, 6),
(1000000000017, 7),
(1000000000018, 8),
(1000000000019, 9),
(1000000000020, 10);

INSERT INTO RRG (PersonID, RGID) 
VALUES
 (1, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(5, 5), 
(6, 6), 
(7, 7), 
(8, 8), 
(9, 9), 
(10, 10);

INSERT INTO Wishlist (PersonID, RGID, PropertyID, DateOfAddition)
VALUES
(1, 1, 1, '2024-01-10'),
(2, 2, 2, '2024-01-15'),
(3, 3, 3, '2024-02-20'),
(4, 4, 4, '2024-03-01'),
(5, 5, 5, '2024-04-05'),
(6, 6, 6, '2024-05-15'),
(7, 7, 7, '2024-06-10'),
(8, 8, 8, '2024-07-20'),
(9, 9, 9, '2024-08-25'),
(10,10, 10, '2024-09-30');

INSERT INTO Lease (RGID, PropertyID, LeaseSignDate, MonthlyRent, LeaseStartDate, LeaseEndDate, MoveInCost)
VALUES
(1, 1, '2024-01-05', 1200.00, '2024-01-10', '2025-01-10', 2400.00),
(2, 2, '2024-02-10', 1500.00, '2024-02-15', '2025-02-15', 3000.00),
(3, 3, '2024-03-20', 800.00, '2024-03-25', '2025-03-25', 1600.00),
(4, 4, '2024-04-15', 2000.00, '2024-04-20', '2025-04-20', 4000.00),
(5, 5, '2024-05-10', 950.00, '2024-05-15', '2025-05-15', 1900.00),
(6, 6, '2024-06-05', 1100.00, '2024-06-10', '2025-06-10', 2200.00),
(7, 7, '2024-07-01', 1300.00, '2024-07-05', '2025-07-05', 2600.00),
(8, 8, '2024-08-12', 700.00, '2024-08-15', '2025-08-15', 1400.00),
(9, 9, '2024-09-05', 2500.00, '2024-09-10', '2025-09-10', 5000.00),
(10, 10, '2024-10-01', 1700.00, '2024-10-05', '2025-10-05', 3400.00);

INSERT INTO ApplicationSubmission (PersonID, RGID, PropertyID, ApplicationStatus) VALUES 
(1, 1, 1, 'Pending'),
(2, 1, 2, 'Approved'),
(3, 2, 3, 'Rejected'),
(4, 2, 4, 'Approved'),
(5, 3, 5, 'Pending'),
(6, 3, 6, 'Rejected'),
(7, 4, 7, 'Approved'),
(8, 4, 8, 'Pending'),
(9, 5, 9, 'Rejected'),
(10, 5, 10, 'Approved');

INSERT INTO Communication (PersonID, OwnerID, DateOfCommunication, Description) VALUES
(1, 1, '2024-10-01', 'Initial communication regarding move-in.'),
(2, 2, '2024-10-05', 'Discussion on rental terms and conditions.'),
(3, 3, '2024-10-10', 'Issues with maintenance and repair requests.'),
(4, 4, '2024-10-12', 'Request for additional keys for roommate.'),
(5, 5, '2024-10-15', 'Communication about noise complaints.'),
(6, 6, '2024-10-20', 'Negotiation on security deposit return terms.'),
(7, 7, '2024-10-22', 'Agreement on payment methods for utilities.'),
(8, 8, '2024-10-25', 'Request for rent receipt for tax purposes.'),
(9, 9, '2024-10-28', 'Follow-up on maintenance request.'),
(10, 10, '2024-10-30', 'Final communication for move-out process.'),
(1, 2, '2024-11-02', 'Report of water leakage in kitchen.'),
(3, 4, '2024-11-05', 'Request for permission to add extra furniture.'),
(5, 6, '2024-11-08', 'Complaint about frequent power cuts.'),
(7, 8, '2024-11-10', 'Inquiry about garbage disposal schedule.'),
(9, 10, '2024-11-12', 'Request to replace broken window blinds.'),
(2, 1, '2024-11-15', 'Communication about repainting the apartment.'),
(4, 3, '2024-11-18', 'Issue regarding delayed internet service.'),
(6, 5, '2024-11-20', 'Request for parking spot allocation.'),
(8, 7, '2024-11-22', 'Discussion on raising utility caps.'),
(10, 9, '2024-11-25', 'Inquiry about holiday decoration policies.');

INSERT INTO Complaints (CommunicationID, DateOfComplaint, CategoryOfResolution) VALUES
(1, '2024-10-02', 'Noise Resolution'),
(2, '2024-10-06', 'Maintenance Resolution'),
(3, '2024-10-11', 'Payment Resolution'),
(4, '2024-10-13', 'Access Resolution'),
(5, '2024-10-16', 'Behavior Resolution'),
(6, '2024-10-21', 'Deposit Resolution'),
(7, '2024-10-23', 'Utility Payment'),
(8, '2024-10-26', 'Documentation'),
(9, '2024-10-29', 'Maintenance Follow-up'),
(10, '2024-10-31', 'Move-out Resolution');

INSERT INTO Transactions (CommunicationID, Amount, SentByAccountNo, ReceivedByAccountNo) VALUES
(1, 1200.00, 1000000000001, 1000000000011),
(2, 1500.00, 1000000000002, 1000000000012),
(3, 750.00, 1000000000003, 1000000000013),
(4, 800.00, 1000000000004, 1000000000014),
(5, 950.00, 1000000000005, 1000000000015),
(6, 500.00, 1000000000006, 1000000000016),
(7, 1100.00, 1000000000007, 1000000000017),
(8, 1300.00, 1000000000008, 1000000000018),
(9, 1400.00, 1000000000009, 1000000000019),
(10, 1000.00, 1000000000010, 1000000000020);
