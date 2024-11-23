SELECT A.ID,B.AcademicTermId
INTO AcademicTermEnrollment_Update
FROM AcademicTermEnrollment A
INNER JOIN
[dbo].[23F_AcademicTermEnrollments] b
on a.UpsertKey__c = b.UpsertKey__c
WHERE A.AcademicTermId <> B.AcademicTermId


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','AcademicTermEnrollment_Update_2'

SELECT * 
INTO AcademicTermEnrollment_Update_2
FROM AcademicTermEnrollment_Update_Result
WHERE Error <> 'Operation Successful.'

-- Delete Duplicate ATEs

--DROP TABLE CourseOfferingParticipant_Update_ATE
SELECT B.UpsertKey__c as ID,NULL AS AcademicTermEnrollmentId 
INTO CourseOfferingParticipant_Update_ATE
FROM AcademicTermEnrollment_Dup_Delete_Result A
INNER JOIN
[AcademicTermEnrollment] b
on a.ID = b.ID
WHERE 
B.CreatedById = '005KT000000poMtYAI'
AND Error <> 'Operation Successful.'

ALTER TABLE CourseOfferingParticipant_Update_ATE
ALTER COLUMN ID NVARCHAR(18)

select * from CourseOfferingParticipant_Update_ATE 

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','CourseOfferingParticipant_Update_ATE'

SELECT * FROM CourseOfferingParticipant_Update_ATE_Result



SELECT A.ID
INTO AcademicTermEnrollment_Dup_Delete
FROM AcademicTermEnrollment A
LEFT JOIN
[dbo].[23F_AcademicTermEnrollments] b
on a.UpsertKey__c = b.UpsertKey__c
WHERE 
A.CreatedById = '005KT000000poMtYAI'


EXEC SF_TableLoader 'Delete:BULKAPI','EDUCPROD','AcademicTermEnrollment_Dup_Delete_2'

SELECT * 
INTO AcademicTermEnrollment_Dup_Delete_2
FROM AcademicTermEnrollment_Dup_Delete_Result
WHERE Error <> 'Operation Successful.'


--- Insert ATE records
DROP TABLE AcademicTermEnrollment_LOAD
SELECT A.*
INTO [EDUCPROD].[dbo].AcademicTermEnrollment_LOAD
FROM [EDUCPROD].[dbo].[23F_AcademicTermEnrollments] A
LEFT JOIN
AcademicTermEnrollment B
ON A.AcademicTermId = B.AcademicTermId
AND A.LearnerAccountId = B.LearnerAccountId
WHERE 
B.ID IS NULL


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE AcademicTermEnrollment_LOAD
ALTER COLUMN ID NVARCHAR(18)

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','AcademicTermEnrollment_LOAD_5'

--DROP TABLE AcademicTermEnrollment_Load_5
SELECT * 
INTO AcademicTermEnrollment_Load_5
FROM AcademicTermEnrollment_Load_4_Result
WHERE Error <> 'Operation Successful.'

UPDATE AcademicTermEnrollment_Load_2
SET EnrollmentStatus = 'Dropped'
WHERE EnrollmentStatus = 'Inactive'

--DROP TABLE CourseOfferingParticipant_ATE_Update
SELECT DISTINCT A.UpsertKey__c as ID,B.ID AS AcademicTermEnrollmentID,A.EnrollmentStatus as ParticipationStatus
INTO CourseOfferingParticipant_ATE_Update
FROM [dbo].[23F_AcademicTermEnrollments] A
INNER JOIN
AcademicTermEnrollment_Lookup B
ON A.UpsertKey__c = B.UpsertKey__c

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','CourseOfferingParticipant_ATE_Update_3'

DROP TABLE CourseOfferingParticipant_ATE_Update_3
select * 
INTO CourseOfferingParticipant_ATE_Update_3
from CourseOfferingParticipant_ATE_Update_2_result
WHERE eRROR <> 'Operation Successful.'


UPDATE CourseOfferingParticipant_ATE_Update_3
SET ParticipationStatus = 'Enrolled'
WHERE ParticipationStatus = 'Registered'