
USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_Opp_Recruitment_LOAD];
--GO
SELECT *
INTO [edcdatadev].dbo.Case_Opp_Recruitment_LOAD
FROM [edcdatadev].[dbo].[11_Case_Opp_Recruitment] C
ORDER BY AccountId


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_Opp_Recruitment_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM Case_Opp_Recruitment_LOAD

EXEC SF_TableLoader 'Upsert:BULKAPI','edcdatadev','Case_Opp_Recruitment_LOAD','Legacy_ID__c'

--DROP TABLE Case_Opp_Recruitment_LOAD_2
SELECT comments__c 
----INTO Case_Opp_Recruitment_LOAD_2
FROM Case_Opp_Recruitment_LOAD_Result where Error <> 'Operation Successful.'
ORDER BY AccountId


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

ALTER TABLE [edcdatadev].[dbo].[Case_Lookup]
ALTER COLUMN Legacy_ID__c NVARCHAR(25)

INSERT INTO [edcdatadev].[dbo].[Case_Lookup]
SELECT
 ID
,legacy_ID__c
FROM Case_Opp_Recruitment_LOAD_Result
WHERE Error = 'Operation Successful.'


--====================================================================
--POPULATING LOOKUP FIELDS - RFI Case
--====================================================================


SELECT A.ID,C.ID AS Related_Recruitment_Case__c
INTO Case_Recruitment_Lookup_Update
FROM [Case] A
LEFT JOIN [edaprod].[dbo].Interaction__c I
ON 'I-'+I.Id = A.Legacy_ID__c
LEFT JOIN Case_Opp_Recruitment_LOAD_Result C
ON I.Opportunity__c = C.Legacy_ID__c
WHERE C.ID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','edcdatadev','Case_Recruitment_Lookup_Update'


SELECT C.ID,A.First_Name__c,A.Last_Name__c,A.ContactEmail,A.Email__c,A.ContactPhone
INTO Case_Contact_Info_Update
FROM Case_Opp_Recruitment_LOAD_Result C
LEFT JOIN
[edcdatadev].[dbo].[11_Case_Opp_Recruitment] A
ON C.Legacy_ID__c = A.Legacy_ID__c


EXEC SF_TableLoader 'Update:BULKAPI','edcdatadev','Case_Contact_Info_Update'


