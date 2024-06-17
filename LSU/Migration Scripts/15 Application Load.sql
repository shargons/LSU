
USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[IndividualApplication_LOAD];
--GO
SELECT *
INTO [edcdatadev].dbo.IndividualApplication_LOAD
FROM [edcdatadev].[dbo].[15_EDA_Application] C
ORDER BY ContactId

SELECT * FROM IndividualApplication_LOAD

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE IndividualApplication_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM IndividualApplication_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','EDCDATADEV','IndividualApplication_LOAD'

SELECT * 
--INTO IndividualApplication_LOAD_2
FROM IndividualApplication_LOAD_Result where Error <> 'Operation Successful.'
ORDER BY ContactId

select DISTINCT  Error from IndividualApplication_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Case
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE IndividualApplication_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'IndividualApplication_DELETE'

INSERT INTO IndividualApplication_DELETE(Id) SELECT Id FROM IndividualApplication_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'IndividualApplication_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Case
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[IndividualApplication_Lookup];
--GO

SELECT
 ID
,legacy_ID__c
--INTO [edcdatadev].[dbo].[IndividualApplication_Lookup]
FROM IndividualApplication_LOAD_Result
WHERE Error = 'Operation Successful.'


--====================================================================
-- UPDATE LOOKUPS 
--====================================================================

-- Opportunity Lookup