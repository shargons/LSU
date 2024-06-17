
USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Account
--====================================================================
--DROP TABLE IF EXISTS [dbo].[LearnerProgram_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.LearnerProgram_LOAD
FROM [edcdatadev].[dbo].[08_EDA_Student] C



/******* Update LearningProgramPlan Load table *********/

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearnerProgram_LOAD
ALTER COLUMN LearningProgramPlanId NVARCHAR(18)

ALTER TABLE LearnerProgram_LOAD
ALTER COLUMN LearnerContactId NVARCHAR(18)

UPDATE A
SET LearningProgramPlanId = D.ID 
FROM edcuat.dbo.LearnerProgram_LOAD A
INNER JOIN
edaprod.dbo.hed__Affiliation__c B
ON A.LSU_Affiliation__c = B.ID
LEFT JOIN edcuat.dbo.Account_Program_Lookup C
ON B.hed__Account__c = C.Legacy_ID__c
LEFT JOIN edcuat.dbo.LearningProgramPlan_Lookup D
ON C.ID = D.LearningProgramId

UPDATE A
SET Name = ISNULL(C.Name,'')+' - '+ISNULL(C1.Name,'')
FROM [edcuat].dbo.LearnerProgram_LOAD A
INNER JOIN
edaprod.dbo.hed__Affiliation__c B
ON A.LSU_Affiliation__c = B.ID
LEFT JOIN [edcuat].dbo.LearningProgram C
ON B.hed__Account__c = C.EDAACCOUNTID__c
LEFT JOIN [edcuat].dbo.LearningProgramPlan_Lookup D
ON C.ID = D.LearningProgramId
LEFT JOIN
[edcuat].dbo.[Contact] C1
ON A.Source_Contact__c = C1.Legacy_ID__c



UPDATE A
SET LearnerContactId = C.ID 
FROM [edcuat].dbo.LearnerProgram_LOAD A
INNER JOIN
[edcuat].dbo.[Contact] C
ON A.Source_Contact__c = C.Legacy_ID__c

--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearnerProgram_LOAD
ALTER COLUMN ID NVARCHAR(18)

SELECT * FROM LearnerProgram_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','LearnerProgram_LOAD_2'

SELECT * 
--INTO LearnerProgram_LOAD_2
FROM LearnerProgram_LOAD_2_Result where Error <> 'Operation Successful.'

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

INSERT INTO [edcuat].[dbo].[LearnerProgram_Lookup]
SELECT
 ID
,Source_contact__c
,LSU_Affiliation__c
--INTO [edcuat].[dbo].[LearnerProgram_Lookup]
FROM LearnerProgram_LOAD_2_Result
WHERE Error = 'Operation Successful.'

SELECT * FROM 
[LearnerProgram_Lookup]





