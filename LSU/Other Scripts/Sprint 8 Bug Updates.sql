SELECT B.Id,Learning_Program_of_Interest__c
INTO Case_LearningProgram_Update
FROM  [dbo].[11_Case_Opp_Recruitment] A
LEFT JOIN
Case_Lookup B
ON A.Legacy_ID__c = b.legacy_ID__c

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_LearningProgram_Update'


SELECT B.Id,A.ContactId
--INTO Case_ContactId_Update
FROM  [dbo].[11_Case_Opp_Recruitment] A
LEFT JOIN
Case_Lookup B
ON A.Legacy_ID__c = b.legacy_ID__c

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_ContactId_Update'

SELECT * FROM Case_ContactId_Update