
USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_Interaction_LOAD];
--GO
SELECT *
INTO [edcdatadev].dbo.Case_Interaction_LOAD
FROM [edcdatadev].[dbo].[12_EDA_Interactions] C
ORDER BY ContactId

SELECT * FROM Case_Interaction_LOAD

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_Interaction_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM Case_Interaction_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','EDCDATADEV','Case_Interaction_LOAD_12'

SELECT * 
--INTO Case_Interaction_LOAD_12
FROM Case_Interaction_LOAD_12_Result where Error <> 'Operation Successful.'
AND Error NOT LIKE '%DUPLICATE%'
ORDER BY AccountId,ContactId

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
--DROP TABLE IF EXISTS [dbo].[Case_Lookup];
--GO

ALTER TABLE [edcdatadev].[dbo].[Case_Lookup]
ALTER COLUMN Legacy_ID__c NVARCHAR(25)

INSERT INTO [edcdatadev].[dbo].[Case_Lookup]
SELECT
 ID
,legacy_ID__c
FROM Case_Interaction_LOAD_12_Result
WHERE Error = 'Operation Successful.'

select count(B.Legacy_ID__c)
from [edcdatadev].[dbo].[Case_Lookup] A
LEFT JOIN
[edcdatadev].[dbo].[12_EDA_Interactions] B
ON A.legacy_ID__c = B.legacy_ID__c
where A.legacy_ID__c like '%I-%'
AND A.ID IS NOT NULL


