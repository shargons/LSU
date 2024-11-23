
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_Affiliation_LOAD];
--GO
SELECT *
INTO [EDUCPROD].dbo.Case_Affiliation_LOAD
FROM [EDUCPROD].[dbo].[14_EDA_Affiliations] C
ORDER BY ContactId



/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_Affiliation_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================


SELECT * FROM Case_Affiliation_LOAD


EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Case_Affiliation_LOAD_7'

DROP TABLE Case_Affiliation_LOAD_7
SELECT * 
INTO Case_Affiliation_LOAD_7
FROM Case_Affiliation_LOAD_6_Result where Error <> 'Operation Successful.'
AND Error NOT LIKE 'DUPLICATE%'
ORDER BY ContactId

update Case_Affiliation_LOAD_7
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
--DROP TABLE IF EXISTS [dbo].[Case_Aff_Lookup];
--GO
INSERT INTO [EDUCPROD].[dbo].[Case_Aff_Lookup]
SELECT
 ID
,legacy_ID__c
--INTO [EDUCPROD].[dbo].[Case_Aff_Lookup]
FROM Case_Affiliation_LOAD_7_Result
WHERE Error = 'Operation Successful.'

SELECT * FROM [EDUCPROD].[dbo].[Case_Aff_Lookup]



--====================================================================
-- UPDATE Lookups -- Case
--====================================================================


--DROP TABLE Case_Field_Update
SELECT A.ID,B.application_Id__c,B.application_status__c,B.Application_Slate_ID__c,B.application_status_code__c,B.PLA_status__c
INTO Case_Field_Update
FROM [EDUCPROD].[dbo].[Case] A
INNER JOIN [EDUCPROD].[dbo].[14_EDA_Affiliations] B
ON A.legacy_ID__c = B.legacy_ID__c
--where B.Related_Opportunity__c is not null

SELECT * FROM Case_Field_Update_Result
where application_id__c is not null

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Field_Update'

select * from Case_Field_Update_Result
where eRROR <> 'Operation Successful.'


-- Source_lsuam_upcoming_term__c
--DROP TABLE Case_UT_Update
SELECT A.ID,AL.ID AS lsuam_upcoming_term__c
INTO Case_UT_Update
FROM [EDUCPROD].[dbo].[Case] A
LEFT JOIN [EDUCPROD].[dbo].[14_EDA_Affiliations] B
ON A.legacy_ID__c = B.legacy_ID__c
LEFT JOIN [EDUCPROD].[dbo].[AcademicTerm] AL
ON AL.EDATERMID__c = B.Source_lsuam_upcoming_term__c  
WHERE B.Source_lsuam_upcoming_term__c IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_UT_Update'

-- Source_lsuam_current_term__c
DROP TABLE Case_CT_Update
SELECT A.ID,AL.ID AS lsuam_current_term__c
INTO Case_CT_Update
FROM [EDUCPROD].[dbo].[Case] A
INNER JOIN [EDUCPROD].[dbo].[14_EDA_Affiliations] B
ON A.legacy_ID__c = B.legacy_ID__c
LEFT JOIN [EDUCPROD].[dbo].[AcademicTerm] AL
ON AL.EDATERMID__c = B.Source_lsuam_current_term__c  
WHERE B.Source_lsuam_current_term__c IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_CT_Update'


-- Source_RFI Case Update
DROP TABLE Case_RFI_Lookup_Update
SELECT A.ID,C.Id AS Source_RFI_Case__c
INTO Case_RFI_Lookup_Update
FROM edaprod.dbo.hed__Affiliation__c AFF
INNER JOIN
[Case] A
ON A.Legacy_ID__c = AFF.Id
LEFT JOIN [edaprod].[dbo].Interaction__c I
ON I.Affiliation_ID__c = AFF.Id
LEFT JOIN [Case] C
ON 'I-'+I.Id = C.Legacy_ID__c
WHERE C.ID IS NOT NULL

select * from Case_RFI_Lookup_Update

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_RFI_Lookup_Update'

select * from Case_RFI_Lookup_Update_Result
where error = 'Operation Successful.'

-- Related Retention Case Lookup
--DROP TABLE Case_RelatedRetention_Lookup_Update
SELECT A.ID as Related_Retention_Case__c,C.Id 
INTO Case_RelatedRetention_Lookup_Update
FROM edaprod.dbo.hed__Affiliation__c AFF
INNER JOIN
[Case] A
ON A.Legacy_ID__c = AFF.Id
LEFT JOIN [edaprod].[dbo].Interaction__c I
ON I.Affiliation_ID__c = AFF.Id
LEFT JOIN [Case] C
ON 'I-'+I.Id = C.Legacy_ID__c
WHERE C.ID IS NOT NULL

SELECT * FROM Case_RelatedRetention_Lookup_Update

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_RelatedRetention_Lookup_Update'


-- Related Recruitment Case
--DROP TABLE Case_Aff_Recruitment_Lookup_Update
SELECT A.ID,C.Id AS Related_Recruitment_Case__c
INTO Case_Aff_Recruitment_Lookup_Update
FROM edaprod.dbo.hed__Affiliation__c AFF
INNER JOIN
[Case] A
ON A.Legacy_ID__c = AFF.Id
LEFT JOIN [edaprod].[dbo].Opportunity O
ON O.Affiliation__c = AFF.Id
LEFT JOIN [Case] C
ON O.Id = C.Legacy_ID__c
WHERE C.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Aff_Recruitment_Lookup_Update'

select * from Case_Aff_Recruitment_Lookup_Update_Result
where error = 'Operation Successful.'


