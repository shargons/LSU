USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW -  Subscriptions
--====================================================================


--DROP TABLE IF EXISTS [dbo].[cfg_Subscription__c_Load];
--GO
SELECT *
INTO [edcdatadev].dbo.cfg_Subscription__c_Load
FROM [edcdatadev].[dbo].[25_EDA_Subscription] C


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE cfg_Subscription__c_Load
ALTER COLUMN ID NVARCHAR(18)


SELECT * FROM cfg_Subscription__c_Load



--====================================================================
--INSERTING DATA USING DBAMP -   Subscriptions
--====================================================================

EXEC SF_TableLoader 'Upsert:BULKAPI','edcdatadev','cfg_Subscription__c_Load'

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

INSERT INTO cfg_Subscription__c_DELETE(Id) SELECT Id FROM cfg_Subscription__c_Load_5_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'cfg_Subscription__c_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES-   Enrollment
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[CourseOfferingParticipant_Lookup];
--GO



SELECT
 ID
,Legacy_ID__C 
INTO Subscription_Lookup
FROM cfg_Subscription__c_Load_Result
WHERE Error = 'Operation Successful.'


SELECT * FROM Subscription_Lookup

