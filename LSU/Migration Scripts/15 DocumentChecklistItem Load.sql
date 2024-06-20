USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Document Checklist Item
--====================================================================


--DROP TABLE IF EXISTS [dbo].[DocumentChecklistItem_LOAD];
--GO
SELECT *
INTO [edcdatadev].dbo.DocumentChecklistItem_LOAD
FROM [edcdatadev].[dbo].[15_EDA_ReqDocuments] C
ORDER BY ParentRecordId

SELECT * FROM DocumentChecklistItem_LOAD

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE DocumentChecklistItem_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Document Checklist Item
--====================================================================

SELECT * FROM DocumentChecklistItem_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','EDCDATADEV','DocumentChecklistItem_LOAD'

SELECT * 
--INTO DocumentChecklistItem_LOAD_2
FROM IDocumentChecklistItem_LOAD_Result where Error <> 'Operation Successful.'
ORDER BY ContactId

select DISTINCT  Error from DocumentChecklistItem_LOAD_Result

--====================================================================
--ERROR RESOLUTION - IndividualApplication
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE DocumentChecklistItem_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'DocumentChecklistItem_DELETE'

INSERT INTO IndividualApplication_DELETE(Id) SELECT Id FROM DocumentChecklistItem_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'DocumentChecklistItem_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- IndividualApplication
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[DocumentChecklistItem_Lookup];
--GO

SELECT
 ID
,EDAREQDOCID__c as legacy_ID__c
INTO [edcdatadev].[dbo].[DocumentChecklistItem_Lookup]
FROM DocumentChecklistItem_LOAD_Result
WHERE Error = 'Operation Successful.'
