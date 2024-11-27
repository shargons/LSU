SELECT * FROM [Case]
WHERE RecordTypeId IN ('012Hu000001c6vGIAQ','012Hu000001c6vHIAQ')
AND Learner_Program__c IS NULL

-- LearnerProgram Retention Case Update
DROP TABLE LearnerProgram_Case_Update
SELECT A.ID,C.ID AS Case__c
--INTO LearnerProgram_Case_Update
FROM LearnerProgram A
INNER JOIN
[edaprod].[dbo].[student__c] S
ON A.EDACERTENROLLID__c = S.Id
LEFT JOIN
[Case] C
ON S.Opportunity__c = C.Legacy_ID__c
WHERE Case__c IS NULL 
--and c.id is null

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','LearnerProgram_Case_Update'

--  Rec Case LearnerProgram Update

SELECT A.ID as Learner_Program__c,C.ID 
INTO Case_LearnerProgram_Update_2
FROM LearnerProgram A
INNER JOIN
[edaprod].[dbo].[student__c] S
ON A.EDACERTENROLLID__c = S.Id
LEFT JOIN
[Case] C
ON S.Opportunity__c = C.Legacy_ID__c
WHERE Learner_Program__c IS NULL 
--and c.id is null

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_LearnerProgram_Update_2'

select * from Case_LearnerProgram_Ret_Update_Result where Error <> 'Operation Successful.'

-- 103937


-- LearnerProgram Retention Case Update
--DROP TABLE LearnerProgram_Case_Retention_Update
SELECT A.ID,C.ID AS Case__c
INTO LearnerProgram_Case_Retention_Update
FROM LearnerProgram A
INNER JOIN
[edaprod].[dbo].[student__c] S
ON A.EDACERTENROLLID__c = S.Id
LEFT JOIN
[Case] C
ON S.LSU_Affiliation__c = C.Legacy_ID__c
WHERE Case__c IS NULL 
--and c.id is null

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','LearnerProgram_Case_Retention_Update'


SELECT A.ID as LearnerProgram,C.ID 
INTO Case_LearnerProgram_Ret_Update
FROM LearnerProgram A
INNER JOIN
[edaprod].[dbo].[student__c] S
ON A.EDACERTENROLLID__c = S.Id
LEFT JOIN
[Case] C
ON S.LSU_Affiliation__c = C.Legacy_ID__c
WHERE Learner_Program__c IS NULL 
--and c.id is null

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_LearnerProgram_Ret_Update'