CREATE DATABASE Project

USE Project

-- Drop tables if they exist to avoid errors on re-creation
DROP TABLE IF EXISTS Wishlist;
DROP TABLE IF EXISTS Lease;
DROP TABLE IF EXISTS ApplicationSubmission;
DROP TABLE IF EXISTS RoommateBank;
DROP TABLE IF EXISTS OwnerBank;
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Complaints;
DROP TABLE IF EXISTS Communication;
DROP TABLE IF EXISTS Preferences;
DROP TABLE IF EXISTS RRG;
DROP TABLE IF EXISTS RoommatesGroup;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Broker;
DROP TABLE IF EXISTS PropertyManager;
DROP TABLE IF EXISTS Owner;
DROP TABLE IF EXISTS Bank;
DROP TABLE IF EXISTS Roommates;

-- Create Roommates table
CREATE TABLE Roommates (
   PersonID INT PRIMARY KEY IDENTITY(1,1),
   Username VARCHAR(50) NOT NULL,
   Password VARCHAR(50) NOT NULL,
   FirstName VARCHAR(50),
   LastName VARCHAR(50),
   Email VARCHAR(100),
   Phone VARCHAR(15),
   DOB DATE,
   Address VARCHAR(255),
   Gender CHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')), 
   Languages VARCHAR(255),
   WorkExp INT,
   FoodHabit VARCHAR(50),
   CleanlinessHabit VARCHAR(50),
   CookingSkills VARCHAR(50),
   Hobbies VARCHAR(255),
   Personality VARCHAR(50),
   AccountCreationDate DATE NOT NULL DEFAULT GETDATE()
);

-- Create Owner table
CREATE TABLE Owner (
    OwnerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    NoOfProperties INT CHECK (NoOfProperties >= 0),
    ContactMail VARCHAR(100),
    OfficeHours VARCHAR(50)
);

-- Create Property table
CREATE TABLE Property (
    PropertyID INT PRIMARY KEY IDENTITY(1,1),
    OwnerID INT FOREIGN KEY REFERENCES Owner(OwnerID),
    Address VARCHAR(255) NOT NULL,
    PropertyType VARCHAR(50),
    NoOfBeds INT CHECK (NoOfBeds > 0),
    NoOfBaths INT CHECK (NoOfBaths > 0),
    KitchenAppliances VARCHAR(255),
    FacilitiesIncluded VARCHAR(255)
);

-- Create Preferences table
CREATE TABLE Preferences (
   PreferenceID INT PRIMARY KEY IDENTITY(1,1),
   PersonID INT FOREIGN KEY REFERENCES Roommates(PersonID),
   RoomType VARCHAR(50),
   NoOfRoommates INT CHECK (NoOfRoommates >= 1),
   ApartmentType VARCHAR(50),
   RentRange INT,
   ApartmentArea INT,
   RoommateAge INT,
   RoommateCourse VARCHAR(30),
   RoommateGender CHAR(1),
   RoommateFoodHabits VARCHAR(50),
   RoommateCleanlinessHabits VARCHAR(50),
   RoommateOtherDetails VARCHAR(255)
);

-- Create RoommatesGroup table
CREATE TABLE RoommatesGroup (
    RGID INT PRIMARY KEY IDENTITY(1,1),
    RentSplit DECIMAL(10, 2) CHECK (RentSplit > 0),
    RoommateAgreement VARCHAR(255),
    RentersInsurance VARCHAR(255)
);

-- Create RRG table
CREATE TABLE RRG (
    RRGID INT PRIMARY KEY IDENTITY(1,1),
    PersonID INT FOREIGN KEY REFERENCES Roommates(PersonID),
    RGID INT FOREIGN KEY REFERENCES RoommatesGroup(RGID)
);

-- Create Wishlist table
CREATE TABLE Wishlist (
    WishlistID INT PRIMARY KEY IDENTITY(1,1),
    PersonID INT FOREIGN KEY REFERENCES Roommates(PersonID),
    RGID INT FOREIGN KEY REFERENCES RoommatesGroup(RGID),
    PropertyID INT FOREIGN KEY REFERENCES Property(PropertyID),
    DateOfAddition DATE NOT NULL DEFAULT GETDATE()
);

-- Create Lease table 
CREATE TABLE Lease (
    LeaseID INT PRIMARY KEY IDENTITY(1,1),
    RGID INT FOREIGN KEY REFERENCES RoommatesGroup(RGID),
    PropertyID INT FOREIGN KEY REFERENCES Property(PropertyID),
    LeaseSignDate DATE,
    MonthlyRent DECIMAL(10, 2) CHECK (MonthlyRent > 0),
    LeaseStartDate DATE,
    LeaseEndDate DATE,
    MoveInCost DECIMAL(10, 2),
    CHECK (LeaseStartDate < LeaseEndDate),  -- Ensures LeaseStartDate is earlier than LeaseEndDate
    CHECK (MoveInCost >= 0)  -- Ensure MoveInCost is greater than or equal to 0 (single check for this column)
);

-- Create Broker table
CREATE TABLE Broker (
    OwnerID INT PRIMARY KEY,
    NoOfClients INT CHECK (NoOfClients >= 0),
    LicenseNumber VARCHAR(50),
    Rating DECIMAL(3, 2) CHECK (Rating BETWEEN 0 AND 10),
    FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)
);

-- Create PropertyManager table
CREATE TABLE PropertyManager (
    OwnerID INT PRIMARY KEY,
    NoOfPropertiesManaged INT CHECK (NoOfPropertiesManaged >= 0),
    SSN VARCHAR(11),
    FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)
);

-- Create ApplicationSubmission table
CREATE TABLE ApplicationSubmission (
    ApplicationID INT PRIMARY KEY IDENTITY(1,1),
    PersonID INT FOREIGN KEY REFERENCES Roommates(PersonID),
    RGID INT FOREIGN KEY REFERENCES RoommatesGroup(RGID),
    PropertyID INT FOREIGN KEY REFERENCES Property(PropertyID),
    ApplicationStatus VARCHAR(50),
    ApplicationDate DATE NOT NULL DEFAULT GETDATE()
);

-- Create Bank table
CREATE TABLE Bank (
    AccountID BIGINT PRIMARY KEY,
    RoutingNumber VARCHAR(9) NOT NULL,
    BankName VARCHAR(100),
    BankAddress VARCHAR(255)
);

-- Create RoommateBank table
CREATE TABLE RoommateBank (
    AccountID BIGINT PRIMARY KEY,
    PersonID INT FOREIGN KEY REFERENCES Roommates(PersonID),
    FOREIGN KEY (AccountID) REFERENCES Bank(AccountID)
);

-- Create OwnerBank table
CREATE TABLE OwnerBank (
    AccountID BIGINT PRIMARY KEY,
    OwnerID INT FOREIGN KEY REFERENCES Owner(OwnerID),
    FOREIGN KEY (AccountID) REFERENCES Bank(AccountID)
);

-- Create Communication table
CREATE TABLE Communication (
    CommunicationID INT PRIMARY KEY IDENTITY(1,1),
    PersonID INT FOREIGN KEY REFERENCES Roommates(PersonID),
    OwnerID INT FOREIGN KEY REFERENCES Owner(OwnerID),
    DateOfCommunication DATE NOT NULL,
    Description VARCHAR(255)
);

-- Create Complaints table
CREATE TABLE Complaints (
    CommunicationID INT PRIMARY KEY,
    DateOfComplaint DATE NOT NULL,
    CategoryOfResolution VARCHAR(50),
    FOREIGN KEY (CommunicationID) REFERENCES Communication(CommunicationID)
);

-- Create Transactions table
CREATE TABLE Transactions (
    CommunicationID INT PRIMARY KEY,
    Amount DECIMAL(10, 2) CHECK (Amount >= 0),
    SentByAccountNo BIGINT,
    ReceivedByAccountNo BIGINT,
    FOREIGN KEY (CommunicationID) REFERENCES Communication(CommunicationID)
);
