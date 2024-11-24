
-- DROP TABLE CourseOfferingParticipant_Case_Update_1
--SELECT A.Id,B.Id,B.CourseAffiliation__c,A.Case__c as Source_Case,C.Id as Case__c 
SELECT A.Id,C.Id as Case__c 
INTO CourseOfferingParticipant_Case_Update_1
FROM CourseOfferingParticipant A
INNER JOIN
edaprod.dbo.hed__Course_Enrollment__c B
ON A.Legacy_Id__c = B.Id
LEFT JOIN 
[EDUCPROD].[dbo].[Case] C
ON B.CourseAffiliation__c = C.Legacy_ID__c
WHERE A.Case__c is null AND B.CourseAffiliation__c IS NOT NULL
--AND C.Id IS NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','CourseOfferingParticipant_Case_Update_1'

SELECT *
FROM CourseOfferingParticipant_Case_Update_1_Result
WHERE Error <> 'Operation Successful.'


--DROP TABLE CourseOfferingParticipant_Case_Update_2
--SELECT A.Id,B.Id,B.LSU_Affiliation__c,A.Case__c as Source_Case,C.Id AS Case__c
SELECT A.Id,C.Id as Case__c
INTO CourseOfferingParticipant_Case_Update_2
FROM CourseOfferingParticipant A
INNER JOIN
edaprod.dbo.Enrollment__c B
ON A.Legacy_Id__c = B.Id
LEFT JOIN 
[EDUCPROD].[dbo].[Case] C
ON B.LSU_Affiliation__c = C.Legacy_ID__c
WHERE A.Case__c is null 
AND B.LSU_Affiliation__c IS NOT NULL AND C.Id IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','CourseOfferingParticipant_Case_Update_2'

SELECT * FROM CourseOfferingParticipant_Case_Update_2_Result
WHERE Error <> 'Operation Successful.'