
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

EXEC SF_TableLoader 'Insert:BULKAPI','EDCDATADEV','Case_Interaction_LOAD'

SELECT * 
--INTO Case_LOAD_2
FROM Case_Interaction_LOAD_Result where Error <> 'Operation Successful.'
ORDER BY ContactId

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
INSERT INTO [edcdatadev].[dbo].[Case_Lookup]
SELECT
 ID
,legacy_ID__c
FROM Case_Interaction_LOAD_Result
WHERE Error = 'Operation Successful.'



