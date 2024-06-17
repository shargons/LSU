
USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Account
--====================================================================


--DROP TABLE IF EXISTS [dbo].[AcademicTerm_Term_LOAD];
--GO
SELECT *
INTO [edcdatadev].dbo.AcademicTerm_Term_LOAD
FROM [edcdatadev].[dbo].[09_EDA_Term] C

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
FROM [edcdatadev].dbo.AcademicTerm_Term_LOAD C
LEFT JOIN [edcdatadev].dbo.Account_Lookup B
ON C.Source_Account_ID = B.Legacy_ID__c


--====================================================================
--INSERTING DATA USING DBAMP - Term
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE AcademicTerm_Term_LOAD
ALTER COLUMN ID NVARCHAR(18)

SELECT * FROM AcademicTerm_Term_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','EDCDATADEV','AcademicTerm_Term_LOAD'

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

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[AcademicTerm_Term_Lookup];
--GO

SELECT * FROM [AcademicTerm_Term_Lookup]

--INSERT INTO [edcuat].[dbo].[AcademicTerm_Term_Lookup]
SELECT
 ID
,EDATERMID__c
INTO [edcdatadev].[dbo].[AcademicTerm_Term_Lookup]
FROM AcademicTerm_Term_LOAD_Result
WHERE Error = 'Operation Successful.'


--====================================================================
-- UPDATE LOOKUPS - Term
--====================================================================

SELECT T.ID,TP.ID AS Parent_Term__c
INTO AcademicTerm_Parent_Update
FROM [edcdatadev].[dbo].[09_EDA_Term] C 
LEFT JOIN [edcdatadev].[dbo].AcademicTerm_Term_Lookup T
ON C.EDATERMID__c = T.EDATERMID__c
LEFT JOIN [edcdatadev].[dbo].AcademicTerm_Term_Lookup TP
ON C.Source_Parent_Term = TP.EDATERMID__c
WHERE TP.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCDATADEV','AcademicTerm_Parent_Update'

