SELECT Id
INTO LearnerProgram_Dupe_Delete
FROM (
SELECT Id,Ext_Key__c,ROW_NUMBER() OVER (PARTITION BY Ext_Key__c ORDER BY CreatedDate asc) as rownum
FROM LearnerProgram
WHERE Ext_Key__c IS NOT NULL
)X
WHERE x.rownum >1


EXEC SF_TableLoader 'Delete:BULKAPI','EDUCPROD','LearnerProgram_Dupe_Delete'
