
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

SELECT * FROM Case_Opp_Recruitment_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','Case_Opp_Recruitment_LOAD_4'

SELECT * FROM Case_Opp_Recruitment_LOAD_5

--DROP TABLE Case_Opp_Recruitment_LOAD_4
SELECT *
--INTO Case_Opp_Recruitment_LOAD_5
FROM Case_Opp_Recruitment_LOAD_4_Result where Error <> 'Operation Successful.'
ORDER BY AccountId

UPDATE Case_Opp_Recruitment_LOAD_4
SET 	Last_Name__c = left(Last_Name__c,50)
WHERE Error  LIKE '%Last%'

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
FROM Case_Opp_Recruitment_LOAD_4_Result
WHERE Error = 'Operation Successful.'

select * from [edcuat].[dbo].[Case_Lookup]
where legacy_ID__c = '0063n000010xqgzAAA'


--====================================================================
--POPULATING LOOKUP FIELDS - RFI Case
--====================================================================

-- Related Recruitment Case Lookup

DROP TABLE Case_Recruitment_Lookup_Update
SELECT A.ID,C.ID AS Related_Recruitment_Case__c
INTO Case_Recruitment_Lookup_Update
FROM [Case] A
LEFT JOIN [edaprod].[dbo].Interaction__c I
ON 'I-'+I.Id = A.Legacy_ID__c
LEFT JOIN [Case] C
ON I.Opportunity__c = C.Legacy_ID__c
WHERE C.ID IS NOT NULL

select * from Case_Recruitment_Lookup_Update

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Recruitment_Lookup_Update'

-- Related Recruitment Case Lookup
DROP TABLE Case_Contact_Info_Update
SELECT C.ID,A.First_Name__c,A.Last_Name__c,A.ContactEmail,A.Email__c,A.ContactPhone,A.ContactPhone as Phone__c
INTO Case_Contact_Info_Update
FROM [Case] C
INNER JOIN
[edcuat].[dbo].[11_Case_Opp_Recruitment] A
ON C.Legacy_ID__c = A.Legacy_ID__c



EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Contact_Info_Update'


--drop table Case_Sub_Status_Update
SELECT C.ID,'Fallout' as Sub_Status__c,'Fallout' as sub_stage__c
into Case_Sub_Status_Update
FROM [dbo].[11_Case_Opp_Recruitment] A
INNER JOIN [Case] C
ON A.Legacy_ID__c = c.Legacy_ID__c
WHERE A.Status = 'Fallout'

select * from Case_Sub_Status_Update

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Sub_Status_Update'

-- Related Opportunity Lookup

DROP TABLE Case_RFI_Related_Opp_Lookup_Update
SELECT A.ID,Op.Id as Related_Opportunity__c
INTO Case_RFI_Related_Opp_Lookup_Update
FROM [Case] A
INNER JOIN [edaprod].[dbo].Interaction__c I
ON 'I-'+I.Id = A.Legacy_ID__c
LEFT JOIN [edaprod].[dbo].[Opportunity] O
ON I.Opportunity__c = O.Id
LEFT JOIN [edcuat].[dbo].[Opportunity] Op
ON Op.Legacy_ID__c = O.Id
WHERE O.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','edcdatadev','Case_RFI_Related_Opp_Lookup_Update'
