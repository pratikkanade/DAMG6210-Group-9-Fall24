IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Preferences_ApartmentType_RentRange_RoommateGender'
          AND object_id = OBJECT_ID('Preferences')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Preferences_ApartmentType_RentRange_RoommateGender
    ON Preferences (ApartmentType, RentRange, RoommateGender);
END;

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_RoommatesGroup_RentSplit'
          AND object_id = OBJECT_ID('RoommatesGroup')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_RoommatesGroup_RentSplit
    ON RoommatesGroup (RentSplit);
END;

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Roommates_Gender_Languages'
          AND object_id = OBJECT_ID('Roommates')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Roommates_Gender_Languages
    ON Roommates (Gender, Languages);
END;
