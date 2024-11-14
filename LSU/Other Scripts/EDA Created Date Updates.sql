

SELECT C.Id,A.[EDACreatedDate__c]
INTO Account_ECD_Update
FROM [dbo].[02_EDA_OrgAccount] A
INNER JOIN 
[Account] C
ON A.Legacy_ID__c = C.Legacy_ID__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Account_ECD_Update'


SELECT C.Id,A.[EDACreatedDate__c]
INTO LearnerPRogram_ECD_Update
FROM [dbo].[08_EDA_Student] A
INNER JOIN 
[LearnerProgram] C
ON A.EDACERTENROLLID__c = C.EDACERTENROLLID__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','LearnerPRogram_ECD_Update'


SELECT C.Id,A.[EDACreatedDate__c]
INTO Case_Int_ECD_Update
FROM [dbo].[10_EDA_Interactions] A
INNER JOIN 
[Case] C
ON A.Legacy_Id__c = C.Legacy_Id__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Int_ECD_Update_2'

select * 
INTO Case_Int_ECD_Update_2
from Case_Int_ECD_Update_Result
where Error <> 'Operation Successful.'


SELECT C.Id,A.[EDACreatedDate__c]
INTO Case_OppRec_ECD_Update
FROM [dbo].[11_Case_Opp_Recruitment] A
INNER JOIN 
[Case] C
ON A.Legacy_Id__c = C.Legacy_Id__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_OppRec_ECD_Update'


SELECT C.Id,A.[EDACreatedDate__c]
INTO Opportunity_ECD_Update
FROM [dbo].[12_EDA_Opportunity] A
INNER JOIN 
[Opportunity] C
ON A.Legacy_Id__c = C.Legacy_Id__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Opportunity_ECD_Update'



SELECT C.Id,A.[EDACreatedDate__c]
INTO IndividualApplication_ECD_Update
FROM [dbo].[13A_EDA_Application] A
INNER JOIN 
[IndividualApplication] C
ON A.Legacy_Id__c = C.Legacy_Id__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','IndividualApplication_ECD_Update'



SELECT C.Id,A.[EDACreatedDate__c]
INTO Case_AffRet_ECD_Update
FROM [dbo].[14_EDA_Affiliations] A
INNER JOIN 
[Case] C
ON A.Legacy_Id__c = C.Legacy_Id__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_AffRet_ECD_Update_2'

select * 
into Case_AffRet_ECD_Update_2
from  Case_AffRet_ECD_Update_Result
where error <> 'Operation Successful.'


SELECT C.Id,A.[EDACreatedDate__c]
INTO DocumentChecklistItem_ECD_Update
FROM [dbo].[15_EDA_ReqDocuments] A
INNER JOIN 
[DocumentChecklistItem] C
ON A.EDAREQDOCID__c = C.EDAREQDOCID__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','DocumentChecklistItem_ECD_Update'


SELECT C.Id,A.[EDACreatedDate__c]
INTO Learning_ECD_Update
FROM [dbo].[19A_EDA_Course_Learning] A
INNER JOIN 
[Learning] C
ON A.EDAACCOUNTID__c = C.EDAACCOUNTID__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Learning_ECD_Update'

SELECT C.Id,A.[EDACreatedDate__c]
INTO LearningProgramPlanRqmt_ECD_Update
FROM [dbo].[20B_EDA_Plan_Requirements] A
INNER JOIN 
[LearningProgramPlanRqmt] C
ON A.Legacy_Id__c = C.Legacy_Id__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','LearningProgramPlanRqmt_ECD_Update'


SELECT C.Id,A.[EDACreatedDate__c]
INTO CourseOfferingParticipant_ECD_Update
FROM [dbo].[23E_EDA_Enrollments]  A
INNER JOIN 
[CourseOfferingParticipant] C
ON A.Legacy_Id__c = C.Legacy_Id__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','CourseOfferingParticipant_ECD_Update'