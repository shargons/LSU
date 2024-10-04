
USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - LearnerProgram
--====================================================================
--DROP TABLE IF EXISTS [dbo].[LearnerProgram_LOAD];
--GO
SELECT *
INTO [edcdatadev].dbo.LearnerProgram_LOAD
FROM [edcdatadev].[dbo].[08_EDA_Student] C


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearnerProgram_LOAD
ALTER COLUMN LearningProgramPlanId NVARCHAR(18)

ALTER TABLE LearnerProgram_LOAD
ALTER COLUMN LearnerContactId NVARCHAR(18)

UPDATE A
SET LearningProgramPlanId = D.ID 
FROM edcdatadev.dbo.LearnerProgram_LOAD A
INNER JOIN
edaprod.dbo.hed__Affiliation__c B
ON A.LSU_Affiliation__c = B.ID
LEFT JOIN edcdatadev.dbo.Account_Program_Lookup C
ON B.hed__Account__c = C.Legacy_ID__c
LEFT JOIN edcdatadev.dbo.LearningProgramPlan_Lookup D
ON C.ID = D.LearningProgramId

UPDATE A
SET Name = ISNULL(C.Name,'')+' - '+ISNULL(C1.Name,'')
FROM [edcdatadev].dbo.LearnerProgram_LOAD A
INNER JOIN
edaprod.dbo.hed__Affiliation__c B
ON A.LSU_Affiliation__c = B.ID
LEFT JOIN [edcdatadev].dbo.LearningProgram C
ON B.hed__Account__c = C.EDAACCOUNTID__c
LEFT JOIN [edcdatadev].dbo.LearningProgramPlan_Lookup D
ON C.ID = D.LearningProgramId
LEFT JOIN
[edcdatadev].dbo.[Contact] C1
ON A.Source_Contact__c = C1.Legacy_ID__c



UPDATE A
SET LearnerContactId = C.ID 
FROM [edcdatadev].dbo.LearnerProgram_LOAD A
INNER JOIN
[edcdatadev].dbo.[Contact] C
ON A.Source_Contact__c = C.Legacy_ID__c

--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearnerProgram_LOAD
ALTER COLUMN ID NVARCHAR(18)

SELECT * FROM LearnerProgram_LOAD

EXEC SF_TableLoader 'Upsert:BULKAPI','edcdatadev','LearnerProgram_LOAD_2','UpsertKey__c'

--DROP TABLE LearnerProgram_LOAD_2
SELECT * 
INTO LearnerProgram_LOAD_2
FROM LearnerProgram_LOAD_Result where Error <> 'Operation Successful.'

select DISTINCT  Error from LearnerProgram_LOAD_2_Result

--====================================================================
--ERROR RESOLUTION - Account
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE LearnerProgram_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'LearnerProgram_DELETE'

INSERT INTO LearnerProgram_DELETE(Id) SELECT Id FROM LearnerProgram_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'LearnerProgram_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Account
--====================================================================

-- Contact Lookup
DROP TABLE [dbo].[LearnerProgram_Lookup];
GO

INSERT INTO [edcdatadev].[dbo].[LearnerProgram_Lookup]
SELECT
 A.ID
,A.Source_contact__c
,A.LSU_Affiliation__c
,B.Legacy_ID__c
--INTO [edcdatadev].[dbo].[LearnerProgram_Lookup]
FROM LearnerProgram_LOAD_2_Result A
INNER JOIN
[dbo].[08_EDA_Student] B
ON A.Source_contact__c = B.Source_contact__c
AND A.LSU_Affiliation__c = B.LSU_Affiliation__c
WHERE Error = 'Operation Successful.'

SELECT * FROM 
[LearnerProgram_Lookup]





