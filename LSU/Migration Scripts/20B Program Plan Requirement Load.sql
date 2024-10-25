USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Plan Requirements
--====================================================================


--DROP TABLE IF EXISTS [dbo].[LearningProgramPlanRqmt_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.LearningProgramPlanRqmt_LOAD
FROM [edcuat].[dbo].[20B_EDA_Plan_Requirements] C
ORDER BY LearningProgramPlanId



/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearningProgramPlanRqmt_LOAD
ALTER COLUMN ID NVARCHAR(18)

SELECT * FROM LearningProgramPlanRqmt_LOAD

--====================================================================
--INSERTING DATA USING DBAMP -  Plan Requirements
--====================================================================


EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','LearningProgramPlanRqmt_LOAD'

SELECT *
--INTO LearningProgramPlanRqmt_LOAD_2
FROM LearningProgramPlanRqmt_LOAD_Result where Error <> 'Operation Successful.'
ORDER BY LearningProgramPlanId

select DISTINCT  Error from LearningProgramPlanRqmt_LOAD_Result

--====================================================================
--ERROR RESOLUTION -  Plan Requirements
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE LearningProgramPlanRqmt_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'LearningProgramPlanRqmt_DELETE'

INSERT INTO LearnerProgram_DELETE(Id) SELECT Id FROM LearningProgramPlanRqmt_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'LearningProgramPlanRqmt_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES-  Plan Requirements
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[LearningProgramPlanRqmt_Lookup];
--GO

SELECT
 ID
,Legacy_ID__c
INTO LearningProgramPlanRqmt_Lookup
FROM LearningProgramPlanRqmt_LOAD_Result
WHERE Error = 'Operation Successful.'


