USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Financial_Aid
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Financial_Aid__c_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.Financial_Aid__c_LOAD
FROM [edcuat].[dbo].[16_EDA_Financial_Aid_Record] C
ORDER BY Contact__c


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Financial_Aid__c_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Financial_Aid
--====================================================================

SELECT * FROM Financial_Aid__c_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','Financial_Aid__c_LOAD'

SELECT *
--INTO Financial_Aid__c_LOAD_2
FROM Financial_Aid__c_LOAD_Result where Error <> 'Operation Successful.'
ORDER BY Contact__c

select DISTINCT  Error from Financial_Aid__c_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Financial_Aid
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Financial_Aid__c_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Financial_Aid__c_DELETE'

INSERT INTO Financial_Aid__c_DELETE(Id) SELECT Id FROM Financial_Aid__c_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Financial_Aid__c_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES- Financial_Aid
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[Financial_Aid_Lookup];
--GO
SELECT
 ID
,Legacy_ID__c
INTO [edcuat].[dbo].[Financial_Aid_Lookup]
FROM Financial_Aid__c_LOAD_Result
WHERE Error = 'Operation Successful.'
