USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW -  Email Message
--====================================================================


--DROP TABLE IF EXISTS [dbo].[EmailMessage_Load];
--GO
SELECT *
INTO [edcdatadev].dbo.EmailMessage_Load_5
FROM [edcdatadev].[dbo].[24_EDA_EmailMessages] C
ORDER BY RelatedtoId



/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE EmailMessage_Load_5
ALTER COLUMN ID NVARCHAR(18)


SELECT * FROM EmailMessage_Load



--====================================================================
--INSERTING DATA USING DBAMP -   Email Message
--====================================================================

EXEC SF_TableLoader 'Insert:BULKAPI','edcdatadev','EmailMessage_Load_5'

SELECT *
--INTO EmailMessage_Load_6
FROM EmailMessage_Load_5_Result where Error <> 'Operation Successful.'
AND Error like '%Unable%'
ORDER BY RelatedtoId


select DISTINCT  Error from EmailMessage_Load_Result

--====================================================================
--ERROR RESOLUTION -   Email Message
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE EmailMessage
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'EmailMessage_DELETE'

INSERT INTO EmailMessage_DELETE(Id) SELECT Id FROM EmailMessage_Load_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'EmailMessage_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES-   Enrollment
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[CourseOfferingParticipant_Lookup];
--GO


INSERT INTO EmailMessage_Lookup
SELECT
 ID
,EDAEMAILMSGID__c as Legacy_ID__C 
--INTO EmailMessage_Lookup
FROM EmailMessage_Load_4_Result
WHERE Error = 'Operation Successful.'

SELECT * FROM EmailMessage_Lookup
where Legacy_Id__c = '02s3n00001fYgZJAA0'


SELECT * FROM [dbo].[24_EDA_EmailMessages]
where EDAEMAILMSGID__c = '02s3n00001fYgZJAA0'


