
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Academic Year
--====================================================================
--DROP TABLE IF EXISTS [dbo].[AcademicYear_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.AcademicYear_LOAD
FROM [edcdatadev].[dbo].[05A_EDA_AcademicYear] C


/******* Check Load table *********/
SELECT * FROM [edcuat].dbo.AcademicYear_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE AcademicYear_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','AcademicYear_LOAD'

SELECT * FROM AcademicYear_LOAD_Result where Error <> 'Operation Successful.'

select DISTINCT  Error from AcademicYear_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Account
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE AcademicYear_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'AcademicYear_DELETE'

INSERT INTO AcademicYear_DELETE(Id) SELECT Id FROM AcademicYear_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'AcademicYear_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Account
--====================================================================

-- Contact Lookup
DROP TABLE IF EXISTS [dbo].[AcademicYear_Lookup];
GO
SELECT
 ID
,Name
INTO [edcuat].[dbo].[AcademicYear_Lookup]
FROM AcademicYear_LOAD_Result
WHERE Error = 'Operation Successful.'
