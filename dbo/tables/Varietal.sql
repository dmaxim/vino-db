CREATE TABLE dbo.Varietal
(
    VarietalId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Varietal_Id PRIMARY KEY CLUSTERED,
    VarietalName VARCHAR(100) NOT NULL,
    WineTypeId INT NOT NULL,
    CONSTRAINT FK_Varietal_WineType FOREIGN KEY (WineTypeId) REFERENCES dbo.WineType(WineTypeId)
)

GO