
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - LearnerProgram
--====================================================================
--DROP TABLE IF EXISTS [dbo].[LearnerProgram_LOAD];
--GO
SELECT *
INTO [EDUCPROD].dbo.LearnerProgram_LOAD
FROM [EDUCPROD].[dbo].[08_EDA_Student] 


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearnerProgram_LOAD
ALTER COLUMN LearningProgramPlanId NVARCHAR(18)

ALTER TABLE LearnerProgram_LOAD
ALTER COLUMN LearnerContactId NVARCHAR(18)

UPDATE A
SET LearningProgramPlanId = D.ID 
FROM EDUCPROD.dbo.LearnerProgram_LOAD A
INNER JOIN
edaprod.dbo.hed__Affiliation__c B
ON A.LSU_Affiliation__c = B.ID
LEFT JOIN EDUCPROD.dbo.LearningProgram C
ON B.hed__Account__c = C.EDAACCOUNTID__c
LEFT JOIN EDUCPROD.dbo.LearningProgramPlan D
ON C.ID = D.LearningProgramId

select LearningProgramPlanId from EDUCPROD.dbo.LearnerProgram_LOAD

UPDATE A
SET Name = ISNULL(C.Name,'')+' - '+ISNULL(C1.Name,'')
FROM [EDUCPROD].dbo.LearnerProgram_LOAD A
INNER JOIN
edaprod.dbo.hed__Affiliation__c B
ON A.LSU_Affiliation__c = B.ID
LEFT JOIN [EDUCPROD].dbo.LearningProgram C
ON B.hed__Account__c = C.EDAACCOUNTID__c
LEFT JOIN [EDUCPROD].dbo.LearningProgramPlan D
ON C.ID = D.LearningProgramId
LEFT JOIN
[EDUCPROD].dbo.[Contact] C1
ON A.Source_Contact__c = C1.Legacy_ID__c



UPDATE A
SET LearnerContactId = C.ID 
FROM [EDUCPROD].dbo.LearnerProgram_LOAD_4 A
INNER JOIN
[EDUCPROD].dbo.[Contact] C
ON A.Source_Contact__c = C.Legacy_ID__c

--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearnerProgram_LOAD
ALTER COLUMN ID NVARCHAR(18)

SELECT * FROM LearnerProgram_LOAD_4

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','LearnerProgram_LOAD_4'

--DROP TABLE LearnerProgram_LOAD_2
SELECT * 
INTO LearnerProgram_LOAD_4
FROM LearnerProgram_LOAD_3_Result where Error <> 'Operation Successful.'

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

INSERT INTO [EDUCPROD].[dbo].[LearnerProgram_Lookup]
SELECT
 A.ID
,B.EDACERTENROLLID__c AS Legacy_Id__c
--INTO [EDUCPROD].[dbo].[LearnerProgram_Lookup]
FROM LearnerProgram_LOAD_4_Result A
INNER JOIN
[dbo].[08_EDA_Student] B
ON A.Source_contact__c = B.Source_contact__c
AND A.LSU_Affiliation__c = B.LSU_Affiliation__c
WHERE Error = 'Operation Successful.'

SELECT * FROM 
[LearnerProgram_Lookup]





