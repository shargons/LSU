SELECT C.Id,A.[Status],A.Sub_Status__c
INTO Case_Requested_Status_Update
FROM [dbo].[11_Case_Opp_Recruitment] A
INNER JOIN 
[Case] C
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE A.[Status] <> C.[Status]


EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Requested_Status_Update_3'

--DROP TABLE Case_Requested_Status_Update_3
SELECT *
INTO Case_Requested_Status_Update_3
FROM Case_Requested_Status_Update_2_result
where eRROR <> 'oPERATION sUCCESSFUL.'


SELECT C.Id,A.[Status],A.Sub_Status__c
INTO Case_Requested_Status_Update_4
FROM [dbo].[34A_Ret_Opp_Recruitment] A
INNER JOIN 
[Case] C
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE A.[Status] <> C.[status]

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Requested_Status_Update_4'


SELECT C.Id,A.[Status],A.Sub_Status__c
INTO Case_Ret_Status_Update
FROM [dbo].[34B_EDA_Ret_Opportunity] A
INNER JOIN 
[Case] C
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE A.[Status] <> C.[status]

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Ret_Status_Update_2'

select * 
into Case_Ret_Status_Update_2
from Case_Ret_Status_Update_Result
where Error <> 'Operation Successful.'


SELECT C.Id,A.[Status]
INTO Task_Status_Update
FROM [dbo].[32_EDA_Tasks] A
INNER JOIN 
[Task] C
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE A.[Status] <> C.[status]

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Task_Status_Update_3'

select * 
--into Task_Status_Update_3
from Task_Status_Update_2_Result
where error <> 'Operation Successful.'