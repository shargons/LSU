USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Program Plan
--====================================================================


--DROP TABLE IF EXISTS [dbo].[LearningProgramPlan_ProgPlan_LOAD];
--GO
SELECT *
--INTO [EDUCPROD].dbo.LearningProgramPlan_ProgPlan_LOAD
FROM [EDUCPROD].[dbo].[17_EDA_ProgramPlan] C
ORDER BY LearningProgramId


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearningProgramPlan_ProgPlan_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Program Plan
--====================================================================

SELECT * FROM LearningProgramPlan_ProgPlan_LOAD
where LearningProgramiD = '0uFHu000000wxvmMAA'

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','LearningProgramPlan_ProgPlan_LOAD_2'

SELECT *
--INTO LearningProgramPlan_ProgPlan_LOAD_2
FROM LearningProgramPlan_ProgPlan_LOAD_2_Result where Error <> 'Operation Successful.'
ORDER BY LearningProgramId

UPDATE LearningProgramPlan_ProgPlan_LOAD_2
SET IsActive = 1

select DISTINCT  Error from LearningProgramPlan_ProgPlan_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Program Plan
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE LearningProgramPlan_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'LearningProgramPlan_DELETE'

INSERT INTO Financial_Aid__c_DELETE(Id) SELECT Id FROM LearningProgramPlan_ProgPlan_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'LearningProgramPlan_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES- Program Plan
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[LearningProgramPlan_ProgPlan_Lookup];
--GO

SELECT
 ID
,Legacy_ID__c
INTO LearningProgramPlan_ProgPlan_Lookup
FROM LearningProgramPlan_ProgPlan_LOAD_Result
WHERE Error = 'Operation Successful.'
