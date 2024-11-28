USE Project

-- Stored Procedures

-- Drop Stored Procedures if they exist

IF OBJECT_ID('GetOwnerMailID', 'P') IS NOT NULL
    DROP PROCEDURE GetOwnerMailID;
IF OBJECT_ID('GetPropertyRent', 'P') IS NOT NULL
    DROP PROCEDURE GetPropertyRent;
IF OBJECT_ID('GetPropertyDetails', 'P') IS NOT NULL
    DROP PROCEDURE GetPropertyDetails;
IF OBJECT_ID('GetFlatmates', 'P') IS NOT NULL
    DROP PROCEDURE GetFlatmates;
GO

-- Get the email ID of a property owner by giving the property's unique registration number

CREATE PROCEDURE GetOwnerMailID 
	@PropertyRegNo INT,
	@MailID VARCHAR(100) OUTPUT
AS
BEGIN
	SELECT @MailID = o.ContactMail FROM Owner o
	JOIN Property p ON p.OwnerID = o.OwnerID
	WHERE p.PropertyID = @PropertyRegNo
END
GO

-- Get the cheapest monthly rent for a property in a specified location

CREATE PROCEDURE GetPropertyRent
	@Location VARCHAR(255),
	@MonthlyRent DECIMAL(10,2) OUTPUT 
AS
BEGIN
	SELECT @MonthlyRent=MIN(l.MonthlyRent) FROM Lease l
	JOIN Property p ON p.PropertyID = l.PropertyID
	WHERE p.Address LIKE '%' + @Location + '%'
END
GO

-- Get the property details by sepcifying the type of property and the number of bedrooms and bathrooms

CREATE PROCEDURE GetPropertyDetails 
	@PropertyType VARCHAR(50), 
	@Beds INT, 
	@Baths INT 
AS
BEGIN
	SELECT p.PropertyID, p.Address, p.KitchenAppliances, p.FacilitiesIncluded,
		   o.FirstName, o.LastName, o.ContactMail,
		   l.MonthlyRent AS CurrentMonthlyRent, l.MoveInCost
	FROM Property p
	JOIN Owner o ON o.OwnerID = p.OwnerID
	JOIN Lease l ON l.PropertyID = p.PropertyID
	WHERE p.PropertyType = @PropertyType AND p.NoOfBeds = @Beds AND p.NoOfBaths = @Baths
END
GO

-- Get Flatmate details by mentioning preferences as input

CREATE PROCEDURE GetFlatmates
	@Gender VARCHAR(10), 
	@FoodHabit VARCHAR(50), 
	@CleanlinessHabit VARCHAR(50),
	@RoomType VARCHAR(50),
	@RentStart INT,
	@RentEnd INT
AS
BEGIN
	SELECT r.PersonID, r.FirstName, r.LastName, r.Email, r.Phone, r.Gender, r.Languages, r.WorkExp, r.FoodHabit, 
		   r.CleanlinessHabit, r.CookingSkills, r.Hobbies, r.Personality,
		   p.RoomType, p.NoOfRoommates, p.ApartmentType, p.RentRange AS PreferredRent, p.RoommateAge AS PreferredRoommateAge,
		   p.RoommateCourse AS PreferredRoommateCourse, p.RoommateGender AS PreferredRoommateGender,
		   p.RoommateFoodHabits AS PreferredRoommateFoodHabits, p.RoommateCleanlinessHabits AS PreferredRoommateCleanlinessHabits,
		   p.RoommateOtherDetails AS PreferredRoommateOtherDetails
	FROM Roommates r
	JOIN Preferences p ON p.PersonID = r.PersonID
	WHERE r.Gender = @Gender AND r.FoodHabit = @FoodHabit AND r.CleanlinessHabit = @CleanlinessHabit
		  AND p.RoomType = @RoomType AND p.RentRange BETWEEN @RentStart AND @RentEnd
END
GO

-- Test Cases

-- -- 1. Test Owner Contact Details
DECLARE @ContactMailID VARCHAR(100)
EXEC GetOwnerMailID @PropertyRegNo = 3, @MailID = @ContactMailID OUTPUT
PRINT 'The email ID of the owner is ' + @ContactMailID

-- -- 2. Test Cheapest Rent of Property 
DECLARE @PropertyRent DECIMAL (10,2)
EXEC GetPropertyRent @Location = 'Downtown', @MonthlyRent = @PropertyRent OUTPUT
PRINT 'The rent of property is ' + CAST(@PropertyRent AS VARCHAR(10))

-- -- 3. Test Details of Property
EXEC GetPropertyDetails @PropertyType = 'Apartment', @Beds = 2, @Baths = 1

-- -- 4. Test Details of Flatmates
EXEC GetFlatmates @Gender = 'Male', @FoodHabit = 'Non-Vegetarian', @CleanlinessHabit = 'Clean',
   	    		  @RoomType = 'Shared', @RentStart = 800, @RentEnd = 1500



-- User Defined Functions

-- Drop UDFs if they exist
IF OBJECT_ID('dbo.GetAverageRentPerPerson', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetAverageRentPerPerson;
IF OBJECT_ID('dbo.CalculateTotalLeaseCost', 'FN') IS NOT NULL
    DROP FUNCTION dbo.CalculateTotalLeaseCost;
IF OBJECT_ID('dbo.CheckLeaseOverlap', 'FN') IS NOT NULL
    DROP FUNCTION dbo.CheckLeaseOverlap;
IF OBJECT_ID('dbo.CalculateCompatibility', 'FN') IS NOT NULL
    DROP FUNCTION dbo.CalculateCompatibility;
GO

-- 1. Calculate Average Rent for a Roommate Group
CREATE FUNCTION dbo.GetAverageRentPerPerson(@RGID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalRent DECIMAL(10, 2);
    DECLARE @NumRoommates INT;

    -- Get the total rent for the group
    SELECT @TotalRent = RentSplit
    FROM RoommatesGroup
    WHERE RGID = @RGID;

    -- Get the number of roommates in the group
    SELECT @NumRoommates = COUNT(*)
    FROM RRG
    WHERE RGID = @RGID;

    -- Return the average rent per person
    RETURN CASE 
        WHEN @NumRoommates > 0 THEN @TotalRent / @NumRoommates
        ELSE NULL -- Handle cases where no roommates are found
    END;
END;
GO

-- 2. Calculate Total Lease Cost for a Property
CREATE FUNCTION dbo.CalculateTotalLeaseCost(@LeaseID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @MonthlyRent DECIMAL(10, 2);
    DECLARE @MoveInCost DECIMAL(10, 2);
    DECLARE @LeaseDuration INT; -- In months

    -- Get lease details
    SELECT 
        @MonthlyRent = MonthlyRent, 
        @MoveInCost = MoveInCost,
        @LeaseDuration = DATEDIFF(MONTH, LeaseStartDate, LeaseEndDate)
    FROM Lease
    WHERE LeaseID = @LeaseID;

    -- Calculate total lease cost
    RETURN (@MonthlyRent * @LeaseDuration) + @MoveInCost;
END;
GO

-- 3. Check Lease Overlap for Roommate Group
CREATE FUNCTION dbo.CheckLeaseOverlap(@RGID INT)
RETURNS BIT
AS
BEGIN
    DECLARE @OverlapCount INT;

    -- Count overlapping leases
    SELECT @OverlapCount = COUNT(*)
    FROM Lease l1
    CROSS JOIN Lease l2
    WHERE l1.RGID = @RGID AND l2.RGID = @RGID
      AND l1.LeaseID <> l2.LeaseID -- Exclude self-comparison
      AND l1.LeaseEndDate > l2.LeaseStartDate
      AND l1.LeaseStartDate < l2.LeaseEndDate;

    -- Return 1 if overlap exists, otherwise 0
    RETURN CASE 
        WHEN @OverlapCount > 0 THEN 1
        ELSE 0
    END;
END;
GO

-- 4. Calculate Compatibility Score Between Two Roommates
CREATE FUNCTION dbo.CalculateCompatibility(
    @PersonID1 INT,
    @PersonID2 INT
)
RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @Score DECIMAL(5, 2) = 0;

    -- Increment score for matching preferences
    SELECT @Score = @Score + 25
    FROM Preferences p1
    INNER JOIN Preferences p2 ON p1.PersonID = @PersonID1 AND p2.PersonID = @PersonID2
    WHERE p1.ApartmentType = p2.ApartmentType;

    SELECT @Score = @Score + 25
    FROM Preferences p1
    INNER JOIN Preferences p2 ON p1.PersonID = @PersonID1 AND p2.PersonID = @PersonID2
    WHERE p1.RoommateCleanlinessHabits = p2.RoommateCleanlinessHabits;

    SELECT @Score = @Score + 25
    FROM Preferences p1
    INNER JOIN Preferences p2 ON p1.PersonID = @PersonID1 AND p2.PersonID = @PersonID2
    WHERE p1.RoommateFoodHabits = p2.RoommateFoodHabits;

    SELECT @Score = @Score + 25
    FROM Roommates r1
    INNER JOIN Roommates r2 ON r1.PersonID = @PersonID1 AND r2.PersonID = @PersonID2
    WHERE r1.Gender = r2.Gender;

    RETURN @Score;
END;
GO

-- Test Cases

-- -- 1. Test Average Rent Function
SELECT dbo.GetAverageRentPerPerson(1) AS AvgRent;

-- -- 2. Test Total Lease Cost Function
SELECT dbo.CalculateTotalLeaseCost(3) AS TotalLeaseCost;

-- -- 3. Test Lease Overlap Function
SELECT dbo.CheckLeaseOverlap(1) AS OverlapExists;

-- -- 5. Test Compatibility Score Function
SELECT dbo.CalculateCompatibility(1, 5) AS CompatibilityScore;
SELECT dbo.CalculateCompatibility(1, 2) AS CompatibilityScore;



-- Views

-- Drop Views if they exist

IF OBJECT_ID('PropertyRentedLastMonth', 'V') IS NOT NULL
    DROP VIEW PropertyRentedLastMonth;
IF OBJECT_ID('PropertyNotRented', 'V') IS NOT NULL
    DROP VIEW PropertyNotRented;
IF OBJECT_ID('NoOfPeopleConverted', 'V') IS NOT NULL
    DROP VIEW NoOfPeopleConverted;
IF OBJECT_ID('NoOfLeasedProperty', 'V') IS NOT NULL
    DROP VIEW NoOfLeasedProperty;
GO


-- Get the number of properties rented in last month

CREATE VIEW PropertyRentedLastMonth AS
SELECT DATENAME(MONTH, l.LeaseStartDate) AS LeaseMonth, COUNT(DISTINCT p.PropertyID) AS NoOfProperties FROM Property p
JOIN Lease l ON l.PropertyID = p.PropertyID
WHERE LeaseStartDate > DATEADD(MONTH, -1, GETDATE()) 
GROUP BY DATENAME(MONTH, l.LeaseStartDate)
GO


-- Get the details of property not rented in the last year

CREATE VIEW PropertyNotRented AS
SELECT p.PropertyID, p.Address, l.MonthlyRent, l.LeaseEndDate FROM Property p
JOIN Lease l ON l.PropertyID = p.PropertyID
WHERE l.LeaseEndDate < DATEADD(YEAR, -1, GETDATE())
GO


-- Get the number of people converted to clients in the last year
-- This view can also be used for getting the conversion rate

CREATE VIEW NoOfPeopleConverted AS
SELECT COUNT(DISTINCT PersonID) AS NoOfPeople FROM RRG
WHERE RGID IN
	(SELECT DISTINCT RGID FROM Lease
	WHERE LeaseSignDate > DATEADD(YEAR, -1, GETDATE()))
GO


-- Get the number of properties from the wishlist that have been leased in the last month

CREATE VIEW NoOfLeasedProperty AS
SELECT COUNT(DISTINCT LeaseID) AS NoOfLeasedProperty FROM Lease
WHERE PropertyID IN
(SELECT DISTINCT PropertyID FROM Wishlist
WHERE DateOfAddition > DATEADD(MONTH, -1, GETDATE()))
GO


-- Test Cases

-- -- 1.Test Properties Rented in Last Month
SELECT * FROM PropertyRentedLastMonth

-- -- 2. Test Details of Properties Not Rented in Last Year
SELECT * FROM PropertyNotRented

-- -- 3. Test Number of People to Clients
SELECT * FROM NoOfPeopleConverted

-- -- 4. Test Number of Properties Leased Out from Wishlist in Last Month
SELECT * FROM NoOfLeasedProperty



-- DML Triggers

-- Drop DML Triggers if they exist

IF OBJECT_ID('WithdrawnApplications', 'TR') IS NOT NULL
    DROP TRIGGER WithdrawnApplications;
IF OBJECT_ID('DeletedPropertiesFromWishlist', 'TR') IS NOT NULL
    DROP TRIGGER DeletedPropertiesFromWishlist;
GO


-- DML Trigger to store the data of applications that were withdrawn

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ApplicationWithdrawals' AND xtype='U')
BEGIN
CREATE TABLE ApplicationWithdrawals (
	AppWithdrawalID INT IDENTITY(1,1) PRIMARY KEY,
	ApplicationID INT,
	PersonID INT,
	RGID INT,
	PropertyID INT,
	PreviousApplicationStatus VARCHAR(20),
	ApplicationDate DATE,
	WithdrawalDate DATETIME DEFAULT GETDATE()
)
END
GO

CREATE TRIGGER WithdrawnApplications
ON ApplicationSubmission
AFTER DELETE
AS
BEGIN
	INSERT INTO ApplicationWithdrawals (ApplicationID, PersonID, RGID, PropertyID, PreviousApplicationStatus, ApplicationDate, WithdrawalDate)
	SELECT ApplicationID, PersonID, RGID, PropertyID, ApplicationStatus, ApplicationDate, GETDATE()
	FROM deleted
END
GO


-- DML trigger to store the data of properties that were removed from the wishlist

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='WishlistDeletedProperties' AND xtype='U')
BEGIN
CREATE TABLE WishlistDeletedProperties (
	DeletedPropertyID INT IDENTITY(1,1) PRIMARY KEY,
	WishlistID INT,
	PersonID INT,
	RGID INT,
	PropertyID INT,
	DateOfAddition DATE,
	DateofDeletion DATETIME DEFAULT GETDATE()
)
END
GO

CREATE TRIGGER DeletedPropertiesFromWishlist
ON Wishlist
AFTER DELETE
AS
BEGIN
	INSERT INTO WishlistDeletedProperties (WishlistID, PersonID, RGID, PropertyID, DateOfAddition, DateofDeletion)
	SELECT WishlistID, PersonID, RGID, PropertyID, DateOfAddition, GETDATE()
	FROM deleted
END
GO


-- Test Cases

-- -- 1. Test Store Withdrawn/Deleted Application Data
DELETE FROM ApplicationSubmission WHERE PersonID = 1 and PropertyID = 1;
SELECT * FROM ApplicationSubmission
SELECT * FROM ApplicationWithdrawals

-- -- 2. Test Store Removed/Deleted Property Data from Wishlist
DELETE FROM Wishlist WHERE PersonID = 3 and PropertyID = 3;
SELECT * FROM Wishlist
SELECT * FROM WishlistDeletedProperties