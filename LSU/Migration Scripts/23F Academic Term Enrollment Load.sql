
USE edcuat;

--====================================================================
--	INSERTING ACADEMIC TERMS FROM ENROLLMENTS  - Academic Terms
--====================================================================
--DROP TABLE IF EXISTS [dbo].[AcademicTerm_Enr_Insert];
--GO

SELECT DISTINCT 
NULL AS ID
,Term__c AS Name
,Term__c AS Term_ID__c
INTO AcademicTerm_Enr_Insert_2
FROM [dbo].[23F_AcademicTermEnrollments]
WHERE AcademicTermID IS NULL
AND Term__c IS NOT NULL
--AND Term__c = '20251P'

/******* Check Load table *********/
SELECT * FROM [edcuat].dbo.AcademicTerm_Enr_Insert


--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE AcademicTerm_Enr_Insert_2
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','AcademicTerm_Enr_Insert_2'


--====================================================================
--POPULATING LOOKUP TABLE - Academic Term
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[AcademicTerm_Enr_Lookup];
--GO
INSERT INTO [edcuat].[dbo].[AcademicTerm_Enr_Lookup]
SELECT
 ID
,Name
--INTO [edcuat].[dbo].[AcademicTerm_Enr_Lookup]
FROM AcademicTerm_Enr_Insert_2_Result
WHERE Error = 'Operation Successful.'

/***** Replicate AcademicTerm before running the view **********/
EXEC SF_Replicate 'EDCUAT','AcademicTerm','pkchunk,batchsize(50000)'



--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Academic Term Enrollment 
--====================================================================
--DROP TABLE IF EXISTS [dbo].[AcademicTermEnrollment_LOAD];
--GO
SELECT *
INTO [edcuat].[dbo].AcademicTermEnrollment_LOAD
FROM [edcuat].[dbo].[23F_AcademicTermEnrollments] C



/******* Check Load table *********/
SELECT * FROM [edcuat].dbo.AcademicTermEnrollment_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - AcademicTermEnrollment
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE AcademicTermEnrollment_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','AcademicTermEnrollment_LOAD_13'

--DROP TABLE AcademicTermEnrollment_Load_14
SELECT * 
INTO AcademicTermEnrollment_Load_14
FROM AcademicTermEnrollment_Load_13_Result
WHERE Error <> 'Operation Successful.'
AND Error not like '%DUPLICATE%'


--====================================================================
--ERROR RESOLUTION - AcademicTermEnrollment
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE AcademicTermEnrollment_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'AcademicTermEnrollment_DELETE'

INSERT INTO AcademicTermEnrollment_DELETE(Id) SELECT Id FROM AcademicTermEnrollment WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'AcademicTermEnrollment_DELETE_2'

SELECT * 
INTO AcademicTermEnrollment_Delete_2
FROM AcademicTermEnrollment_Delete_Result where Error <> 'Operation Successful.'

--====================================================================
--POPULATING LOOOKUP TABLES- AcademicTermEnrollment
--====================================================================

/***** Replicate AcademicTerm before running the view **********/
EXEC SF_Replicate 'EDCUAT','AcademicTermEnrollment','pkchunk,batchsize(50000)'

SELECT * FROM AcademicTermEnrollment

--====================================================================
--UPDATE CoursefferingParticipant- AcademicTermEnrollment Lookup
--====================================================================
--DROP TABLE CourseOfferingParticipant_ATE_Update
SELECT DISTINCT A.UpsertKey__c as ID,B.ID AS AcademicTermEnrollmentID,Status as ParticipationStatus
INTO CourseOfferingParticipant_ATE_Update
FROM [dbo].[23F_AcademicTermEnrollments] A
INNER JOIN
AcademicTermEnrollment B
ON A.UpsertKey__c = B.UpsertKey__c



EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','CourseOfferingParticipant_ATE_Update_2'

select * from CourseOfferingParticipant_ATE_Update_Result
WHERE Error <> 'Operation Successful.'

SELECT * 
INTO CourseOfferingParticipant_ATE_Update_2
FROM CourseOfferingParticipant_ATE_Update_Result
WHERE Error <> 'Operation Successful.'

UPDATE CourseOfferingParticipant_ATE_Update_2
SET ParticipationStatus = 'Enrolled'