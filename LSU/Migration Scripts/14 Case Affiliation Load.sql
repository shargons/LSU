
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_Affiliation_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.Case_Affiliation_LOAD
FROM [edcuat].[dbo].[14_EDA_Affiliations] C
ORDER BY ContactId

SELECT * FROM Case_Affiliation_LOAD
where first_interaction_date__c is not null

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_Affiliation_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================


SELECT * FROM Case_Affiliation_LOAD


EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','Case_Affiliation_LOAD_3'

--DROP TABLE Case_Affiliation_LOAD_3
SELECT * 
--INTO Case_Affiliation_LOAD_3
FROM Case_Affiliation_LOAD_3_Result where Error <> 'Operation Successful.'
AND Error NOT LIKE 'DUPLICATE_VALUE:duplicate value found%'
ORDER BY ContactId

update Case_Affiliation_LOAD
set email__c = NULL

select DISTINCT  Error from Case_Affiliation_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Case
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Case_Affiliation_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Case_Affiliation_DELETE'

INSERT INTO Case_Affiliation_DELETE(Id) SELECT Id FROM Case_Affiliation_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Case_Affiliation_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Case
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[Case_Lookup];
--GO
INSERT INTO [edcuat].[dbo].[Case_Aff_Lookup]
SELECT
 ID
,legacy_ID__c
--INTO [edcuat].[dbo].[Case_Aff_Lookup]
FROM Case_Affiliation_LOAD_3_Result
WHERE Error = 'Operation Successful.'

SELECT * FROM [edcuat].[dbo].[Case_Lookup]



--====================================================================
-- UPDATE Lookups -- Case
--====================================================================


--DROP TABLE Case_Field_Update
SELECT A.ID,B.application_Id__c,B.application_status__c,B.Application_Slate_ID__c,B.application_status_code__c,B.PLA_status__c
INTO Case_Field_Update
FROM [edcuat].[dbo].[Case] A
INNER JOIN [edcuat].[dbo].[14_EDA_Affiliations] B
ON A.legacy_ID__c = B.legacy_ID__c
--where B.Related_Opportunity__c is not null

SELECT * FROM Case_Field_Update
where application_id__c is not null

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Field_Update'

select * from Case_Field_Update_Result
where eRROR <> 'Operation Successful.'

---- Source_contact_retention__c

--SELECT A.ID,C.ID AS contact_retention__c
--INTO Case_CR_Update
--FROM [edcuat].[dbo].[Case_Lookup] A
--LEFT JOIN [edcuat].[dbo].[10_EDA_Affiliations] B
--ON A.legacy_ID__c = B.legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[Contact] C
--ON B.Source_contact_retention__c = C.Legacy_ID__c

--EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_CR_Update'

-- Source_lsuam_upcoming_term__c
--DROP TABLE Case_UT_Update
SELECT A.ID,AL.ID AS lsuam_upcoming_term__c
INTO Case_UT_Update
FROM [edcuat].[dbo].[Case_Lookup] A
LEFT JOIN [edcuat].[dbo].[14_EDA_Affiliations] B
ON A.legacy_ID__c = B.legacy_ID__c
LEFT JOIN [edcuat].[dbo].[AcademicTerm_Term_Lookup] AL
ON AL.EDATERMID__c = B.Source_lsuam_upcoming_term__c  
WHERE B.Source_lsuam_upcoming_term__c IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_UT_Update'

-- Source_lsuam_current_term__c
DROP TABLE Case_CT_Update
SELECT A.ID,AL.ID AS lsuam_current_term__c
INTO Case_CT_Update
FROM [edcuat].[dbo].[Case_Lookup] A
INNER JOIN [edcuat].[dbo].[14_EDA_Affiliations] B
ON A.legacy_ID__c = B.legacy_ID__c
LEFT JOIN [edcuat].[dbo].[AcademicTerm_Term_Lookup] AL
ON AL.EDATERMID__c = B.Source_lsuam_current_term__c  
WHERE B.Source_lsuam_current_term__c IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_CT_Update'

-- Application Lookup

SELECT A.ID,B.application_id__c
--INTO Case_App_Update
FROM [edcuat].[dbo].[Case_Aff_Lookup] A
INNER JOIN [edcuat].[dbo].[14_EDA_Affiliations] B
ON A.legacy_ID__c = B.legacy_ID__c
WHERE application_id__c IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_App_Update'
