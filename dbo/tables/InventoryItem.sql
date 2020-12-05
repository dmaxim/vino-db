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