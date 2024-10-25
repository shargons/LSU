
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Account
--====================================================================
--DROP TABLE IF EXISTS [dbo].[Account_ProgramParent_LOAD];
--GO
SELECT C.*
INTO [edcuat].dbo.Account_ProgramParent_LOAD
FROM [edcuat].[dbo].[04A_EDA_ProgramParents] C



/******* Check Load table *********/
SELECT * FROM [edcuat].dbo.Account_ProgramParent_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Account_ProgramParent_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','Account_ProgramParent_LOAD'

SELECT * FROM Account_ProgramParent_LOAD_Result where Error <> 'Operation Successful.'

select DISTINCT  Error from Account_ProgramParent_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Account
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Account_ProgramParent_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Account_ProgramParent_DELETE'

INSERT INTO Account_ProgramParent_DELETE(Id) SELECT Id FROM Account_ProgramParent_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Account_ProgramParent_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Account
--====================================================================

-- Contact Lookup
DROP TABLE IF EXISTS [dbo].[Account_ProgramParent_Lookup];
GO
SELECT
 ID
,EDAACCOUNTID__c as Legacy_ID__c
INTO [edcuat].[dbo].[Account_ProgramParent_Lookup]
FROM Account_ProgramParent_LOAD_Result
WHERE Error = 'Operation Successful.'

--====================================================================
--UPDATING PARENTID - Learning
--====================================================================
--DROP TABLE Learning_Update
SELECT C.ID,B.ID AS ProviderId,'LearningProgram' as Type
INTO Learning_Update
FROM [edcuat].[dbo].[03_EDA_Learning] A
LEFT JOIN [edcuat].[dbo].[Account_ProgramParent_Lookup] B
ON A.Source_ParentID = B.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[Learning_Lookup] C
ON A.EDAACCOUNTID__c = C.Legacy_ID__c
WHERE A.Source_ParentID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Learning_Update'

SELECT *  FROM Learning_Update_Result
WHERE Error = 'Operation Successful.'


