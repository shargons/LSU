
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_LOAD];
--GO
SELECT *
INTO [edcuat].[dbo].[Case_LOAD]
FROM [edcuat].[dbo].[27_EDA_Case] C
ORDER BY ContactId

SELECT * FROM Case_LOAD

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM Case_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','Case_LOAD_3'

--DROP TABLE Case_LOAD_3
SELECT * 
INTO Case_LOAD_3
FROM Case_LOAD_2_Result where Error <> 'Operation Successful.'
ORDER BY ContactId

update Case_LOAD_3
set Last_Name__c = null

select DISTINCT  Error from Case_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Case
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Case_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Case_DELETE'

INSERT INTO Case_DELETE(Id) SELECT Id FROM Case_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Case_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Case
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[Case_Case_Lookup];
--GO
INSERT INTO [edcuat].[dbo].[Case_Case_Lookup]
SELECT
 ID
,legacy_ID__c
--INTO Case_Case_Lookup
FROM Case_LOAD_3_Result
WHERE Error = 'Operation Successful.'





