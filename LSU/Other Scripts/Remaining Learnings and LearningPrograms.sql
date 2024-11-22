
--DROP TABLE Learning_LOAD_rem
SELECT *
INTO [edcuat].dbo.Learning_LOAD_rem_2
FROM [dbo].[03_EDA_Learning] A
WHERE A.EDAACCOUNTID__c IN (
'001Kj00002Sa3krIAB',
'001Kj00002TcoVDIAZ',
'001Kj00002UzNDaIAN'
)

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Learning_LOAD_rem_2
ALTER COLUMN ID NVARCHAR(18)

select * from Learning_LOAD_rem_2

EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','Learning_LOAD_rem_2'

SELECT
*
--INTO [edcuat].[dbo].[Account_Program_Lookup]
FROM Learning_LOAD_rem_Result
WHERE Error <> 'Operation Successful.'

INSERT INTO [edcuat].[dbo].[Learning_Lookup]
SELECT
 ID
,EDAACCOUNTID__c as Legacy_ID__c
FROM Learning_LOAD_rem_Result
WHERE Error = 'Operation Successful.'


-- Learning Progran
DROP TABLE LearningProgram_LOAD_rem
SELECT C.*,L.ID AS LearningId
INTO [edcuat].dbo.LearningProgram_LOAD_rem_2
FROM [edcuat].[dbo].[04_EDA_AccountProgram] C
LEFT JOIN [edcuat].[dbo].[Learning] L
ON C.EDAACCOUNTID__c = L.EDAACCOUNTID__c
WHERE C.EDAACCOUNTID__c IN  (
'001Kj00002Sa3krIAB',
'001Kj00002TcoVDIAZ',
'001Kj00002UzNDaIAN'
)

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearningProgram_LOAD_rem_2
ALTER COLUMN ID NVARCHAR(18)

SELECT * FROM LearningProgram_LOAD_rem_2




EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','LearningProgram_LOAD_rem_2'


SELECT
*
--INTO [edcuat].[dbo].[Account_Program_Lookup]
FROM LearningProgram_LOAD_rem_Result
WHERE Error <> 'Operation Successful.'

INSERT INTO [edcuat].[dbo].[Account_Program_Lookup]
SELECT
 ID
,EDAACCOUNTID__c as Legacy_ID__c
FROM LearningProgram_LOAD_rem_2_Result
WHERE Error = 'Operation Successful.'


-- Learning Program Plan
DROP TABLE LearningProgramPlan_LOAD_3
SELECT *
INTO [edcuat].dbo.LearningProgramPlan_LOAD_3
FROM [dbo].[07_EDA_LearningProgramPlan]
WHERE Legacy_Id__c IN (
'001Kj00002Sa3krIAB',
'001Kj00002TcoVDIAZ',
'001Kj00002UzNDaIAN'
)

SELECT * FROM LearningProgramPlan_LOAD_3

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearningProgramPlan_LOAD_3
ALTER COLUMN ID NVARCHAR(18)

EXEC SF_TableLoader 'Upsert:BULKAPI','EDCUAT','LearningProgramPlan_LOAD_3','Legacy_Id__c'

SELECT * FROM LearningProgramPlan_LOAD_3_result
WHERE Error <> 'Operation Successful.'


INSERT INTO [edcuat].[dbo].[LearningProgramPlan_Lookup]
SELECT
 ID
,Name as Legacy_ID__c
,LearningProgramId
FROM LearningProgramPlan_LOAD_3_Result
WHERE Error = 'Operation Successful.'

