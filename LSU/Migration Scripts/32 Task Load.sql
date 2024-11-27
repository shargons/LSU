USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Task
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Task_LOAD];
--GO
SELECT *
INTO [EDUCPROD].[dbo].[Task_LOAD]
FROM [EDUCPROD].[dbo].[32_EDA_Tasks] C


SELECT * FROM [Task_LOAD]

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE [Task_LOAD]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Task
--====================================================================

SELECT * FROM [Task_LOAD]

Exec SF_TableLoader 'Upsert:SOAP,batchsize(1)','EDUCPROD','Task_Recur_Load','Legacy_Id__c'

--DROP TABLE Task_LOAD_2
SELECT * 
--INTO Task_LOAD_6
FROM Task_LOAD_6_RESULT where Error <> 'Operation Successful.'

UPDATE Task_LOAD
SET FirstPublishLocationId = NULL


SELECT * 
--INTO Task_LOAD_2
FROM Task_Recur_Load_Result where Error <> 'Operation Successful.'

SELECT T.*,T2.RecurrenceDayOfMonth,T2.RecurrenceDayOfWeekMask,T2.RecurrenceEndDateOnly,T2.RecurrenceInstance
,T2.RecurrenceInterval,T2.RecurrenceMonthOfYear,T2.RecurrenceRegeneratedType,T2.RecurrenceStartDateOnly,T2.RecurrenceTimeZoneSidKey,T2.RecurrenceType
INTO Task_Recur_Load
FROM Task_LOAD_6 T
INNER JOIN
[edaprod].[dbo].[Task] T2
ON T.Legacy_Id__c = T2.ID


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

