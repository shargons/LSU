
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Learning
--====================================================================
--DROP TABLE IF EXISTS [dbo].[Learning_Enrollment_LOAD];
--GO
SELECT *
INTO [EDUCPROD].dbo.Learning_Enrollment_LOAD
FROM [EDUCPROD].[dbo].[23A_Enr_Learning] C


/******* Check Load table *********/
SELECT * FROM [EDUCPROD].dbo.Learning_Enrollment_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - Learning
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Learning_Enrollment_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Learning_Enrollment_LOAD'

SELECT * FROM Learning_Enrollment_LOAD_Result where Error = 'Operation Successful.'


select DISTINCT  Error from Learning_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Learning
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Learning_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Learning_DELETE'

INSERT INTO Learning_DELETE(Id) SELECT Id FROM Learning_Enrollment_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Learning_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Learning
--====================================================================

-- Learning Lookup
DROP TABLE IF EXISTS [dbo].[Learning_Lookup];
GO

INSERT INTO [EDUCPROD].[dbo].[Learning_Lookup]
SELECT
 ID
,EDAACCOUNTID__c as Legacy_ID__c
FROM Learning_Enrollment_LOAD_Result
WHERE Error = 'Operation Successful.'


