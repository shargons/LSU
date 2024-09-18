USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - CourseOfferingParticipant
--====================================================================


--DROP TABLE IF EXISTS [dbo].[CourseOfferingParticipant_CC_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.CourseOfferingParticipant_CC_LOAD
FROM [edcuat].[dbo].[22_EDA_CourseEnrollment] C
ORDER BY ParticipantContactId



/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE CourseOfferingParticipant_CC_LOAD
ALTER COLUMN ID NVARCHAR(18)


SELECT * FROM CourseOfferingParticipant_CC_LOAD



--====================================================================
--INSERTING DATA USING DBAMP -   CourseOfferingParticipant
--====================================================================

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','CourseOfferingParticipant_CC_LOAD_8'

--DROP TABLE CourseOfferingParticipant_CC_LOAD_2
SELECT *
--INTO CourseOfferingParticipant_CC_LOAD_8
FROM CourseOfferingParticipant_CC_LOAD_8_Result where Error <> 'Operation Successful.'


select DISTINCT  Error from CourseOfferingParticipant_CC_LOAD_Result

--====================================================================
--ERROR RESOLUTION -   Enrollment
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE CourseOfferingParticipant_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'CourseOfferingParticipant_DELETE'

INSERT INTO CourseOfferingParticipant_DELETE(Id) SELECT Id FROM CourseOfferingParticipant_CC_LOAD_2_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'CourseOfferingParticipant_DELETE'

select * from CourseOfferingParticipant_DELETE_Result

--====================================================================
--POPULATING LOOKUP TABLES-   Enrollment
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[CourseOfferingParticipant_CE_Lookup];
--GO

INSERT INTO CourseOfferingParticipant_CE_Lookup
SELECT
 ID
,Legacy_ID__C 
--INTO CourseOfferingParticipant_CE_Lookup
FROM CourseOfferingParticipant_CC_LOAD_7_Result
WHERE Error = 'Operation Successful.'


select * from CourseOfferingParticipant_CE_Lookup
