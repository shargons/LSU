
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Application Decision
--====================================================================


--DROP TABLE IF EXISTS [dbo].[ApplicationDecision_LOAD];
--GO
SELECT *
INTO [EDUCPROD].dbo.ApplicationDecision_LOAD
FROM [EDUCPROD].[dbo].[13C_ApplicationDecision] C



/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE ApplicationDecision_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Application Decision
--====================================================================

SELECT * FROM ApplicationDecision_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','ApplicationDecision_LOAD'



SELECT * 
--INTO IndividualApplication_LOAD_2
FROM ApplicationDecision_LOAD_Result where Error <> 'Operation Successful.'


select DISTINCT  Error from ApplicationDecision_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Application Decision
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE ApplicationDecision_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'ApplicationDecision_DELETE'

INSERT INTO IndividualApplication_DELETE(Id) SELECT Id FROM ApplicationDecision_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'ApplicationDecision_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Application Decision
--====================================================================


--DROP TABLE IF EXISTS [dbo].[ApplicationDecision_Lookup];
--GO

SELECT
 ID
,UpsertKey__c AS legacy_ID__c
INTO [EDUCPROD].[dbo].[ApplicationDecision_Lookup]
FROM ApplicationDecision_LOAD_Result
WHERE Error = 'Operation Successful.'



SELECT * FROM [ApplicationDecision_Lookup]


