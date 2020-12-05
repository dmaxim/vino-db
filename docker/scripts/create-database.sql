


SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Veritas"
:setvar DefaultFilePrefix "Veritas"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO


GO


USE [master];


GO

PRINT N'Creating $(DatabaseName)'

GO

CREATE DATABASE [$(DatabaseName)] COLLATE SQL_Latin1_General_CP1_CI_AS
GO


USE [$(DatabaseName)];

IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                DATE_CORRELATION_OPTIMIZATION OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = AUTO, OPERATION_MODE = READ_WRITE, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO

PRINT N'Creating Appellation Table'
GO

CREATE TABLE dbo.Appellation

(
        AppellationId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Appellation_Id PRIMARY KEY CLUSTERED,
        AppellationName VARCHAR(100) NOT NULL
)

GO

PRINT N'Creating SubAppellation Table'
GO


CREATE TABLE dbo.SubAppellation
(
    SubAppellationId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_SubAppellation_Id PRIMARY KEY CLUSTERED,
    SubAppellationName VARCHAR(100) NOT NULL,
    AppellationId INT NOT NULL,
    CONSTRAINT FK_SubAppellation_Appelation FOREIGN KEY (AppellationId) REFERENCES dbo.Appellation(AppellationId)
)

GO

PRINT N'Creating Tag Table'
GO

CREATE TABLE dbo.Tag
(
    TagId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Tag_Id PRIMARY KEY CLUSTERED,
    TagName VARCHAR(55) NOT NULL
)

GO


PRINT N'Creating WineType Table'

GO

CREATE TABLE dbo.WineType
(
    WineTypeId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_WineType_Id PRIMARY KEY CLUSTERED,
    WineTypeName VARCHAR(30) NOT NULL
)

GO

PRINT N'Creating Winery Table'
GO


CREATE TABLE dbo.Winery
(
    WineryId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Winery_Id PRIMARY KEY CLUSTERED,
    WineryName VARCHAR(100) NOT NULL,
    StreetAddress VARCHAR(150) NOT NULL,
    StateRegionCode VARCHAR(5) NOT NULL,
    ZipCode VARCHAR(10) NOT NULL,
    CountryCode VARCHAR(10) NOT NULL,
    City VARCHAR(50) NOT NULL,
    ImageUrl VARCHAR(255) NOT NULL
)

GO


PRINT N'Creating Varietal Table'
GO

CREATE TABLE dbo.Varietal
(
    VarietalId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Varietal_Id PRIMARY KEY CLUSTERED,
    VarietalName VARCHAR(100) NOT NULL,
    WineTypeId INT NOT NULL,
    CONSTRAINT FK_Varietal_WineType FOREIGN KEY (WineTypeId) REFERENCES dbo.WineType(WineTypeId)
)

GO


PRINT N'Creating Wine Table'

GO
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

PRINT N'Creating WineTag Table'
GO

CREATE TABLE dbo.WineTag
(
    WineTagId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_WineTag_Id PRIMARY KEY CLUSTERED,
    TagId INT NOT NULL,
    WineId INT NOT NULL,
    CONSTRAINT FK_WineTag_Tag FOREIGN KEY (TagId) REFERENCES dbo.Tag(TagId),
    CONSTRAINT FK_WineTag_Wine FOREIGN KEY (WineId) REFERENCES dbo.Wine(WineId)
)

GO

PRINT N'Crating WineVintageNote Table'
GO

CREATE TABLE dbo.WineVintageNote
(
    WineVintageNoteId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_WineVintageNote_Id PRIMARY KEY CLUSTERED,
    WineId INT NOT NULL,
    Vintage SMALLINT NOT NULL,
    Note VARCHAR(255) NOT NULL,
    CONSTRAINT FK_WineVintageNote_Wine FOREIGN KEY (WineId) REFERENCES dbo.Wine(WineId)
)

GO


PRINT N'Creating InventoryLocation Table'
GO

CREATE TABLE dbo.InventoryLocation 
(
    InventoryLocationId TINYINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_InventoryLocation_Id PRIMARY KEY CLUdockerSTERED,
    LocationName VARCHAR(50) NOT NULL
)

GO


PRINT N'Creating InventoryItem Table'
GO


CREATE TABLE dbo.InventoryItem 
(
    InventoryItemId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Inventoryitem_Id PRIMARY KEY CLUSTERED,
    WineId INT NOT NULL,
    Vintage SMALLINT NOT NULL,
    Volume SMALLINT NOT NULL,
    Quantity SMALLINT NOT NULL,
    ReceiptDate DATETIMEOFFSET(2) NOT NULL,
    InventoryLocationId TINYINT NOT NULL,
    CONSTRAINT FK_InventoryItem_Wine FOREIGN KEY (WineId) REFERENCES dbo.Wine(WineId),
    CONSTRAINT FK_InventoryItem_InventoryLocation FOREIGN KEY (InventoryLocationId) REFERENCES dbo.InventoryLocation(InventoryLocationId)
)

GO

PRINT N'Creating Tasting Table'
GO

CREATE TABLE dbo.Tasting
(
    TastingId SMALLINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Tasting_Id PRIMARY KEY CLUSTERED,
    TastingDate DATETIME  NOT NULL,
    WineryId INT NOT NULL,
    CONSTRAINT FK_Tasting_Winery FOREIGN KEY (WineryId) REFERENCES dbo.Winery(WineryId)
)

GO

PRINT N'Creating Table TastingPour'

GO

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