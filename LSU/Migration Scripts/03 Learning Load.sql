
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Account
--====================================================================
--DROP TABLE IF EXISTS [dbo].[Learning_LOAD];
--GO
SELECT *
INTO [EDUCPROD].dbo.Learning_LOAD
FROM [EDUCPROD].[dbo].[03_EDA_Learning] C


/******* Check Load table *********/
SELECT * FROM [EDUCPROD].dbo.Learning_LOAD


--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Learning_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Learning_LOAD'

SELECT * FROM Learning_LOAD_Result where Error <> 'Operation Successful.'

select DISTINCT  Error from Learning_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Account
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Learning_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Learning_DELETE'

INSERT INTO Learning_DELETE(Id) SELECT Id FROM Learning_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Learning_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Account
--====================================================================

-- Contact Lookup
DROP TABLE IF EXISTS [dbo].[Learning_Lookup];
GO
SELECT
 ID
,EDAACCOUNTID__c as Legacy_ID__c
INTO [EDUCPROD].[dbo].[Learning_Lookup]
FROM Learning_LOAD_Result
WHERE Error = 'Operation Successful.'
