SELECT A.ID,C.Related_Retention_Case__c as Related_Recruitment_Case__c,NULL AS Related_Retention_Case__c,A.Related_Opportunity__c
--INTO Case_Update
FROM Case_Opportunity_Lookup_Update_2 A
INNER JOIN
[Case] C
ON A.ID = C.ID

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Update'
