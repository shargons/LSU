
USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - User
--====================================================================
--DROP TABLE IF EXISTS [dbo].[User_LOAD];
--GO
SELECT *
INTO [edcdatadev].dbo.User_LOAD
FROM [edcdatadev].[dbo].[01_EDA_User] C


/******* Check Load table *********/
SELECT * FROM [edcdatadev].dbo.User_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - User
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE User_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI2','EDCDATADEV','User_LOAD'

SELECT * FROM User_LOAD_Result where Error <> 'Operation Successful.'

select DISTINCT  Error from User_LOAD_Result

--====================================================================
--ERROR RESOLUTION - User
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE User_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'User_DELETE'

INSERT INTO User_DELETE(Id) SELECT Id FROM User_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'User_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- User
--====================================================================

-- Contact Lookup
DROP TABLE IF EXISTS [dbo].[User_Lookup];
GO
SELECT
 ID
,EDAUSERID__c AS Legacy_ID__c
INTO [edcdatadev].[dbo].[User_Lookup]
FROM User_LOAD_Result
WHERE Error = 'Operation Successful.'