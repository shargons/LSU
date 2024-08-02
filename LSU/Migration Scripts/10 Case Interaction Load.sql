
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_Interaction_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.Case_Interaction_LOAD
FROM [edcuat].[dbo].[10_EDA_Interactions] C
ORDER BY ContactId

SELECT Count(*),RecordtypeId FROM Case_Interaction_LOAD
gROUP bY RecordtypeId


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_Interaction_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM Case_Interaction_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','Case_Interaction_LOAD_5'

--DROP TABLE Case_Interaction_LOAD_5
SELECT * 
----INTO Case_Interaction_LOAD_5
FROM Case_Interaction_LOAD_4_Result where Error <> 'Operation Successful.'
ORDER BY AccountId,ContactId

UPDATE A
SET ContactEmail = null
FROM Case_Interaction_LOAD_5 A


select * from Case_Interaction_LOAD_2

SELECT * 
FROM Case_Interaction_LOAD_Result where Error = 'Operation Successful.'

select DISTINCT  Error from Case_Interaction_LOAD_Result



--====================================================================
--ERROR RESOLUTION - Case
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Case_Interaction_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Case_Interaction_DELETE'

INSERT INTO Case_Interaction_DELETE(Id) SELECT Id FROM Case_Interaction_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Case_Interaction_DELETE'


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
--INTO [edcuat].[dbo].[Case_Lookup]
FROM Case_Interaction_LOAD_5_Result
WHERE Error = 'Operation Successful.'

--select count(B.Legacy_ID__c)
--from [edcuat].[dbo].[Case_Lookup] A
--LEFT JOIN
--[edcuat].[dbo].[12_EDA_Interactions] B
--ON A.legacy_ID__c = B.legacy_ID__c
--where A.legacy_ID__c like '%I-%'
--AND A.ID IS NOT NULL

--SELECT B.ID,I.RecordTypeId
----into Case_Recordtype_Update
--FROM [edcuat].[dbo].[12_EDA_Interactions] I
--INNER JOIN
--[edcuat].[dbo].[Case_Lookup] B
--ON I.legacy_ID__c = B.legacy_ID__c

--EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Recordtype_Lookup'

--SELECT * FROM Case_Recordtype_Lookup_Result
--WHERE Error <> 'Operation Successful.'

SELECT B.ID,I.lsu_lead_source__c
into Case_LeadSource_Update
FROM [edcuat].[dbo].[12_EDA_Interactions] I
INNER JOIN
[edcuat].[dbo].[Case_Lookup] B
ON I.legacy_ID__c = B.legacy_ID__c
WHERE I.lsu_lead_source__c IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_LeadSource_Update'


