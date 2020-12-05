
GO
USE MASTER
GO

CREATE LOGIN veritas_app WITH PASSWORD = '$(appPassword)';

GO

CREATE USER veritas_app FOR LOGIN veritas_app WITH DEFAULT_SCHEMA = [dbo]

GO

USE Veritas
GO

CREATE USER veritas_app FOR LOGIN veritas_app WITH DEFAULT_SCHEMA = [dbo]

GO

CREATE ROLE VeritasApplicationRole AUTHORIZATION [dbo]

GO


GRANT 
	DELETE, 
	EXECUTE, 
	INSERT, 
	SELECT, 
	UPDATE
ON SCHEMA :: dbo
	TO VeritasApplicationRole
GO

EXEC sp_addrolemember 'VeritasApplicationRole', 'veritas_app';

GO
