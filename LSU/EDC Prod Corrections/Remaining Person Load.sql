SELECT a.*
INTO Account_Person_Remaining_Load
FROM [dbo].[06_EDA_PersonAccount] A
LEFT JOIN
Contact C
on A.Legacy_Id__pc = C.Legacy_Id__c
where C.Id is null

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Account_Person_Remaining_Load
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Account_Person_Remaining_Load'

INSERT INTO [EDUCPROD].[dbo].[Account_Person_Lookup]
SELECT
 ID
,Legacy_Id__pc
INTO [EDUCPROD].[dbo].[Account_Person_Rem_Lookup]
FROM Account_Person_Remaining_Load_Result
WHERE Error = 'Operation Successful.'


-- Primary Academic Program Lookup(Learning Program)

-- enrollment_concierge__pc Lookup(User))
--DROP TABLE IF EXISTS [dbo].[Account_EConc_Update_2];
SELECT P.ID,UL.ID AS enrollment_concierge__pc
INTO Account_EConc_Update_2
FROM [EDUCPROD].dbo.[06_EDA_PersonAccount] A
INNER JOIN
[Account_Person_Rem_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
LEFT JOIN
[User] UL
ON UL.EDAUSERID__c = A.Source_enrollment_concierge__pc
WHERE UL.ID IS NOT NULL

SELECT * FROM Account_EConc_Update

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Account_EConc_Update_2'

SELECT * FROM Account_EConc_Update_Result WHERE Error <> 'Operation Successful.'


-- enrollment_coordinator__pc Lookup(User)
--DROP TABLE IF EXISTS [dbo].[Account_ECoord_Update];
SELECT P.ID,UL.ID AS enrollment_coordinator__pc
INTO Account_ECoord_Update_2
FROM [EDUCPROD].[dbo].[06_EDA_PersonAccount] A
INNER JOIN
[Account_Person_Rem_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
LEFT JOIN
[User] UL
ON UL.EDAUSERID__c = A.Source_enrollment_coordinator__pc
WHERE UL.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Account_ECoord_Update_2'


-- ext_classic_contact_id__pc Text(255)
--DROP TABLE Account_extcontact_Update
SELECT P.ID,A.ext_classic_contact_id__pc
INTO Account_extcontact_Update_2
FROM [EDUCPROD].[dbo].[06_EDA_PersonAccount] A
INNER JOIN
[Account_Person_Rem_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc

select * from Account_extcontact_Update_result

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Account_extcontact_Update_2'

-- ext_classic_lead_id__pc Text(255)
--drop table Account_extlead_Update
SELECT P.ID,A.ext_classic_lead_id__pc
INTO Account_extlead_Update_2
FROM [EDUCPROD].[dbo].[06_EDA_PersonAccount] A
INNER JOIN
[Account_Person_Rem_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
WHERE A.ext_classic_lead_id__pc IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Account_extlead_Update_2'

-- ce_enrollment_coach__pc 	Lookup(User)
-- DROP TABLE Account_Ecoach_Update
SELECT P.ID,UL.ID AS ce_enrollment_coach__pc
INTO Account_Ecoach_Update_2
FROM [EDUCPROD].[dbo].[06_EDA_PersonAccount] A
INNER JOIN
[Account_Person_Rem_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
LEFT JOIN
[User] UL
ON UL.EDAUSERID__c = A.Source_ce_enrollment_coach__pc
WHERE UL.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Account_Ecoach_Update_2'

-- ce_enrollment_coordinator__pc Lookup(User)
--DROP TABLE Account_ceenr_Update
SELECT P.ID,UL.ID AS ce_enrollment_coordinator__pc
INTO Account_ceenr_Update_2
FROM [EDUCPROD].[dbo].[06_EDA_PersonAccount] A
INNER JOIN
[Account_Person_Rem_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
LEFT JOIN
[User] UL
ON UL.EDAUSERID__c = A.Source_ce_enrollment_coordinator__pc
WHERE UL.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Account_ceenr_Update_2'

-- ce_student_success_coach__pc Lookup(User)
--DROP TABLE Account_cecoach_Update
SELECT P.ID,UL.ID AS ce_student_success_coach__pc
INTO Account_cecoach_Update_2
FROM [EDUCPROD].[dbo].[06_EDA_PersonAccount] A
INNER JOIN
[Account_Person_Rem_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
LEFT JOIN
[User] UL
ON UL.EDAUSERID__c = A.Source_ce_student_success_coach__pc
WHERE UL.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Account_cecoach_Update_2'


-- learner_concierge__pc Lookup(User)
DROP TABLE Account_learncoach_Update_2
SELECT P.ID,UL.ID AS learner_concierge__pc
INTO Account_learncoach_Update_2
FROM [EDUCPROD].[dbo].[06_EDA_PersonAccount] A
INNER JOIN
[Account_Person_Rem_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
LEFT JOIN
[User] UL
ON UL.EDAUSERID__c = A.Source_learner_concierge__pc
WHERE UL.ID IS NOT NULL

SELECT * FROM Account_learncoach_Update_2_Result

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Account_learncoach_Update_2'

-- graduation_term__pc (Academic Term Lookup)
DROP TABLE Account_gradterm_Update_2
SELECT P.ID,A.ID AS graduation_term__pc,C.Source_graduation_term__pc
INTO Account_gradterm_Update_2
FROM [EDUCPROD].[dbo].[06_EDA_PersonAccount] C
LEFT JOIN [EDUCPROD].[dbo].[AcademicTerm_Lookup] A
ON A.Name = C.Source_graduation_term__pc
INNER JOIN
[Account_Person_Rem_Lookup] P
ON C.Legacy_Id__pc = P.Legacy_Id__pc
WHERE C.Source_graduation_term__pc IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Account_gradterm_Update'

SELECT * FROM Account_gradterm_Update_Result WHERE Error <> 'Operation Successful.'

-- term_of_interest__pc (Academic Term Lookup)
--DROP TABLE Account_TOI_Update
SELECT DISTINCT P.ID,A.ID AS graduation_term__pc
INTO Account_TOI_Update_2
FROM [EDUCPROD].[dbo].[06_EDA_PersonAccount] C
LEFT JOIN [EDUCPROD].[dbo].[AcademicTerm_Lookup] A
ON A.Name = C.Source_term_of_interest__pc
INNER JOIN
[Account_Person_Rem_Lookup] P
ON C.Legacy_Id__pc = P.Legacy_Id__pc
WHERE C.Source_term_of_interest__pc IS NOT NULL

SELECT * FROM Account_TOI_Update

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Account_TOI_Update'
