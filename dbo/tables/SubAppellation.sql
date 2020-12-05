
CREATE TABLE dbo.SubAppellation
(
    SubAppellationId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_SubAppellation_Id,
    SubAppellationName VARCHAR(100) NOT NULL,
    AppellationId INT NOT NULL,
    CONSTRAINT FK_SubAppellation_Appelation FOREIGN KEY (AppellationId) REFERENCES dbo.Appellation(AppellationId)
)

GO