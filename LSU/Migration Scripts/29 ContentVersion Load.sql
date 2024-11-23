
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - ContentVersion
--====================================================================

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_Blobs_1'

--DROP TABLE IF EXISTS [dbo].[ContentVersion_LOAD];
--GO
SELECT *
INTO [EDUCPROD].[dbo].[ContentVersion_LOAD]
FROM [EDUCPROD].[dbo].[29_EDA_ContentVersion] C


SELECT * FROM [ContentVersion_LOAD]

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE [ContentVersion_LOAD]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - ContentVersion
--====================================================================

SELECT * FROM [ContentVersion_LOAD]

Exec SF_TableLoader 'Insert:soap','EDUCPROD','ContentVersion_LOAD'

SELECT * 
--INTO ContentVersion_LOAD_2
FROM ContentVersion_LOAD_2_Result where Error <> 'Operation Successful.'

UPDATE ContentVersion_LOAD
SET FirstPublishLocationId = NULL


SELECT * 
--INTO ContentVersion_LOAD_2
FROM ContentVersion_LOAD_Result where Error = 'Operation Successful.'


--====================================================================
--ERROR RESOLUTION - ContentVersion
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE ContentDocument_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'ContentDocument_DELETE'

EXEC SF_Replicate 'EDUCPROD','ContentVersion','pkchunk,batchsize(50000)'

INSERT INTO ContentDocument_DELETE(Id) SELECT ContentDocumentId FROM ContentVersion where Legacy_Id__c is not null

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'ContentDocument_DELETE'

SELECT * FROM 
ContentDocument_DELETE_Result

--====================================================================
--POPULATING LOOKUP TABLES- ContentVersion
--====================================================================


--DROP TABLE IF EXISTS [dbo].[ContentVersion_Lookup];
--GO

SELECT
 ID
,legacy_ID__c
INTO ContentVersion_Lookup
FROM ContentVersion_LOAD_Result
WHERE Error = 'Operation Successful.'


select * from ContentVersion_Lookup


--====================================================================
--INSERTING DATA USING DBAMP - ContentDocumentLink
--====================================================================

EXEC SF_Replicate 'EDUCPROD','ContentVersion','pkchunk,batchsize(50000)'


SELECT NULL AS Id,U.Id as LinkedEntityId,CV.ContentDocumentId,'V' AS ShareType,'AllUsers' as Visibility
INTO ContentDocumentLink_Insert
FROM [edaprod].[dbo].[ContentVersion] C
LEFT JOIN
EDUCPROD.dbo.User_Lookup U
ON C.FirstPublishLocationId = U.Legacy_ID__c
LEFT JOIN 
[EDUCPROD].[dbo].[ContentVersion] CV
ON C.Id = CV.Legacy_Id__c

ALTER TABLE ContentDocumentLink_Insert
ALTER COLUMN ID NVARCHAR(18)


Exec SF_TableLoader 'Insert','EDUCPROD','ContentDocumentLink_Insert'

SELECT * FROM ContentDocumentLink_Insert_RESULT