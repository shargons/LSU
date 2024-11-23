
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Account
--====================================================================
--DROP TABLE IF EXISTS [dbo].[LearningProgram_LOAD];
--GO
SELECT C.*,L.ID AS LearningId
INTO [EDUCPROD].dbo.LearningProgram_LOAD
FROM [EDUCPROD].[dbo].[04_EDA_AccountProgram] C
LEFT JOIN [EDUCPROD].[dbo].[Learning] L
ON C.EDAACCOUNTID__c = L.EDAACCOUNTID__c


/******* Check Load table *********/
SELECT * FROM [EDUCPROD].dbo.LearningProgram_LOAD


--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearningProgram_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','LearningProgram_LOAD_2'

--DROP TABLE LearningProgram_LOAD_2
SELECT * 
INTO LearningProgram_LOAD_2
FROM LearningProgram_LOAD_Result where Error <> 'Operation Successful.'
and Error like 'INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST%'

select * from LearningProgram_LOAD_2

UPDATE LearningProgram_LOAD_2
SET clientemployer__c = REPLACE(clientemployer__c,'Macy''s','Macys')
WHERE clientemployer__c like'%Macy%'

select DISTINCT  Error from LearningProgram_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Account
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE LearningProgram_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'LearningProgram_DELETE'

INSERT INTO LearningProgram_DELETE(Id) SELECT Id FROM LearningProgram_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'LearningProgram_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Account
--====================================================================

-- Contact Lookup
DROP TABLE IF EXISTS [dbo].[Account_Program_Lookup];
GO
INSERT INTO [EDUCPROD].[dbo].[Account_Program_Lookup]
SELECT
 ID
,EDAACCOUNTID__c as Legacy_ID__c
--INTO [EDUCPROD].[dbo].[Account_Program_Lookup]
FROM LearningProgram_LOAD_2_Result
WHERE Error = 'Operation Successful.'



SELECT * FROM [Account_Program_Lookup]



SELECT B.ID,P.ID AS ParentId,'012Hu000001n1hbIAA' as RecordtypeId
--INTO  Account_ParentId_Update
FROM [dbo].[04_EDA_AccountProgram]  A
INNER JOIN
Account B
ON A.EDAACCOUNTID__c = B.EDAACCOUNTID__c
LEFT JOIN 
[Account] P
ON A.Source_ParentID = P.Legacy_Id__c
where b.ParentId is null

SELECT * FROM [dbo].[04A_EDA_ProgramParents] 
WHERE Legacy_Id__c = '0013n000022SXdwAAG'

