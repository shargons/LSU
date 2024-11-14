
USE EDCUAT;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - UserRole
--====================================================================
--DROP TABLE IF EXISTS [dbo].[UserRole_LOAD];
--GO
SELECT *
INTO [EDCUAT].dbo.UserRole_LOAD
FROM [edcuat].[dbo].[01A_EDA_UserRole] C


/******* Check Load table *********/
SELECT * FROM [EDCUAT].dbo.UserRole_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - UserRole
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE UserRole_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','UserRole_LOAD'

DROP TABLE UserRole_LOAD_2
SELECT * 
--INTO UserRole_LOAD_2
FROM UserRole_LOAD_2_Result where Error <> 'Operation Successful.'


select DISTINCT  Error from UserRole_LOAD_Result

--====================================================================
--ERROR RESOLUTION - UserRole
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE UserRole_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'UserRole_DELETE'

INSERT INTO UserRole_DELETE(Id) SELECT Id FROM UserRole_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'UserRole_DELETE'

SELECT * FROM UserRole_DELETE_RESULT WHERE Error <> 'Operation Successful.'

--====================================================================
--POPULATING LOOOKUP TABLES- UserRole
--====================================================================

-- UserRole Lookup
DROP TABLE IF EXISTS [dbo].[UserRole_Lookup];
GO

SELECT
 ID
,Legacy_ID__c
INTO [EDCUAT].[dbo].[UserRole_Lookup]
FROM UserRole_LOAD_Result
WHERE Error = 'Operation Successful.'

--====================================================================
--UPDATE DATA - UserRole
--====================================================================
SELECT A.ID,B.ID AS [ParentRoleId],Source_Parent_Role
into UserRole_Update
FROM UserRole_LOAD_Result A
INNER JOIN UserRole_Lookup B
ON A.Source_Parent_Role = B.Legacy_Id__c

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','UserRole_Update'

