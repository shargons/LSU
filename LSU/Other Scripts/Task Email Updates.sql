USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Task
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Task_Email_LOAD];
--GO
SELECT *
INTO [EDUCPROD].[dbo].[Task_Email_LOAD]
FROM [EDUCPROD].[dbo].[32_EDA_Tasks] C


SELECT * FROM [Task_Email_LOAD]

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE [Task_Email_LOAD]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Task
--====================================================================

SELECT * FROM [Task_LOAD]

Exec SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Task_Email_LOAD_5'


SELECT * 
--INTO Task_Email_LOAD_5
FROM Task_Email_LOAD_4_Result where Error <> 'Operation Successful.'

UPDATE Task_LOAD
SET FirstPublishLocationId = NULL


SELECT * 
--INTO Task_LOAD_2
FROM Task_LOAD_Result where Error = 'Operation Successful.'


--====================================================================
--ERROR RESOLUTION - Task
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Task_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Task_DELETE'

EXEC SF_Replicate 'EDUCPROD','Task','pkchunk,batchsize(50000)'

INSERT INTO Task_DELETE(Id) SELECT Id FROM Task_LOAD_Result where Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Task_DELETE'


--====================================================================
--POPULATING LOOKUP TABLES- Task
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Task_Lookup];
--GO

SELECT
 ID
,legacy_ID__c
INTO Task_Lookup
FROM Task_LOAD_Result
WHERE Error = 'Operation Successful.'


select * from Task_Lookup

