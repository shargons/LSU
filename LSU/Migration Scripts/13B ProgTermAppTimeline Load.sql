
USE EDUCPROD;



/***** Replicate AcademicTerm before running the view **********/
EXEC SF_Replicate 'EDUCPROD','ProgramTermApplnTimeline','pkchunk,batchsize(50000)'


--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - PTAT
--====================================================================


--DROP TABLE IF EXISTS [dbo].[ProgramTermApplnTimeline_LOAD];
--GO
SELECT C.*
INTO [EDUCPROD].dbo.ProgramTermApplnTimeline_LOAD2
FROM [EDUCPROD].[dbo].[13B_EDA_PTAT_NEW] C
LEFT JOIN ProgramTermApplnTimeline ptat ON ptat.LearningProgramId = C.LearningProgramId AND ptat.AcademicTermId = C.AcademicTermId
WHERE ptat.ID IS NULL
ORDER BY C.LearningProgramId


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE ProgramTermApplnTimeline_LOAD2
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - PTAT
--====================================================================

SELECT * FROM ProgramTermApplnTimeline_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','ProgramTermApplnTimeline_LOAD2'

SELECT * 
INTO ProgramTermApplnTimeline_LOAD_3
FROM ProgramTermApplnTimeline_LOAD_2_Result where Error <> 'Operation Successful.'

select DISTINCT  Error from ProgramTermApplnTimeline_LOAD_Result

--====================================================================
--ERROR RESOLUTION - ProgramTermApplnTimeline
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE ProgramTermApplnTimeline_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'ProgramTermApplnTimeline_DELETE'

INSERT INTO ProgramTermApplnTimeline_DELETE(Id) SELECT Id FROM IndividualApplication_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'ProgramTermApplnTimeline_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- ProgramTermApplnTimeline
--====================================================================


--DROP TABLE IF EXISTS [dbo].[ProgramTermApplnTimeline_Lookup];
--GO

--INSERT INTO [EDUCPROD].[dbo].[ProgramTermApplnTimeline_Lookup]
--SELECT
-- ID
--,UpsertKey__c AS legacy_ID__c
--INTO [EDUCPROD].[dbo].[ProgramTermApplnTimeline_Lookup]
--FROM ProgramTermApplnTimeline_LOAD_3_Result
--WHERE Error = 'Operation Successful.'

--DROP TABLE [EDUCPROD].[dbo].[ProgramTermApplnTimeline_Lookup]

SELECT
 MAX(pr.ID) AS Id
,pa.UpsertKey__c AS legacy_ID__c
INTO [EDUCPROD].[dbo].[ProgramTermApplnTimeline_Lookup]
FROM ProgramTermApplnTimeline pr
JOIN [dbo].[13B_EDA_PTAT] pa ON pa.LearningProgramId = pr.LearningProgramId AND pa.AcademicTermId = pr.AcademicTermId
GROUP BY pa.UpsertKey__c

--====================================================================
-- UPDATE LOOKUPS 
--====================================================================

-- Application PTAT Lookup

--DROP TABLE IndividualApplication_PTAT_Update
SELECT B.ID,A.ID AS ProgramTermApplnTimelineId
INTO IndividualApplication_PTAT_Update
FROM [ProgramTermApplnTimeline_Lookup] A
INNER JOIN
IndividualApplication_Lookup B
ON A.legacy_ID__c = B.legacy_ID__c

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','IndividualApplication_PTAT_Update'

SELECT *
FROM IndividualApplication_PTAT_Update_Result 
WHERE Error <> 'Operation Successful.'

