
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[IndividualApplication_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.IndividualApplication_LOAD
FROM [edcuat].[dbo].[14_EDA_Application] C
ORDER BY ContactId


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE IndividualApplication_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM IndividualApplication_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','IndividualApplication_LOAD'

SELECT * 
--INTO IndividualApplication_LOAD_2
FROM IndividualApplication_LOAD_Result where Error <> 'Operation Successful.'
ORDER BY ContactId

select DISTINCT  Error from IndividualApplication_LOAD_Result

--====================================================================
--ERROR RESOLUTION - IndividualApplication
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
--POPULATING LOOOKUP TABLES- IndividualApplication
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[IndividualApplication_Lookup];
--GO

SELECT
 ID
,legacy_ID__c
INTO [edcuat].[dbo].[IndividualApplication_Lookup]
FROM IndividualApplication_LOAD_Result
WHERE Error = 'Operation Successful.'


--====================================================================
-- UPDATE LOOKUPS 
--====================================================================

-- Application Lookup


SELECT A.ID,C.ID AS application_id__c
into Opportunity_Application_Lookup
FROM [edcuat].[dbo].[Opportunity_Lookup] A
LEFT JOIN
[edcuat].[dbo].[13_EDA_Opportunity] B
ON A.Legacy_ID__c = B.Legacy_ID__c
LEFT JOIN 
[edcuat].[dbo].[IndividualApplication_Lookup] C
ON B.Source_application_id__c = C.Legacy_Id__c
WHERE B.Source_application_id__c IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Opportunity_Application_Lookup'


-- Contact Lookups
SELECT A.ID,B.Source_Contact__c,C.ID AS Contact__c,C.AccountId,C.ID AS SubmittedByContactId
INTO IndividualApplication_Update
FROM [edcuat].[dbo].[IndividualApplication_Lookup] A
LEFT JOIN
[edcuat].[dbo].[14_EDA_Application] B
ON A.legacy_ID__c = B.legacy_ID__c
LEFT JOIN
[edcuat].[dbo].[Contact] C
ON B.Source_Contact__c = C.legacy_ID__c


EXEC SF_TableLoader 'Update:BULKAPI','edcuat','IndividualApplication_Update'


-- Case Program Lookup

SELECT IL.ID,CL.ID AS ApplicationCaseId
INTO IndividualApplication_Case_Update
FROM [dbo].[14_EDA_Application] A
LEFT JOIN [edaprod].[dbo].[Interaction__c] I
ON I.LSU_Application_ID__c = A.Legacy_Id__c
LEFT JOIN [edcuat].[dbo].[IndividualApplication_Lookup] IL
ON A.Legacy_Id__c = IL.legacy_ID__c
LEFT JOIN Case_Lookup CL
ON CL.legacy_ID__c = 'I-'+I.Id
where I.LSU_Application_ID__c is not null

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','IndividualApplication_Case_Update'
