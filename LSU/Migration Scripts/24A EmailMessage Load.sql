USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW -  EmailMessage
--====================================================================


--DROP TABLE IF EXISTS [dbo].[EmailMessage_Load];
--GO
SELECT *
INTO [EDUCPROD].dbo.EmailMessage_Load
FROM [EDUCPROD].[dbo].[24_EDA_EmailMessages] C
ORDER BY RelatedtoId



/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE EmailMessage_Load
ALTER COLUMN ID NVARCHAR(18)


SELECT * FROM EmailMessage_Load



--====================================================================
--INSERTING DATA USING DBAMP -   EmailMessage
--====================================================================

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','EmailMessage_Load'

--DROP TABLE EmailMessage_Load_2
SELECT *
--INTO EmailMessage_Load_2
FROM EmailMessage_Load_Result where Error <> 'Operation Successful.'
ORDER BY RelatedtoId


select DISTINCT  Error from EmailMessage_Load_Result

--====================================================================
--ERROR RESOLUTION -   Subscriptions
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE EmailMessage_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'EmailMessage_DELETE'

INSERT INTO EmailMessage_DELETE(Id) SELECT Id FROM EmailMessage_Load_5_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'EmailMessage_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES-   Enrollment
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[EmailMessage_Lookup];
--GO


SELECT
 ID
,EDAEMAILMSGID__c as Legacy_ID__C 
INTO EmailMessage_Lookup
FROM EmailMessage_Load_Result
WHERE Error = 'Operation Successful.'

SELECT * FROM EmailMessage_Lookup
where Legacy_Id__c = '02s3n00001fC9zLAAS'


SELECT * FROM [dbo].[24_EDA_EmailMessages]
where EDAEMAILMSGID__c = '02s3n00001RAPLAAA5'


