
USE EDCUAT;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - User
--====================================================================
--DROP TABLE IF EXISTS [dbo].[User_LOAD];
--GO
SELECT *
INTO [EDCUAT].dbo.User_LOAD
FROM [edcuat].[dbo].[01_EDA_User] C


/******* Check Load table *********/
SELECT * FROM [EDCUAT].dbo.User_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - User
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE User_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','User_LOAD'

SELECT * 
--INTO User_LOAD_2
FROM User_LOAD_Result where Error <> 'Operation Successful.'

UPDATE User_LOAD_2
SET country = 'United States'

UPDATE User_LOAD_2
SET state = 'Louisiana'

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

SELECT * FROM USER_DELETE_RESULT WHERE Error <> 'Operation Successful.'

--====================================================================
--POPULATING LOOOKUP TABLES- User
--====================================================================

-- User Lookup
DROP TABLE IF EXISTS [dbo].[User_Lookup];
GO
INSERT INTO [EDCUAT].[dbo].[User_Lookup]
SELECT
 ID
,EDAUSERID__c AS Legacy_ID__c
FROM User_LOAD_2_Result
WHERE Error = 'Operation Successful.'

--====================================================================
--UPDATE DATA - User
--====================================================================
SELECT B.ID,A.EDAUSERID__c,A.EDACREATEDDATE__c
into User_Update
FROM User_LOAD A
INNER JOIN User_LOAD_Result B
ON A.Username = b.Username

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','User_Update'