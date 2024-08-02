
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_Affiliation_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.Case_Affiliation_LOAD
FROM [edcuat].[dbo].[10_EDA_Affiliations] C
ORDER BY ContactId

SELECT * FROM Case_Affiliation_LOAD
where firstinteractiondate__c is not null

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_Affiliation_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================


SELECT * FROM Case_Affiliation_LOAD


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','Case_Affiliation_LOAD_9'

--DROP TABLE Case_Affiliation_LOAD_2
SELECT * 
INTO Case_Affiliation_LOAD_9
FROM Case_Affiliation_LOAD_8_Result where Error <> 'Operation Successful.'
AND Error NOT Like '%UNABLE%'
AND Error NOT Like '%DUPLICATE%'
ORDER BY ContactId

select DISTINCT  Error from Case_Affiliation_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Case
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Case_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Case_DELETE'

INSERT INTO Case_DELETE(Id) SELECT Id FROM Case_Affiliation_LOAD_2_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Case_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Case
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[Case_Lookup];
--GO
INSERT INTO [edcuat].[dbo].[Case_Lookup]
SELECT
 ID
,legacy_ID__c
--INTO [edcuat].[dbo].[Case_Lookup]
FROM Case_Affiliation_LOAD_8_Result
WHERE Error = 'Operation Successful.'

SELECT * FROM [edcuat].[dbo].[Case_Lookup]



--====================================================================
-- UPDATE Lookups -- Case
--====================================================================

---- FirstInteractionDate, CE Status and CE Sub Status

--SELECT A.ID,B.First_Interaction_Date__c,CE_Status__c,CE_Sub_Status__c
--INTO Case_FS_Update
--FROM [edcuat].[dbo].[Case_Lookup] A
--LEFT JOIN [edcuat].[dbo].[10_EDA_Affiliations] B
--ON A.legacy_ID__c = B.legacy_ID__c

--EXEC SF_TableLoader 'Update:BULKAPI','EDCDATADEV','Case_FS_Update'



---- Source_contact_retention__c

--SELECT A.ID,C.ID AS contact_retention__c
--INTO Case_CR_Update
--FROM [edcuat].[dbo].[Case_Lookup] A
--LEFT JOIN [edcuat].[dbo].[10_EDA_Affiliations] B
--ON A.legacy_ID__c = B.legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[Contact] C
--ON B.Source_contact_retention__c = C.Legacy_ID__c

--EXEC SF_TableLoader 'Update:BULKAPI','EDCDATADEV','Case_CR_Update'

-- Source_lsuam_upcoming_term__c

SELECT A.ID,AL.ID AS lsuam_upcoming_term__c
INTO Case_UT_Update
FROM [edcuat].[dbo].[Case_Lookup] A
LEFT JOIN [edcuat].[dbo].[10_EDA_Affiliations] B
ON A.legacy_ID__c = B.legacy_ID__c
LEFT JOIN [edcuat].[dbo].[AcademicTerm_Term_Lookup] AL
ON AL.EDATERMID__c = B.Source_lsuam_upcoming_term__c  
WHERE B.Source_lsuam_upcoming_term__c IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Case_UT_Update'

-- Source_lsuam_current_term__c

SELECT A.ID,AL.ID AS lsuam_current_term__c
INTO Case_CT_Update
FROM [edcuat].[dbo].[Case_Lookup] A
LEFT JOIN [edcuat].[dbo].[10_EDA_Affiliations] B
ON A.legacy_ID__c = B.legacy_ID__c
LEFT JOIN [edcuat].[dbo].[AcademicTerm_Term_Lookup] AL
ON AL.EDATERMID__c = B.Source_lsuam_current_term__c  
WHERE B.Source_lsuam_current_term__c IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Case_CT_Update'