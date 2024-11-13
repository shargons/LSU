USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW -  EmailMessageRelation
--====================================================================


--DROP TABLE IF EXISTS [dbo].[EmailMessage_Relation_Update];
--GO
SELECT B.Id,A.[RelationId],A.[RelationType]
INTO EmailMessageRelation_Update
FROM  [33_EDA_EmailMessageRelation] A
INNER JOIN EmailMessageRelation B
ON A.EmailMessageId = B.EmailMessageID 
AND A.RelationAddress = B.RelationAddress




--====================================================================
--INSERTING DATA USING DBAMP -   EmailMessageRelation
--====================================================================

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','EmailMessageRelation_Update'

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


