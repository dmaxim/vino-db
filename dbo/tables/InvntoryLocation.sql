CREATE TABLE dbo.InventoryLocation 
(
    InventoryLocationId TINYINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_InventoryLocation_Id PRIMARY KEY CULSTERED,
    LocationName VARCHAR(50) NOT NULL
)

GO

