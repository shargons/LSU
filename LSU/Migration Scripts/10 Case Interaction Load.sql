
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_Interaction_LOAD];
--GO
SELECT C.*
INTO [EDUCPROD].dbo.Case_Interaction_LOAD
FROM [EDUCPROD].[dbo].[10_EDA_Interactions] C
ORDER BY ContactId

SELECT Count(*),RecordtypeId FROM Case_Interaction_LOAD
gROUP bY RecordtypeId

ALTER TABLE [Case_Interaction_LOAD]
ALTER COLUMN Lead__c NVARCHAR(18) 

/******* Update Lead records *********/
UPDATE C
SET C.Lead__c = L.Id
FROM [EDUCPROD].[dbo].[Case_Interaction_LOAD] C
INNER JOIN
[EDUCPROD].[dbo].[Lead] L
ON C.Source_Contact = l.Legacy_Id__c

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_Interaction_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM Case_Interaction_LOAD_3

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Case_Interaction_LOAD_5'

--DROP TABLE Case_Interaction_LOAD_4
SELECT * 
INTO Case_Interaction_LOAD_5
FROM Case_Interaction_LOAD_4_Result where Error <> 'Operation Successful.'
ORDER BY AccountId,ContactId

UPDATE A
SET Last_Name__c = LEFT(Last_Name__c,50)
FROM Case_Interaction_LOAD_5 A
WHERE Error like '%Last Name%'

update a
set Status = 'Attempting'
FROM Case_Interaction_LOAD_3 a
WHERE a.status is null


select * from Case_Interaction_LOAD_3

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

ALTER TABLE [EDUCPROD].[dbo].[Case_Lookup]
ALTER COLUMN Legacy_ID__c NVARCHAR(25)

INSERT INTO [EDUCPROD].[dbo].[Case_RFI_Lookup]
SELECT
 ID
,legacy_ID__c
--INTO [EDUCPROD].[dbo].[Case_RFI_Lookup]
FROM Case_Interaction_LOAD_5_Result
WHERE Error = 'Operation Successful.'


