USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW -  EmailMessageRelation
--====================================================================


--DROP TABLE IF EXISTS [dbo].[EmailMessageRelation_Load];
--GO
SELECT *
INTO [edcuat].dbo.EmailMessageRelation_Load
FROM [edcuat].[dbo].[33_EDA_EmailMessageRelation] C
ORDER BY [RelationId]



/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE EmailMessageRelation_Load
ALTER COLUMN ID NVARCHAR(18)


SELECT * FROM EmailMessageRelation_Load



--====================================================================
--INSERTING DATA USING DBAMP -   EmailMessageRelation
--====================================================================

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','EmailMessageRelation_Load'

--DROP TABLE EmailMessageRelation_Load_2
SELECT *
--INTO EmailMessageRelation_Load_2
FROM EmailMessageRelation_Load_Result where Error <> 'Operation Successful.'
ORDER BY RelatedtoId


select DISTINCT  Error from EmailMessageRelation_Load_Result

--====================================================================
--ERROR RESOLUTION -   Subscriptions
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE EmailMessageRelation_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'EmailMessageRelation_DELETE'

INSERT INTO EmailMessageRelation_DELETE(Id) SELECT Id FROM EmailMessageRelation_Load_5_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'EmailMessageRelation_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES-   Enrollment
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[EmailMessageRelation_Lookup];
--GO


SELECT
 ID
,EDAEMAILMSGID__c as Legacy_ID__C 
INTO EmailMessageRelation_Lookup
FROM EmailMessageRelation_Load_Result
WHERE Error = 'Operation Successful.'

SELECT * FROM EmailMessageRelation_Lookup
where Legacy_Id__c = '02s3n00001fC9zLAAS'


SELECT * FROM [dbo].[24_EDA_EmailMessageRelations]
where EDAEMAILMSGID__c = '02s3n00001RAPLAAA5'


