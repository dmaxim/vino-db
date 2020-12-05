
CREATE TABLE dbo.Appellation
(
        AppellationId INT IDENITY(1,1) NOT NULL CONSTRAINT PK_Appellation_Id PRIMARY KEY CLUSTERED,
        AppellationName VARCHAR(100) NOT NULL
)

GO
