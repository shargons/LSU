USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Document Checklist Item
--====================================================================


--DROP TABLE IF EXISTS [dbo].[DocumentChecklistItem_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.DocumentChecklistItem_LOAD
FROM [edcuat].[dbo].[15_EDA_ReqDocuments] C
ORDER BY ParentRecordId


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE DocumentChecklistItem_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Document Checklist Item
--====================================================================

SELECT * FROM DocumentChecklistItem_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','DocumentChecklistItem_LOAD_2'

EXEC SF_TableLoader 'Upsert:BULKAPI','edcuat','DocumentChecklistItem_LOAD','EDAREQDOCID__c'

SELECT *
--INTO DocumentChecklistItem_LOAD_2
FROM DocumentChecklistItem_LOAD_Result where Error <> 'Operation Successful.'
AND Error NOT LIKE '%DUPLICATE%'
ORDER BY ParentRecordId

select DISTINCT  Error from DocumentChecklistItem_LOAD_4_Result

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
INSERT INTO [edcuat].[dbo].[DocumentChecklistItem_Lookup]
SELECT
 ID
,EDAREQDOCID__c as legacy_ID__c
--INTO [edcuat].[dbo].[DocumentChecklistItem_Lookup]
FROM DocumentChecklistItem_LOAD_2_Result
WHERE Error = 'Operation Successful.'
