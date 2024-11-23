
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - User
--====================================================================
--DROP TABLE IF EXISTS [dbo].[User_LOAD];
--GO
SELECT *
INTO [EDUCPROD].dbo.User_LOAD
FROM [EDUCPROD].[dbo].[01_EDA_User] C


/******* Check Load table *********/
SELECT * FROM [EDUCPROD].dbo.User_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - User
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE User_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','User_LOAD_4'

--DROP TABLE User_LOAD_2
SELECT * 
--INTO User_LOAD_4
FROM User_LOAD_3_Result where Error <> 'Operation Successful.'

UPDATE User_LOAD_4
SET username = 'AcqueonIntegration.User@lsu.ec.edu' 
WHERE username = 'Acqueon Integration.User@lsu.ec.edu'


UPDATE User_LOAD_4
SET communitynickname = communitynickname+'1'
WHERE error like 'DUPLICATE_COMM_NICKNAME%'

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
INSERT INTO [EDUCPROD].[dbo].[User_Lookup]
SELECT
 ID
,EDAUSERID__c AS Legacy_ID__c
--INTO [EDUCPROD].[dbo].[User_Lookup]
FROM User_LOAD_4_Result
WHERE Error = 'Operation Successful.'

select * from [User_Lookup]

--====================================================================
--UPDATE DATA - User
--====================================================================
SELECT B.ID,A.EDAUSERID__c,A.EDACREATEDDATE__c
into User_Update
FROM User_LOAD A
INNER JOIN User_LOAD_Result B
ON A.Username = b.Username

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','User_Update'

