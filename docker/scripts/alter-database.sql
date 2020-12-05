




PRINT N'Altering Winery Table'
ALTER TABLE dbo.Winery  
    ADD WineryName VARCHAR(100) NULL
GO

UPDATE dbo.Winery
SET WineryName = [Name]

GO

ALTER TABLE dbo.Winery
    ALTER COLUMN WineryName VARCHAR(100) NOT NULL

GO

ALTER TABLE dbo.Winery
  DROP COLUMN [Name]

GO


PRINT N'Alter Wine Type Table'

GO
ALTER TABLE dbo.WineType
  ALTER COLUMN WineTypeId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_WineType_Id PRIMARY KEY CLUSTERED

GO

PRINT N'Alter Wine Table'
GO
ALTER TABLE dbo.Wine
    ADD WineName VARCHAR(100)

GO
UPDATE dbo.Wine
SET WineName = [Name]
GO

ALTER TABLE dbo.Wine
    ALTER COLUMN WineName VARCHAR(100) NOT NULL
GO

ALTER TABLE dbo.Wine
    DROP COLUMN [Name]

GO



PRINT N'Alter Varietal Table'
GO
ALTER TABLE dbo.Varietal
    ADD VarietalName VARCHAR(100)

GO
UPDATE dbo.Varietal
SET VarietalName = [Name]
GO

ALTER TABLE dbo.Varietal
    ALTER COLUMN VarietalName VARCHAR(100) NOT NULL
GO

ALTER TABLE dbo.Varietal
    DROP COLUMN [Name]

GO