
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Account
--====================================================================
--DROP TABLE IF EXISTS [dbo].[LearningProgramPlan_LOAD];
--GO
SELECT C.*
INTO [edcuat].dbo.LearningProgramPlan_LOAD
FROM [edcuat].[dbo].[07_EDA_LearningProgramPlan] C


/******* Check Load table *********/
SELECT * FROM [edcuat].dbo.LearningProgramPlan_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearningProgramPlan_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Upsert:BULKAPI','EDCUAT','LearningProgramPlan_LOAD','Legacy_Id__c'

SELECT * FROM LearningProgramPlan_LOAD_Result where Error <> 'Operation Successful.'

select DISTINCT  Error from LearningProgramPlan_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Account
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE LearningProgramPlan_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'LearningProgramPlan_DELETE'

INSERT INTO LearningProgramPlan_DELETE(Id) SELECT Id FROM LearningProgramPlan_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'LearningProgramPlan_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Account
--====================================================================

-- Contact Lookup
DROP TABLE IF EXISTS [dbo].[LearningProgramPlan_Lookup];
GO
SELECT
 ID
,Name as Legacy_ID__c
,LearningProgramId
INTO [edcuat].[dbo].[LearningProgramPlan_Lookup]
FROM LearningProgramPlan_LOAD_Result
WHERE Error = 'Operation Successful.'


