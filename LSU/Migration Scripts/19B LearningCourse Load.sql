USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Certificate Enrollment
--====================================================================


-- Replicate Learning for the LearningIds inserted in 19A
EXEC SF_Replicate 'EDUCPROD','Learning','pkchunk,batchsize(50000)'

--DROP TABLE IF EXISTS [dbo].[LearningCourse_LOAD];
--GO
SELECT *
INTO [EDUCPROD].dbo.LearningCourse_LOAD
FROM [EDUCPROD].[dbo].[19B_EDA_Course] C
ORDER BY ProviderId,LearningId


SELECT * FROM [EDUCPROD].dbo.LearningCourse_LOAD

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearningCourse_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP -  Certificate Enrollment
--====================================================================

EXEC SF_TableLoader 'Upsert:BULKAPI','EDUCPROD','LearningCourse_LOAD_2','one_course_id__c'

DROP TABLE LearningCourse_LOAD_2
SELECT *
--INTO LearningCourse_LOAD_2
FROM LearningCourse_LOAD_Result where Error = 'Operation Successful.'
ORDER BY ProviderId

ALTER TABLE LearningCourse_LOAD_2
DROP COLUMN LearningId


select DISTINCT  Error from LearningCourse_LOAD_Result

--====================================================================
--ERROR RESOLUTION -  Certificate Enrollment
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE LearnerProgram_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'LearnerProgram_DELETE'

INSERT INTO LearnerProgram_DELETE(Id) SELECT Id FROM LearningCourse_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'LearnerProgram_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES-  Certificate Enrollment
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[LearningCourse_Lookup];
--GO
INSERT INTO LearningCourse_Lookup
SELECT
 ID
,EDACOURSEID__c AS Legacy_ID__c
--INTO LearningCourse_Lookup
FROM LearningCourse_LOAD_Result
WHERE Error = 'Operation Successful.'


