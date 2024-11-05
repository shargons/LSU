USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - InteractionSummary
--====================================================================


--DROP TABLE IF EXISTS [dbo].[InteractionSummary_LOAD];
--GO
SELECT *
INTO [edcuat].[dbo].[InteractionSummary_LOAD]
FROM [edcuat].[dbo].[31_EDA_ContentNotes] C


SELECT COUNT(*),legacy_Id__c FROM [InteractionSummary_LOAD] GROUP BY legacy_Id__c HAVING COUNT(*) > 1

SELECT * FROM [InteractionSummary_LOAD]
WHERE Legacy_Id__c = '068Kj00000PggEaIAJ-0033n00002ZpHlnAAF'

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE [InteractionSummary_LOAD]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - InteractionSummary
--====================================================================

SELECT * FROM [InteractionSummary_LOAD]

Exec SF_TableLoader 'Insert:bulkapi','edcuat','InteractionSummary_LOAD'

SELECT * 
--INTO InteractionSummary_LOAD_2
FROM InteractionSummary_LOAD_Result where Error <> 'Operation Successful.'

UPDATE InteractionSummary_LOAD
SET FirstPublishLocationId = NULL


SELECT * 
--INTO InteractionSummary_LOAD_2
FROM InteractionSummary_LOAD_Result where Error = 'Operation Successful.'


--====================================================================
--ERROR RESOLUTION - InteractionSummary
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE InteractionSummary_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'InteractionSummary_DELETE'

EXEC SF_Replicate 'edcuat','InteractionSummary','pkchunk,batchsize(50000)'

INSERT INTO InteractionSummary_DELETE(Id) SELECT Id FROM InteractionSummary_LOAD_Result where Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'InteractionSummary_DELETE'


--====================================================================
--POPULATING LOOKUP TABLES- InteractionSummary
--====================================================================


--DROP TABLE IF EXISTS [dbo].[InteractionSummary_Lookup];
--GO

SELECT
 ID
,legacy_ID__c
INTO InteractionSummary_Lookup
FROM InteractionSummary_LOAD_Result
WHERE Error = 'Operation Successful.'


select * from InteractionSummary_Lookup

