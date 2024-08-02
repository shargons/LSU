
USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Opportunity_LOAD];
--GO
SELECT *
INTO [edcdatadev].[dbo].[Opportunity_LOAD]
FROM [edcdatadev].[dbo].[11_EDA_Opportunity] C
ORDER BY AccountId

SELECT count(*),RecordtypeId FROM [edcdatadev].[dbo].[Opportunity_LOAD]
GROUP BY RecordtypeId

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE [edcdatadev].[dbo].[Opportunity_LOAD]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM [edcdatadev].[dbo].[Opportunity_LOAD]

EXEC SF_TableLoader 'Insert:BULKAPI','edcdatadev','Opportunity_LOAD'

SELECT * [dbo].[16_EDA_Financial_Aid_Record]
--INTO Opportunity_LOAD_4
FROM Opportunity_LOAD_Result where Error <> 'Operation Successful.'
AND Error LIKE '%DUPLICATE_VALUE%'
ORDER BY AccountId

select DISTINCT  Error from Opportunity_LOAD_Result



--====================================================================
--ERROR RESOLUTION - Case
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Opportunity_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Opportunity_DELETE'

INSERT INTO Opportunity_DELETE(Id) SELECT Id FROM Opportunity_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Opportunity_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Case
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[Opportunity_Lookup];
--GO

INSERT INTO [edcdatadev].[dbo].[Opportunity_Lookup]
SELECT
 ID
,Legacy_ID__c
--INTO [edcdatadev].[dbo].[Opportunity_Lookup]
FROM Opportunity_LOAD_4_Result
WHERE Error = 'Operation Successful.'



