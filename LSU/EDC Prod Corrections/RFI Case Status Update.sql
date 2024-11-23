
DROP TABLE Case_RFI_Status_Update
SELECT B.ID,A.[Status] 
into Case_RFI_Status_Update
FROM [dbo].[10_EDA_Interactions] A
INNER JOIN
Case_RFI_Lookup B
ON A.Legacy_Id__c = B.Legacy_Id__c
LEFT JOIN
Case_Interaction_LOAD C
ON A.Legacy_Id__c = C.Legacy_Id__c
where A.[Status] <> C.[Status] 


select * from Case_RFI_Status_Update
where id = '500Hu00002HBNGsIAP'

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_RFI_Status_Update'