

SELECT B.ID,A.RecordTypeId,A.Status,B.Sub_Status__c
--INTO Case_Recordtype_Change
FROM [dbo].[35_Case_Opp_RFI]  A
INNER JOIN
[Case] B
ON A.Legacy_Id__c = B.Legacy_Id__c

select * from Case_Recordtype_Change
where Id = '500Hu00002HMrLbIAL'

Exec SF_TableLoader 'update:bulkapi','EDUCPROD','Case_Recordtype_Change'

drop table Case_Delete
SELECT id 
INTO Case_Delete
FROM Case_Recordtype_Change_RESULT
WHERE Error = 'Operation Successful.'