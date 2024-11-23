USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW -  Subscription Members
--====================================================================


--DROP TABLE IF EXISTS [dbo].[cfg_Subscription_Member__c_Load];
--GO
SELECT *
INTO [EDUCPROD].dbo.cfg_Subscription_Member__c_Load
FROM [EDUCPROD].[dbo].[26_EDA_SubscriptionMembers] C


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE cfg_Subscription_Member__c_Load
ALTER COLUMN ID NVARCHAR(18)


SELECT A.Id,B.Legacy_Id__c FROM cfg_Subscription_Member__c A
INNER JOIN
[dbo].[26_EDA_SubscriptionMembers] B
ON A.cfg_contact__c = B.cfg_contact__c


select * from cfg_Subscription_Member__c_Load


--====================================================================
--INSERTING DATA USING DBAMP -    Subscription Members
--====================================================================

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','cfg_Subscription_Member__c_Load'

SELECT *
--INTO cfg_Subscription_Member__c_Load_2
FROM cfg_Subscription_Member__c_Load_Result where Error <> 'Operation Successful.'


select DISTINCT  Error from cfg_Subscription__c_Load_Result

--====================================================================
--ERROR RESOLUTION -    Subscription Members
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE cfg_Subscription_Member__c_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'cfg_Subscription_Member__c_DELETE'

INSERT INTO cfg_Subscription_Member__c_DELETE(Id) SELECT Id FROM cfg_Subscription_Member__c_Load_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'cfg_Subscription_Member__c_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES-    Subscription Members
--====================================================================

--DROP TABLE Subscription_Member_Lookup
SELECT
 ID
,Legacy_ID__C 
INTO Subscription_Member_Lookup
FROM cfg_Subscription_Member__c_Load_Result
WHERE Error = 'Operation Successful.'



