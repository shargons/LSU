
SELECT C.ID,A.[Status]
--INTO Case_Enr_Status_Update
FROM [Case] C
INNER JOIN 
[dbo].[14_EDA_Affiliations] A
ON C.Legacy_Id__c = A.Legacy_Id__c
WHERE C.[Status] <> A.[Status]

EXEC SF_TableLoader 'Update:BULKAPI','UAT','Case_Enr_Status_Update'



SELECT C.ID,A.[Status]
--INTO Case_Enr_Status_Update_2
FROM [Case] C
INNER JOIN 
[dbo].[34B_EDA_Ret_Opportunity] A
ON C.Legacy_Id__c = A.Legacy_Id__c
WHERE C.[Status] <> A.[Status]

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Enr_Status_Update_2'
