USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW -  Subscriptions
--====================================================================


--DROP TABLE IF EXISTS [dbo].[cfg_Subscription__c_Load];
--GO
SELECT *
INTO [EDUCPROD].dbo.cfg_Subscription__c_Load
FROM [EDUCPROD].[dbo].[25_EDA_Subscription] C


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE cfg_Subscription__c_Load
ALTER COLUMN ID NVARCHAR(18)


SELECT * FROM cfg_Subscription__c_Load



--====================================================================
--INSERTING DATA USING DBAMP -   Subscriptions
--====================================================================

EXEC SF_TableLoader 'Upsert:BULKAPI','EDUCPROD','cfg_Subscription__c_Load','Legacy_ID__c'

SELECT *
--INTO cfg_Subscription__c_Load_2
FROM cfg_Subscription__c_Load_Result where Error <> 'Operation Successful.'


select DISTINCT  Error from cfg_Subscription__c_Load_Result

--====================================================================
--ERROR RESOLUTION -   Subscriptions
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE cfg_Subscription__c_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'cfg_Subscription__c_DELETE'

INSERT INTO cfg_Subscription__c_DELETE(Id) SELECT Id FROM cfg_Subscription__c_Load_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'cfg_Subscription__c_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES-   Enrollment
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[Subscription_Lookup];
--GO



SELECT
 ID
,Legacy_ID__C 
INTO Subscription_Lookup
FROM cfg_Subscription__c_Load_Result
WHERE Error = 'Operation Successful.'



