
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - PTAT
--====================================================================


--DROP TABLE IF EXISTS [dbo].[ProgramTermApplnTimeline_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.ProgramTermApplnTimeline_LOAD
FROM [edcuat].[dbo].[13B_EDA_PTAT] C
ORDER BY LearningProgramId


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE ProgramTermApplnTimeline_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - PTAT
--====================================================================

SELECT * FROM ProgramTermApplnTimeline_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','ProgramTermApplnTimeline_LOAD'



SELECT * 
--INTO IndividualApplication_LOAD_2
FROM ProgramTermApplnTimeline_LOAD_Result where Error <> 'Operation Successful.'
ORDER BY ContactId

select DISTINCT  Error from ProgramTermApplnTimeline_LOAD_Result

--====================================================================
--ERROR RESOLUTION - ProgramTermApplnTimeline
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE IndividualApplication_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'IndividualApplication_DELETE'

INSERT INTO IndividualApplication_DELETE(Id) SELECT Id FROM IndividualApplication_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'IndividualApplication_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- ProgramTermApplnTimeline
--====================================================================


--DROP TABLE IF EXISTS [dbo].[IndividualApplication_Lookup];
--GO

SELECT
 ID
,UpsertKey__c AS legacy_ID__c
INTO [edcuat].[dbo].[ProgramTermApplnTimeline_Lookup]
FROM ProgramTermApplnTimeline_LOAD_Result
WHERE Error = 'Operation Successful.'


--====================================================================
-- UPDATE LOOKUPS 
--====================================================================

-- Application PTAT Lookup

SELECT B.ID,A.ID AS ProgramTermApplnTimelineId
INTO IndividualApplication_PTAT_Update
FROM [ProgramTermApplnTimeline_Lookup] A
INNER JOIN
IndividualApplication_Lookup B
ON A.legacy_ID__c = B.legacy_ID__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','IndividualApplication_PTAT_Update'



