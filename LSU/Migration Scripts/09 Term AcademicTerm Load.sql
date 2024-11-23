
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Account
--====================================================================


--DROP TABLE IF EXISTS [dbo].[AcademicTerm_Term_LOAD];
--GO
SELECT *
INTO [EDUCPROD].dbo.AcademicTerm_Term_LOAD
FROM [EDUCPROD].[dbo].[09_EDA_Term] C

SELECT * FROM AcademicTerm_Term_LOAD

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE AcademicTerm_Term_LOAD
ALTER COLUMN ID NVARCHAR(18)

ALTER TABLE AcademicTerm_Term_LOAD
ALTER COLUMN Parent_Term__c NVARCHAR(18)

ALTER TABLE AcademicTerm_Term_LOAD
ALTER COLUMN Account__c NVARCHAR(18)

/******* Update AcademicTerm_Term_LOAD Load table *********/

UPDATE C
SET C.Account__c = B.ID
FROM [EDUCPROD].dbo.AcademicTerm_Term_LOAD C
LEFT JOIN [EDUCPROD].dbo.Account B
ON C.Source_Account_ID = B.Legacy_ID__c


--====================================================================
--INSERTING DATA USING DBAMP - Term
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE AcademicTerm_Term_LOAD
ALTER COLUMN ID NVARCHAR(18)

SELECT * FROM AcademicTerm_Term_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','AcademicTerm_Term_LOAD'

SELECT * 
--INTO LearnerProgram_LOAD_2
FROM AcademicTerm_Term_LOAD_Result where Error <> 'Operation Successful.'

select DISTINCT  Error from AcademicTerm_Term_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Term
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE AcademicTerm_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'AcademicTerm_DELETE'

INSERT INTO AcademicTerm_DELETE(Id) SELECT Id FROM AcademicTerm_Term_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'AcademicTerm_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Term
--====================================================================


--DROP TABLE IF EXISTS [dbo].[AcademicTerm_Term_Lookup];
--GO

SELECT * FROM [AcademicTerm_Term_Lookup]

--INSERT INTO [EDUCPROD].[dbo].[AcademicTerm_Term_Lookup]
SELECT
 ID
,EDATERMID__c
INTO [EDUCPROD].[dbo].[AcademicTerm_Term_Lookup]
FROM AcademicTerm_Term_LOAD_Result
WHERE Error = 'Operation Successful.'


--====================================================================
-- UPDATE LOOKUPS - Term
--====================================================================
DROP TABLE AcademicTerm_Parent_Update
SELECT T.ID,TP.ID AS Parent_Term__c
INTO AcademicTerm_Parent_Update
FROM [EDUCPROD].[dbo].[09_EDA_Term] C 
LEFT JOIN [EDUCPROD].[dbo].AcademicTerm_Term_Lookup T
ON C.EDATERMID__c = T.EDATERMID__c
LEFT JOIN [EDUCPROD].[dbo].AcademicTerm_Term_Lookup TP
ON C.Source_Parent_Term = TP.EDATERMID__c
WHERE TP.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','AcademicTerm_Parent_Update'

SELECT * FROM [EDUCPROD].[dbo].[AcademicTerm_Term_Lookup]
WHERE EDATERMID__c = 'a0C3n00000Q0EqsEAF'

