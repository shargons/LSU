-- Related Retention Case Update
DROP TABLE Case_Rec_Ret_Link_Update
SELECT CREC.Id ,CRET.ID AS Related_Retention_Case__c
INTO Case_Rec_Ret_Link_Update
FROM [Case] CREC
INNER JOIN
[Case] CRET 
ON CREC.AccountId = CRET.AccountId
AND CREC.Learning_Program_of_Interest__c = CRET.Learning_Program_of_Interest__c
WHERE CREC.RecordTypeId IN ('012Hu000001c6vEIAQ','012Hu000001c6vFIAQ')
AND CRET.RecordTypeId IN ('012Hu000001c6vGIAQ','012Hu000001c6vHIAQ')
--AND CRET.AccountId = '001KT0000041ViyYAE'

SELECT * FROM Recordtype WHERE SobjectType = 'Case'

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Rec_Ret_Link_Update'

-- Related Recruitment Case Update
SELECT CREC.Id AS Related_Recruitment_Case__c ,CRET.ID 
INTO Case_Ret_Rec_Link_Update
FROM [Case] CREC
INNER JOIN
[Case] CRET 
ON CREC.AccountId = CRET.AccountId
AND CREC.Learning_Program_of_Interest__c = CRET.Learning_Program_of_Interest__c
WHERE CREC.RecordTypeId IN ('012Hu000001c6vEIAQ','012Hu000001c6vFIAQ')
AND CRET.RecordTypeId IN ('012Hu000001c6vGIAQ','012Hu000001c6vHIAQ')
AND CRET.Related_Recruitment_Case__c IS NULL
--AND CRET.AccountId = '001KT0000041ViyYAE'

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Ret_Rec_Link_Update'

-- Source RFI Case Update
SELECT RFI.Id as Source_RFI_Case__c, RET.ID 
INTO Case_RFI_Ret_Link_Update_2
FROM [Case] RFI
INNER JOIN 
[Case] RET
ON RFI.AccountId = RET.AccountId
AND RFI.Learning_Program_of_Interest__c = RET.Learning_Program_of_Interest__c
AND RFI.Source__c = 'WebForm'
WHERE RET.RecordTypeId IN ('012Hu000001c6vGIAQ','012Hu000001c6vHIAQ')
AND RFI.RecordTypeId IN ('012Hu000001c6vCIAQ','012Hu000001c6vDIAQ')
AND RET.Source_RFI_Case__c IS NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_RFI_Ret_Link_Update_2'

SELECT *
FROM Case_RFI_Ret_Link_Update_2_Result
WHERE eRROR <> 'oPERATION sUCCESSFUL.'

-- RFI Related Retention Case Update
SELECT RFI.Id , RET.ID as Related_Retention_Case__c 
INTO Case_RET_RFI_Link_Update_2
FROM [Case] RFI
INNER JOIN 
[Case] RET
ON RFI.AccountId = RET.AccountId
AND RFI.Learning_Program_of_Interest__c = RET.Learning_Program_of_Interest__c
AND RFI.Source__c = 'WebForm'
WHERE RET.RecordTypeId IN ('012Hu000001c6vGIAQ','012Hu000001c6vHIAQ')
AND RFI.RecordTypeId IN ('012Hu000001c6vCIAQ','012Hu000001c6vDIAQ')
AND RFI.Related_Retention_Case__c IS NULL
--AND RET.AccountId = '001KT0000041ViyYAE'

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_RET_RFI_Link_Update_2'
