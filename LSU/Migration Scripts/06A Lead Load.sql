
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Account
--====================================================================
--DROP TABLE IF EXISTS [dbo].[Lead_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.Lead_LOAD
FROM [edcuat].[dbo].[06_EDA_Lead] C



/******* Check Load table *********/
SELECT * FROM [edcuat].dbo.Lead_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Lead_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','Lead_LOAD'

--DROP TABLE Lead_LOAD_2
SELECT * 
--INTO Lead_LOAD_2
FROM Lead_LOAD_Result where Error <> 'Operation Successful.'


select DISTINCT  Error from Lead_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Account
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Lead_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Lead_DELETE'

INSERT INTO Lead_DELETE(Id) SELECT Id FROM Lead_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Lead_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Account
--====================================================================



-- Lead Lookup
--DROP TABLE IF EXISTS [dbo].[Lead_Lookup];
--GO

INSERT INTO [edcuat].[dbo].[Lead_Lookup]
SELECT
 ID
,Legacy_Id__pc
--INTO [edcuat].[dbo].[Lead_Lookup]
FROM Lead_LOAD_5_Result
WHERE Error = 'Operation Successful.'




