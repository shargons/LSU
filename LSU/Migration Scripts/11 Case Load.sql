
USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_LOAD];
--GO
SELECT *
INTO [edcdatadev].dbo.Case_LOAD
FROM [edcdatadev].[dbo].[11_EDA_Cases] C
ORDER BY ContactId

SELECT * FROM Case_LOAD

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM Case_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','EDCDATADEV','Case_LOAD'

SELECT * 
--INTO Case_LOAD_2
FROM Case_LOAD_Result where Error <> 'Operation Successful.'
ORDER BY ContactId

select DISTINCT  Error from Case_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Case
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Case_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Case_DELETE'

INSERT INTO Case_DELETE(Id) SELECT Id FROM Case_LOAD_Result WHERE Error = 'Operation Successful.'

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
INSERT INTO [edcdatadev].[dbo].[Case_Lookup]
SELECT
 ID
,EDACASEID__c AS legacy_ID__c
FROM Case_LOAD_Result
WHERE Error = 'Operation Successful.'


--====================================================================
-- UPDATE LOOKUPS- Case
--====================================================================

--DROP TABLE Case_AcadInterest_Update
SELECT C.ID,LP.ID AS academic_interest__c
INTO Case_AcadInterest_Update
FROM [edcdatadev].[dbo].[Case_Lookup] C
INNER JOIN [edcdatadev].[dbo].[11_EDA_Cases] E
ON C.legacy_ID__c = E.EDACASEID__c
LEFT JOIN [edaprod].dbo.hed__Affiliation__c A
ON E.Source_academic_interest__c = A.hed__Account__c
AND A.hed__Contact__c = E.Source_contactid
LEFT JOIN [edcdatadev].[dbo].LearnerProgram_Lookup LP
ON LP.LSU_Affiliation__c = A.Id 
WHERE LP.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCDATADEV','Case_AcadInterest_Update'

SELECT * FROM Case_AcadInterest_Update

