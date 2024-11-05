
-- 02 Account Org Load
SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.Account_Org_Owner_Update
FROM [edcuat].[dbo].[02_EDA_OrgAccount] C
INNER JOIN
Account A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerId IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_Org_Owner_Update'

SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.Learning_Owner_Update
FROM [edcuat].[dbo].[03_EDA_Learning] C
INNER JOIN
Learning A
ON A.EDAACCOUNTID__c = C.EDAACCOUNTID__c
WHERE C.OwnerId IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Learning_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.LearningProgram_Owner_Update
FROM [dbo].[04A_EDA_ProgramParents] C
INNER JOIN
LearningProgram A
ON A.EDAACCOUNTID__c = C.EDAACCOUNTID__c
WHERE C.OwnerId IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','LearningProgram_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.Account_Person_Owner_Update
FROM [dbo].[06_EDA_PersonAccount] C
INNER JOIN
Account A
ON A.Legacy_Id__pc = C.Legacy_Id__pc
WHERE C.OwnerId IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_Person_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.LearningProgramPlan_Owner_Update
FROM [dbo].[07_EDA_LearningProgramPlan] C
INNER JOIN
LearningProgramPlan A
ON A.LearningProgramId = C.LearningProgramId
WHERE C.OwnerId IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','LearningProgramPlan_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.LearnerProgram_Owner_Update
FROM [dbo].[08_EDA_Student] C
INNER JOIN
LearnerProgram A
ON A.EDACERTENROLLID__c = C.EDACERTENROLLID__c
WHERE C.OwnerId IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','LearnerProgram_Owner_Update'



SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.Case_RFI_Owner_Update
FROM [edcuat].[dbo].[10_EDA_Interactions] C
INNER JOIN
[Case] A
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.OwnerId IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Case_RFI_Owner_Update'


SELECT A.ID,C.OwnerId,C.coordinator__c
INTO [edcuat].dbo.Case_Rec_Owner_Update
FROM [dbo].[11_Case_Opp_Recruitment] C
INNER JOIN
[Case] A
ON A.Legacy_ID__c = C.Legacy_ID__c

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Case_Rec_Owner_Update_2'


--DROP TABLE Opportunity_Owner_Update
SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.Opportunity_Owner_Update
FROM [dbo].[12_EDA_Opportunity] C
INNER JOIN
[Opportunity] A
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.OwnerID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Opportunity_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.IndividualApplication_Owner_Update
FROM [dbo].[13A_EDA_Application] C
INNER JOIN
[IndividualApplication] A
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.OwnerID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','IndividualApplication_Owner_Update'

SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.Case_Aff_Owner_Update
FROM [dbo].[14_EDA_Affiliations] C
INNER JOIN
[Case] A
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.OwnerID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Case_Aff_Owner_Update'

select * from Case_Aff_Owner_Update_Result


SELECT A.ID,C.OwnerId
--INTO [edcuat].dbo.DocumentChecklistItem_Owner_Update
FROM [dbo].[15_EDA_ReqDocuments] C
INNER JOIN
[DocumentChecklistItem] A
ON A.EDAREQDOCID__c = C.EDAREQDOCID__c
WHERE C.OwnerID IS NOT NULL

select * from DocumentChecklistItem_Owner_Update

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','DocumentChecklistItem_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.Financial_Aid__c_Owner_Update
FROM [dbo].[16_EDA_Financial_Aid_Record] C
INNER JOIN
[Financial_Aid__c] A
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.OwnerID IS NOT NULL

select * from Financial_Aid__c_Owner_Update

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Financial_Aid__c_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.LearningProgramPlan_Owner_Update_2
FROM [dbo].[17_EDA_ProgramPlan] C
INNER JOIN
[LearningProgramPlan] A
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.OwnerID IS NOT NULL

select * from LearningProgramPlan_Owner_Update_2

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','LearningProgramPlan_Owner_Update_2'


SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.LearnerProgram_Owner_Update_2
FROM [dbo].[18_EDA_CertificateEnrollments] C
INNER JOIN
LearnerProgram A
ON A.EDACERTENROLLID__c = C.EDACERTENROLLID__c
WHERE C.OwnerID IS NOT NULL

select * from LearningProgramPlan_Owner_Update_2

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','LearnerProgram_Owner_Update_2'

SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.LearningAchievement_Owner_Update
FROM [dbo].[20A_EDA_Achievement_ProgramPlan] C
INNER JOIN
LearningAchievement_Lookup A
ON A.Legacy_ID__c = C.ExternalKey__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','LearningAchievement_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.LearningProgramPlanRqmt_Owner_Update
FROM [dbo].[20B_EDA_Plan_Requirements] C
INNER JOIN
LearningProgramPlanRqmt A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','LearningProgramPlanRqmt_Owner_Update'


SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.CourseOfferingParticipant_Owner_Update
FROM [edcuat].[dbo].[22_EDA_CourseEnrollment] C
INNER JOIN
CourseOfferingParticipant A
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','CourseOfferingParticipant_Owner_Update'

SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.Learning_Owner_Update_2
FROM [dbo].[23A_Enr_Learning] C
INNER JOIN
Learning A
ON A.EDAACCOUNTID__c = C.EDAACCOUNTID__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Learning_Owner_Update_2'


SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.LearningCourse_Owner_Update
FROM [edcuat].[dbo].[23B_Enr_Course] C
INNER JOIN
LearningCourse A
ON A.EDACOURSEID__c = C.EDACOURSEID__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','LearningCourse_Owner_Update'

SELECT A.ID,C.OwnerId
INTO [edcuat].dbo.CourseOffering_Owner_Update
FROM [dbo].[23D_Enr_CourseOffering] C
INNER JOIN
CourseOffering A
ON A.EDACROFRNGID__c = C.EDACROFRNGID__c
WHERE C.OwnerID IS NOT NULL


EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','CourseOffering_Owner_Update'

