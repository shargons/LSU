
-- 02 Account Org Load
SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Account_Org_Owner_Update
FROM [EDUCPROD].[dbo].[02_EDA_OrgAccount] C
INNER JOIN
Account A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerId IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Account_Org_Owner_Update'

SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Learning_Owner_Update
FROM [EDUCPROD].[dbo].[03_EDA_Learning] C
INNER JOIN
Learning A
ON A.EDAACCOUNTID__c = C.EDAACCOUNTID__c
WHERE C.OwnerId IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Learning_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.LearningProgram_Owner_Update
FROM [dbo].[04A_EDA_ProgramParents] C
INNER JOIN
LearningProgram A
ON A.EDAACCOUNTID__c = C.EDAACCOUNTID__c
WHERE C.OwnerId IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','LearningProgram_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Account_Person_Owner_Update
FROM [dbo].[06_EDA_PersonAccount] C
INNER JOIN
Account A
ON A.Legacy_Id__pc = C.Legacy_Id__pc
WHERE C.OwnerId IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Account_Person_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.LearningProgramPlan_Owner_Update
FROM [dbo].[07_EDA_LearningProgramPlan] C
INNER JOIN
LearningProgramPlan A
ON A.LearningProgramId = C.LearningProgramId
WHERE C.OwnerId IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','LearningProgramPlan_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.LearnerProgram_Owner_Update
FROM [dbo].[08_EDA_Student] C
INNER JOIN
LearnerProgram A
ON A.EDACERTENROLLID__c = C.EDACERTENROLLID__c
WHERE C.OwnerId IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','LearnerProgram_Owner_Update'


--DROP TABLE Case_RFI_Owner_Update
SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Case_RFI_Owner_Update
FROM [EDUCPROD].[dbo].[10_EDA_Interactions] C
INNER JOIN
[Case] A
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.OwnerId <> A.OwnerId

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_RFI_Owner_Update_2'

select * 
into Case_RFI_Owner_Update_2
from Case_RFI_Owner_Update_Result
where error <> 'Operation Successful.'


SELECT A.ID,C.OwnerId,C.coordinator__c
INTO [EDUCPROD].dbo.Case_Rec_Owner_Update
FROM [dbo].[11_Case_Opp_Recruitment] C
INNER JOIN
[Case] A
ON A.Legacy_ID__c = C.Legacy_ID__c

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Rec_Owner_Update_2'


--DROP TABLE Opportunity_Owner_Update
SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Opportunity_Owner_Update
FROM [dbo].[12_EDA_Opportunity] C
INNER JOIN
[Opportunity] A
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.OwnerID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Opportunity_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.IndividualApplication_Owner_Update
FROM [dbo].[13A_EDA_Application] C
INNER JOIN
[IndividualApplication] A
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.OwnerID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','IndividualApplication_Owner_Update'

SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Case_Aff_Owner_Update
FROM [dbo].[14_EDA_Affiliations] C
INNER JOIN
[Case] A
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.OwnerID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Aff_Owner_Update'

select * from Case_Aff_Owner_Update_Result


SELECT A.ID,C.OwnerId
--INTO [EDUCPROD].dbo.DocumentChecklistItem_Owner_Update
FROM [dbo].[15_EDA_ReqDocuments] C
INNER JOIN
[DocumentChecklistItem] A
ON A.EDAREQDOCID__c = C.EDAREQDOCID__c
WHERE C.OwnerID IS NOT NULL

select * from DocumentChecklistItem_Owner_Update

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','DocumentChecklistItem_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Financial_Aid__c_Owner_Update
FROM [dbo].[16_EDA_Financial_Aid_Record] C
INNER JOIN
[Financial_Aid__c] A
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.OwnerID IS NOT NULL

select * from Financial_Aid__c_Owner_Update

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Financial_Aid__c_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.LearningProgramPlan_Owner_Update_2
FROM [dbo].[17_EDA_ProgramPlan] C
INNER JOIN
[LearningProgramPlan] A
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.OwnerID IS NOT NULL

select * from LearningProgramPlan_Owner_Update_2

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','LearningProgramPlan_Owner_Update_2'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.LearnerProgram_Owner_Update_2
FROM [dbo].[18_EDA_CertificateEnrollments] C
INNER JOIN
LearnerProgram A
ON A.EDACERTENROLLID__c = C.EDACERTENROLLID__c
WHERE C.OwnerID IS NOT NULL

select * from LearningProgramPlan_Owner_Update_2

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','LearnerProgram_Owner_Update_2'

SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.LearningAchievement_Owner_Update
FROM [dbo].[20A_EDA_Achievement_ProgramPlan] C
INNER JOIN
LearningAchievement_Lookup A
ON A.Legacy_ID__c = C.ExternalKey__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','LearningAchievement_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.LearningProgramPlanRqmt_Owner_Update
FROM [dbo].[20B_EDA_Plan_Requirements] C
INNER JOIN
LearningProgramPlanRqmt A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','LearningProgramPlanRqmt_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.CourseOfferingParticipant_Owner_Update
FROM [EDUCPROD].[dbo].[22_EDA_CourseEnrollment] C
INNER JOIN
CourseOfferingParticipant A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','CourseOfferingParticipant_Owner_Update'

SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Learning_Owner_Update_2
FROM [dbo].[23A_Enr_Learning] C
INNER JOIN
Learning A
ON A.EDAACCOUNTID__c = C.EDAACCOUNTID__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Learning_Owner_Update_2'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.LearningCourse_Owner_Update
FROM [EDUCPROD].[dbo].[23B_Enr_Course] C
INNER JOIN
LearningCourse A
ON A.EDACOURSEID__c = C.EDACOURSEID__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','LearningCourse_Owner_Update'

SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.CourseOffering_Owner_Update
FROM [dbo].[23D_Enr_CourseOffering] C
INNER JOIN
CourseOffering A
ON A.EDACROFRNGID__c = C.EDACROFRNGID__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','CourseOffering_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.CourseOfferingParticipant_Owner_Update_2
FROM [dbo].[23E_EDA_Enrollments] C
INNER JOIN
CourseOfferingParticipant A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','CourseOfferingParticipant_Owner_Update_2'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.CourseOfferingParticipant_Owner_Update_2
FROM [dbo].[23E_EDA_Enrollments] C
INNER JOIN
CourseOfferingParticipant A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','CourseOfferingParticipant_Owner_Update_2'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.cfg_Subscription__c_Owner_Update
FROM [dbo].[25_EDA_Subscription] C
INNER JOIN
cfg_Subscription__c A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','cfg_Subscription__c_Owner_Update'

--DROP TABLE cfg_Subscription_Member__c_Owner_Update
SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.cfg_Subscription_Member__c_Owner_Update
FROM [dbo].[26_EDA_SubscriptionMembers] C
INNER JOIN
cfg_Subscription_Member__c A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','cfg_Subscription_Member__c_Owner_Update'

select * from cfg_Subscription_Member__c_Owner_Update_Result


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Case_Owner_Update
FROM [dbo].[27_EDA_Case] C
INNER JOIN
[Case] A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Chat_Transcript__c_Owner_Update
FROM [dbo].[28_EDA_ChatTranscripts] C
INNER JOIN
[Chat_Transcript__c] A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Chat_Transcript__c_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Case_Owner_Update_2
FROM [dbo].[30_Case_Enrollment_RFI] C
INNER JOIN
[Case] A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Owner_Update_2'

SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Case_Owner_Update_2
FROM [dbo].[30_Case_Enrollment_RFI] C
INNER JOIN
[Case] A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL

select *
into Case_Owner_Update_3
from Case_Owner_Update_2_Result
where Error <> 'Operation Successful.'

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Owner_Update_3'


SELECT A.ID,C.OwnerId
INTO [EDUCPROD].dbo.Task_Owner_Update
FROM [dbo].[32_EDA_Tasks] C
INNER JOIN
[Task] A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Task_Owner_Update'
