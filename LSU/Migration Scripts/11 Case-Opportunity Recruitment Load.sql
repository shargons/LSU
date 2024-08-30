
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_Opp_Recruitment_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.Case_Opp_Recruitment_LOAD
FROM [edcuat].[dbo].[11_Case_Opp_Recruitment] C
ORDER BY AccountId


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_Opp_Recruitment_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM Case_Opp_Recruitment_LOAD_3

EXEC SF_TableLoader 'Upsert:BULKAPI','edcuat','Case_Opp_Recruitment_LOAD_3','Legacy_ID__c'

--DROP TABLE Case_Opp_Recruitment_LOAD_2
SELECT *
INTO Case_Opp_Recruitment_LOAD_3
FROM Case_Opp_Recruitment_LOAD_2_Result where Error <> 'Operation Successful.'
ORDER BY AccountId

UPDATE Case_Opp_Recruitment_LOAD_3
SET Last_Name__c = null


select DISTINCT  Error from Case_Opp_Recruitment_LOAD_Result



--====================================================================
--ERROR RESOLUTION - Case
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Case_Opp_Recruitment_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Case_Opp_Recruitment_DELETE'

INSERT INTO Case_Opp_Recruitment_DELETE(Id) SELECT Id FROM Case_Opp_Recruitment_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Case_Opp_Recruitment_DELETE'


--====================================================================
--POPULATING LOOOKUP TABLES- Case
--====================================================================

-- Contact Lookup
DROP TABLE IF EXISTS [dbo].[Case_Lookup];
GO

ALTER TABLE [edcuat].[dbo].[Case_Lookup]
ALTER COLUMN Legacy_ID__c NVARCHAR(25)

INSERT INTO [edcuat].[dbo].[Case_Lookup]
SELECT
 ID
,legacy_ID__c
FROM Case_Opp_Recruitment_LOAD_3_Result
WHERE Error = 'Operation Successful.'


--====================================================================
--POPULATING LOOKUP FIELDS - RFI Case
--====================================================================


SELECT A.ID,C.ID AS Related_Recruitment_Case__c
INTO Case_Recruitment_Lookup_Update
FROM [Case] A
LEFT JOIN [edaprod].[dbo].Interaction__c I
ON 'I-'+I.Id = A.Legacy_ID__c
LEFT JOIN [Case_Lookup] C
ON I.Opportunity__c = C.Legacy_ID__c
WHERE C.ID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Recruitment_Lookup_Update'

SELECT *
FROM Case_Contact_Info_Update_Result
WHERE Error <> 'Operation Successful.'


SELECT C.ID,A.First_Name__c,A.Last_Name__c,A.ContactEmail,A.Email__c,A.ContactPhone
INTO Case_Contact_Info_Update
FROM [Case_Lookup] C
LEFT JOIN
[edcuat].[dbo].[11_Case_Opp_Recruitment] A
ON C.Legacy_ID__c = A.Legacy_ID__c


EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Contact_Info_Update'


