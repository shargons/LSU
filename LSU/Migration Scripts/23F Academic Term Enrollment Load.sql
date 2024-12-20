
USE EDUCPROD;

-- REPLICATE ATE for eliminating duplicates while migration
EXEC SF_Replicate 'EDUCPROD','AcademicTermEnrollment','pkchunk,batchsize(50000)'

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Academic Term Enrollment 
--====================================================================
--DROP TABLE IF EXISTS [dbo].[AcademicTermEnrollment_LOAD];
--GO
SELECT A.*
INTO [EDUCPROD].[dbo].AcademicTermEnrollment_LOAD
FROM [EDUCPROD].[dbo].[23F_AcademicTermEnrollments] A
LEFT JOIN
AcademicTermEnrollment B
ON A.AcademicTermId = B.AcademicTermId
AND A.LearnerAccountId = B.LearnerAccountId
WHERE 
B.ID IS NULL




/******* Check Load table *********/
SELECT DISTINCT Term__c,Stand_Term_Code 
FROM [EDUCPROD].dbo.AcademicTermEnrollment_LOAD
WHERE AcademicTermId IS NULL

--====================================================================
--INSERTING DATA USING DBAMP - AcademicTermEnrollment
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE AcademicTermEnrollment_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','AcademicTermEnrollment_LOAD_13'

--DROP TABLE AcademicTermEnrollment_Load_14
SELECT DISTINCT Term__c
--INTO AcademicTermEnrollment_Load_13
FROM AcademicTermEnrollment_Load_13_Result
WHERE Error <> 'Operation Successful.'
and eRROR LIKE '%rEQUIRED%'

UPDATE A
SET A.AcademicTermId = B.AcademicTermId
FROM AcademicTermEnrollment_Load_12 A
INNER JOIN
[EDUCPROD].[dbo].[23F_AcademicTermEnrollments] B
ON A.UpsertKey__c = B.UpsertKey__c


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

INSERT INTO AcademicTermEnrollment_Lookup

SELECT ID,UpsertKey__c
--INTO AcademicTermEnrollment_Lookup
FROM AcademicTermEnrollment_Load_5_Result
WHERE Error = 'Operation Successful.'


--====================================================================
--UPDATE CoursefferingParticipant- AcademicTermEnrollment Lookup
--====================================================================
--DROP TABLE CourseOfferingParticipant_ATE_Update
SELECT DISTINCT A.UpsertKey__c as ID,
B.ID AS AcademicTermEnrollmentID,
IIF(A.EnrollmentStatus = 'Active' OR A.EnrollmentStatus = 'Registered','Enrolled',A.EnrollmentStatus)  as ParticipationStatus
INTO CourseOfferingParticipant_ATE_Update
FROM [dbo].[23F_AcademicTermEnrollments] A
INNER JOIN
AcademicTermEnrollment B
ON A.UpsertKey__c = B.UpsertKey__c



EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','CourseOfferingParticipant_ATE_Update_2'

select * from CourseOfferingParticipant_ATE_Update_Result
WHERE Error <> 'Operation Successful.'

SELECT * 
INTO CourseOfferingParticipant_ATE_Update_2
FROM CourseOfferingParticipant_ATE_Update_Result
WHERE Error <> 'Operation Successful.'

UPDATE CourseOfferingParticipant_ATE_Update_2
SET ParticipationStatus = 'Enrolled'