USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Plan Requirements
--====================================================================


--DROP TABLE IF EXISTS [dbo].[LearningAchievement_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.LearningAchievement_LOAD
FROM [edcuat].[dbo].[20A_EDA_Achievement_ProgramPlan] C




/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearningAchievement_LOAD
ALTER COLUMN ID NVARCHAR(18)

SELECT * FROM LearningAchievement_LOAD

--====================================================================
--INSERTING DATA USING DBAMP -  Plan Requirements
--====================================================================


EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','LearningAchievement_LOAD'

SELECT *
--INTO LearningProgramPlanRqmt_LOAD_2
FROM LearningAchievement_LOAD_Result where Error <> 'Operation Successful.'
ORDER BY LearningProgramPlanId

select DISTINCT  Error from LearningAchievement_LOAD_Result

--====================================================================
--ERROR RESOLUTION -  Plan Requirements
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE LearningAchievement_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'LearningAchievement_DELETE'

INSERT INTO LearnerProgram_DELETE(Id) SELECT Id FROM LearningAchievement_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'LearningAchievement_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES-  Plan Requirements
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[LearningAchievement_Lookup];
--GO

SELECT
 ID
,ExternalKey__c as Legacy_ID__c
INTO edcuat.dbo.LearningAchievement_Lookup
FROM dbo.LearningAchievement_LOAD_Result
WHERE Error = 'Operation Successful.'


