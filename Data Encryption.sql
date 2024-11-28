USE Project

-- Create a Database Master Key
IF NOT EXISTS (
    SELECT 1 
    FROM sys.symmetric_keys 
    WHERE name = '##MS_DatabaseMasterKey##'
)
BEGIN
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'MasterKey';
END

-- Verify that master key exists
SELECT name KeyName, symmetric_key_id KeyID, key_length KeyLength, algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys



-- Column Level Encryption for SSN of Property Managers

-- Create a Certificate
IF NOT EXISTS (
    SELECT 1 
    FROM sys.certificates 
    WHERE name = 'PMSSN'
)
BEGIN
CREATE CERTIFICATE PMSSN
WITH SUBJECT = 'Property Manager SSN';
END


-- Create a Symmetric Key and associate it with the Certificate
IF NOT EXISTS (
    SELECT 1 
    FROM sys.symmetric_keys 
    WHERE name = 'PMSSNKey'
)
BEGIN
CREATE SYMMETRIC KEY PMSSNKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE PMSSN;
END



-- Add an alternate column
ALTER TABLE PropertyManager
ADD EncryptedSSN VARBINARY(MAX);
GO

-- Add data from old column to alternate column
UPDATE PropertyManager
SET EncryptedSSN = CONVERT(VARBINARY(MAX),SSN);
GO

-- Drop the old column
ALTER TABLE PropertyManager
DROP COLUMN SSN;
GO

-- Rename the new column
EXEC sp_rename 'PropertyManager.EncryptedSSN', 'SSN', 'COLUMN';
GO


-- Open the Symmetric Key
OPEN SYMMETRIC KEY PMSSNKey
DECRYPTION BY CERTIFICATE PMSSN;

-- Update data with encryption
UPDATE PropertyManager SET SSN = ENCRYPTBYKEY(KEY_GUID('PMSSNKey'), SSN);

-- Close the Symmetric Key
CLOSE SYMMETRIC KEY PMSSNKey;
GO

-- Check if data is encrypted
SELECT * FROM PropertyManager;


-- Open the Symmetric Key
OPEN SYMMETRIC KEY PMSSNKey
DECRYPTION BY CERTIFICATE PMSSN;

-- Retrieve data with decryption
SELECT OwnerID, NoOfPropertiesManaged, 
       CAST(DECRYPTBYKEY(SSN) AS VARCHAR(16)) AS DecryptedSSN
FROM PropertyManager;

-- Close the Symmetric Key
CLOSE SYMMETRIC KEY PMSSNKey;



-- Check if data is encrypted after closing the key 
SELECT OwnerID, NoOfPropertiesManaged, 
       CAST(DECRYPTBYKEY(SSN) AS VARCHAR(16)) AS DecryptedSSN
FROM PropertyManager;

SELECT * FROM PropertyManager;



-- Column Level Encryption for Routing Numbers in Bank Table

-- Create a Certificate
IF NOT EXISTS (
    SELECT 1 
    FROM sys.certificates 
    WHERE name = 'BankRN'
)
BEGIN
CREATE CERTIFICATE BankRN
WITH SUBJECT = 'Bank Routing Number';
END

-- Create a Symmetric Key and associate it with the Certificate
IF NOT EXISTS (
    SELECT 1 
    FROM sys.symmetric_keys 
    WHERE name = 'BankRNKey'
)
BEGIN
CREATE SYMMETRIC KEY BankRNKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE BankRN;
END
GO



-- Add an alternate column
ALTER TABLE Bank
ADD EncryptedRN VARBINARY(MAX);
GO

-- Add data from old column to alternate column
UPDATE Bank
SET EncryptedRN = CONVERT(VARBINARY(MAX),RoutingNumber);
GO

-- Drop the old column
ALTER TABLE Bank
DROP COLUMN RoutingNumber;
GO

-- Rename the new column
EXEC sp_rename 'Bank.EncryptedRN', 'RoutingNumber', 'COLUMN';
GO


-- Open the Symmetric Key
OPEN SYMMETRIC KEY BankRNKey
DECRYPTION BY CERTIFICATE BankRN;


-- Update data with encryption
UPDATE Bank SET RoutingNumber = ENCRYPTBYKEY(KEY_GUID('BankRNKey'), RoutingNumber);

-- Close the Symmetric Key
CLOSE SYMMETRIC KEY BankRNKey;

-- Check if data is encrypted
SELECT * FROM Bank;
GO


-- Open the Symmetric Key
OPEN SYMMETRIC KEY BankRNKey
DECRYPTION BY CERTIFICATE BankRN;


-- Retrieve data with decryption
SELECT AccountID, BankName, BankAddress,
       CAST(DECRYPTBYKEY(RoutingNumber) AS VARCHAR(16)) AS DecryptedRN
FROM Bank;

-- Close the Symmetric Key
CLOSE SYMMETRIC KEY BankRNKey;
GO


-- Check if data is encrypted after closing the key 
SELECT AccountID, BankName, BankAddress,
       CAST(DECRYPTBYKEY(RoutingNumber) AS VARCHAR(16)) AS DecryptedRN
FROM Bank;

SELECT * FROM Bank;





