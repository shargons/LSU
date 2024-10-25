
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Account
--====================================================================
--DROP TABLE IF EXISTS [dbo].[Account_Org_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.Account_Org_LOAD
FROM [edcuat].[dbo].[02_EDA_OrgAccount] C


/******* Check Load table *********/
SELECT * FROM [edcuat].dbo.Account_Org_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Account_Org_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','Account_Org_LOAD'

SELECT * FROM Account_Org_LOAD_Result where Error <> 'Operation Successful.'

select DISTINCT  Error from Account_Org_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Account
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Account_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Account_DELETE'

INSERT INTO User_DELETE(Id) SELECT Id FROM Account_Org_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'User_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Account
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[Account_Org_Lookup];
--GO
SELECT
 ID
,Legacy_ID__c
INTO [edcuat].[dbo].[Account_Org_Lookup]
FROM Account_Org_LOAD_Result
WHERE Error = 'Operation Successful.'


--====================================================================
--UPDATING PARENTID - Account
--====================================================================
DROP TABLE Account_Update
SELECT C.ID,B.ID AS ParentId
INTO Account_Update
FROM [edcuat].[dbo].[02_EDA_OrgAccount] A
LEFT JOIN [edcuat].[dbo].[Account_Org_Lookup] B
ON A.Source_ParentID = B.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[Account_Org_Lookup] C
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE A.Source_ParentID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_Update'
