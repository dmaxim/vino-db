CREATE TABLE dbo.TastingPour
(
    TastingPourId INT IDENTITY(1,1)  NOT NULL CONSTRAINT PK_TastingPour_Id PRIMARY KEY CLUSTERED,
    TastingId SMALLINT NOT NULL,
    WineId INT NOT NULL,
    Vintage SMALLINT NOT NULL,
    Notes VARCHAR(500) NOT NULL,
    CONSTRAINT FK_TastingPour_Tasting FOREIGN KEY (TastingId) REFERENCES dbo.Tasting(TastingId),
    CONSTRAINT FK_TastingPour_Wine FOREIGN KEY (WineId) REFERENCES dbo.Wine(WineId)
)


GO