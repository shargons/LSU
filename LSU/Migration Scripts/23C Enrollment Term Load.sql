
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Term
--====================================================================


--DROP TABLE IF EXISTS [dbo].[AcademicTerm_Enr_LOAD];
--GO
SELECT *
INTO [EDUCPROD].dbo.AcademicTerm_Enr_LOAD
FROM [EDUCPROD].[dbo].[23C_Enr_AcademicTerm] C

SELECT * FROM AcademicTerm_Enr_LOAD

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE AcademicTerm_Enr_LOAD
ALTER COLUMN ID NVARCHAR(18)



--====================================================================
--INSERTING DATA USING DBAMP - Term
--====================================================================


EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','AcademicTerm_Enr_LOAD'

SELECT * 
--INTO LearnerProgram_LOAD_2
FROM AcademicTerm_Enr_LOAD_Result where Error <> 'Operation Successful.'

select DISTINCT  Error from AcademicTerm_Term_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Term
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE AcademicTerm_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'AcademicTerm_DELETE'

INSERT INTO AcademicTerm_DELETE(Id) SELECT Id FROM AcademicTerm_Enr_LOAD_Result WHERE Error = 'Operation Successful.'

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

INSERT INTO [EDUCPROD].[dbo].[AcademicTerm_Term_Lookup]
SELECT
 ID
,EDATERMID__c
--INTO [EDUCPROD].[dbo].[AcademicTerm_Term_Lookup]
FROM AcademicTerm_Enr_LOAD_Result
WHERE Error = 'Operation Successful.'


