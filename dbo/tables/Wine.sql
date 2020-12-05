CREATE TABLE dbo.Wine
(
    WineId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Wine_Id PRIMARY KEY CLUSTERED,
    WineName VARCHAR(100) NOT NULL,
    VarietalId INT NOT NULL,
    WineryId INT NOT NULL,
    Detail VARCHAR(255) NOT NULL,
    CONSTRAINT FK_Wine_Varietal FOREIGN KEY (VarietalId) REFERENCES dbo.Varietal(VarietalId),
    CONSTRAINT FK_Wine_Winery FOREIGN KEY (WineryId) REFERENCES dbo.Winery(WineryId)
)

GO

