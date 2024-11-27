
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - ContactProfile
--====================================================================


--DROP TABLE IF EXISTS [dbo].[ContactProfile_LOAD];
--GO
SELECT *
INTO [EDUCPROD].[dbo].[ContactProfile_LOAD]
FROM [EDUCPROD].[dbo].[06_ContactProfile]  C


SELECT * FROM [ContactProfile_LOAD]

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE [ContactProfile_LOAD]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - ContactProfile
--====================================================================

SELECT * FROM [ContactProfile_LOAD]

Exec SF_TableLoader 'Insert:BULKAPI','EDUCPROD','ContactProfile_LOAD_2'

SELECT * 
--INTO ContactProfile_LOAD_2
FROM ContactProfile_LOAD_Result where Error <> 'Operation Successful.'


select distinct hed__Ethnicity__c
from [edaprod].[dbo].[Contact]



--====================================================================
--ERROR RESOLUTION - ContactProfile
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE ContactProfile_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'ContactProfile_DELETE'

INSERT INTO ContactProfile_DELETE(Id) SELECT Id FROM ContactProfile where Legacy_Id__c is not null

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'ContactProfile_DELETE'


--====================================================================
--POPULATING LOOKUP TABLES- ContactProfile
--====================================================================


--DROP TABLE IF EXISTS [dbo].[ContactProfile_Lookup];
--GO

SELECT
 ID
,legacy_ID__c
INTO ContactProfile_Lookup
FROM ContactProfile_LOAD_Result
WHERE Error = 'Operation Successful.'


select * from ContactProfile_Lookup


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