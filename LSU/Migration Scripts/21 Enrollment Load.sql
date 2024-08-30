USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW -  Enrollment
--====================================================================


--DROP TABLE IF EXISTS [dbo].[CourseOfferingParticipant_Enr_LOAD];
--GO
SELECT *
INTO [edcdatadev].dbo.CourseOfferingParticipant_Enr_LOAD
FROM [edcdatadev].[dbo].[21_EDA_Enrollments] C
WHERE ParticipantContactId IS NOT NULL
ORDER BY Opportunity,ParticipantContactId



/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE CourseOfferingParticipant_Enr_LOAD
ALTER COLUMN ID NVARCHAR(18)


SELECT * FROM CourseOfferingParticipant_Enr_LOAD



--====================================================================
--INSERTING DATA USING DBAMP -   Enrollment
--====================================================================

EXEC SF_TableLoader 'Insert:BULKAPI','edcdatadev','CourseOfferingParticipant_Enr_LOAD'

SELECT *
--INTO CourseOfferingParticipant_Enr_LOAD_2
FROM CourseOfferingParticipant_Enr_LOAD_Result where Error <> 'Operation Successful.'

ORDER BY Opportunity,ParticipantContactId

select DISTINCT  Error from CourseOfferingParticipant_Enr_LOAD_Result

--====================================================================
--ERROR RESOLUTION -   Enrollment
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE CourseOfferingParticipant_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'CourseOfferingParticipant_DELETE'

INSERT INTO CourseOfferingParticipant_DELETE(Id) SELECT Id FROM CourseOfferingParticipant_Enr_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'CourseOfferingParticipant_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES-   Enrollment
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[CourseOfferingParticipant_Lookup];
--GO

SELECT
 ID
,Legacy_ID__C 
INTO CourseOfferingParticipant_Lookup
FROM CourseOfferingParticipant_Enr_LOAD_Result
WHERE Error = 'Operation Successful.'


