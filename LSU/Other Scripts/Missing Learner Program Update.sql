
DROP TABLE LearnerProgram_Missing_Insert
SELECT S.* 
INTO LearnerProgram_Missing_Insert
FROM edcuat.[dbo].[08_EDA_Student] S
LEFT JOIN
edcuat.dbo.LearnerProgram L
ON S.EDACERTENROLLID__c = L.EDACERTENROLLID__c
WHERE L.ID IS NULL


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearnerProgram_Missing_Insert_2
ALTER COLUMN LearningProgramPlanId NVARCHAR(18)

ALTER TABLE LearnerProgram_Missing_Insert_2
ALTER COLUMN LearnerContactId NVARCHAR(18)

UPDATE A
SET LearningProgramPlanId = D.ID 
FROM edcuat.dbo.LearnerProgram_Missing_Insert_2 A
INNER JOIN
edaprod.dbo.hed__Affiliation__c B
ON A.LSU_Affiliation__c = B.ID
LEFT JOIN edcuat.dbo.LearningProgram C
ON B.hed__Account__c = C.EDAACCOUNTID__c
LEFT JOIN edcuat.dbo.LearningProgramPlan D
ON C.ID = D.LearningProgramId

SELECT * FROM [dbo].[04_EDA_AccountProgram] WHERE EDAACCOUNTID__c = '001Kj00002Sa3krIAB'

UPDATE A
SET Name = ISNULL(C.Name,'')+' - '+ISNULL(C1.Name,'')
FROM [edcuat].dbo.LearnerProgram_Missing_Insert_2 A
INNER JOIN
edaprod.dbo.hed__Affiliation__c B
ON A.LSU_Affiliation__c = B.ID
LEFT JOIN [edcuat].dbo.LearningProgram C
ON B.hed__Account__c = C.EDAACCOUNTID__c
LEFT JOIN [edcuat].dbo.LearningProgramPlan D
ON C.ID = D.LearningProgramId
LEFT JOIN
[edcuat].dbo.[Contact] C1
ON A.Source_Contact__c = C1.Legacy_ID__c

UPDATE A
SET LearnerContactId = C.ID 
FROM [edcuat].dbo.LearnerProgram_Missing_Insert_3 A
INNER JOIN
edaprod.dbo.hed__Affiliation__c B
ON A.LSU_Affiliation__c = B.ID
LEFT JOIN
[edcuat].dbo.[Contact] C
ON B.hed__Contact__c = C.Legacy_ID__c

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearnerProgram_Missing_Insert
ALTER COLUMN ID NVARCHAR(18)

SELECT DISTINCT * FROM LearnerProgram_Missing_Insert_3

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','LearnerProgram_Missing_Insert_2'

select * 
INTO LearnerProgram_Missing_Insert_3
from LearnerProgram_Missing_Insert_2_Result
where Error <> 'Operation Successful.'


