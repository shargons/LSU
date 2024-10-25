
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Chat Transcript
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Chat_Transcript__c_LOAD];
--GO
SELECT *
INTO [edcuat].[dbo].[Chat_Transcript__c_LOAD]
FROM [edcuat].[dbo].[28_EDA_ChatTranscripts] C
ORDER BY Contact__c

SELECT * FROM [Chat_Transcript__c_LOAD]

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE [Chat_Transcript__c_LOAD]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM [Chat_Transcript__c_LOAD]

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','Chat_Transcript__c_LOAD_2'

SELECT * 
INTO Chat_Transcript__c_LOAD_2
FROM Chat_Transcript__c_LOAD_Result where Error <> 'Operation Successful.'
ORDER BY ContactId


select DISTINCT  Error from Chat_Transcript__c_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Case
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Chat_Transcript__c_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Chat_Transcript__c_DELETE'

INSERT INTO Chat_Transcript__c_DELETE(Id) SELECT Id FROM Chat_Transcript__c_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Chat_Transcript__c_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Case
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[Chat_Transcript_Lookup];
--GO

INSERT INTO Chat_Transcript_Lookup
SELECT
 ID
,legacy_ID__c
FROM Chat_Transcript__c_LOAD_2_Result
WHERE Error = 'Operation Successful.'

SELECT * FROM Chat_Transcript_Lookup




