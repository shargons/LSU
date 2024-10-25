
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Academic Year
--====================================================================
--DROP TABLE IF EXISTS [dbo].[AcademicTerm_LOAD];
--GO
SELECT *
INTO [edcuat].[dbo].AcademicTerm_LOAD
FROM [edcuat].[dbo].[05B_EDA_AcademicTerm] C



/******* Check Load table *********/
SELECT * FROM [edcuat].dbo.AcademicTerm_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE AcademicTerm_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','AcademicTerm_LOAD'

SELECT * FROM AcademicTerm_LOAD_Result where Error <> 'Operation Successful.'

select DISTINCT  Error from AcademicTerm_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Account
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE AcademicTerm_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'AcademicTerm_DELETE'

INSERT INTO AcademicTerm_DELETE(Id) SELECT Id FROM AcademicTerm_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'AcademicTerm_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Account
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[AcademicTerm_Lookup];
--GO
SELECT
 ID
,Name
INTO [edcuat].[dbo].[AcademicTerm_Lookup]
FROM AcademicTerm_LOAD_Result
WHERE Error = 'Operation Successful.'
