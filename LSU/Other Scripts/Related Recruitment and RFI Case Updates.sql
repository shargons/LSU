-- Related Retention Case Update
SELECT CREC.Id ,CRET.ID AS Related_Retention_Case__c
INTO Case_Rec_Ret_Link_Update
FROM [Case] CREC
INNER JOIN
[Case] CRET 
ON CREC.AccountId = CRET.AccountId
AND CREC.Learning_Program_of_Interest__c = CRET.Learning_Program_of_Interest__c
WHERE CREC.RecordTypeId IN ('012KT000000TRjyYAG','012KT000000TRjzYAG')
AND CRET.RecordTypeId IN ('012KT000000TRk0YAG','012KT000000TRk1YAG')
--AND CRET.AccountId = '001KT0000041ViyYAE'

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Rec_Ret_Link_Update'

-- Related Recruitment Case Update
SELECT CREC.Id Related_Recruitment_Case__c ,CRET.ID 
INTO Case_Ret_Rec_Link_Update
FROM [Case] CREC
INNER JOIN
[Case] CRET 
ON CREC.AccountId = CRET.AccountId
AND CREC.Learning_Program_of_Interest__c = CRET.Learning_Program_of_Interest__c
WHERE CREC.RecordTypeId IN ('012KT000000TRjyYAG','012KT000000TRjzYAG')
AND CRET.RecordTypeId IN ('012KT000000TRk0YAG','012KT000000TRk1YAG')
AND CRET.AccountId = '001KT0000041ViyYAE'

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Ret_Rec_Link_Update'

-- Source RFI Case Update
SELECT RFI.Id as Source_RFI_Case__c, RET.ID 
INTO Case_RFI_Ret_Link_Update_2
FROM [Case] RFI
INNER JOIN 
[Case] RET
ON RFI.AccountId = RET.AccountId
AND RFI.Learning_Program_of_Interest__c = RET.Learning_Program_of_Interest__c
AND RFI.Source__c = 'WebForm'
WHERE RET.RecordTypeId IN ('012KT000000TRk0YAG','012KT000000TRk1YAG')
AND RFI.RecordTypeId IN ('012KT000000TRjwYAG','012KT000000TRjxYAG')
--AND RET.AccountId = '001KT0000041ViyYAE'


EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_RFI_Ret_Link_Update_2'

-- RFI Related Retention Case Update
SELECT RFI.Id , RET.ID as Related_Retention_Case__c 
INTO Case_RET_RFI_Link_Update
FROM [Case] RFI
INNER JOIN 
[Case] RET
ON RFI.AccountId = RET.AccountId
AND RFI.Learning_Program_of_Interest__c = RET.Learning_Program_of_Interest__c
AND RFI.Source__c = 'WebForm'
WHERE RET.RecordTypeId IN ('012KT000000TRk0YAG','012KT000000TRk1YAG')
AND RFI.RecordTypeId IN ('012KT000000TRjwYAG','012KT000000TRjxYAG')
--AND RET.AccountId = '001KT0000041ViyYAE'

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_RET_RFI_Link_Update'