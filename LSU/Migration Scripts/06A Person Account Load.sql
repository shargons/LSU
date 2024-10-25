
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Account
--====================================================================
--DROP TABLE IF EXISTS [dbo].[Account_Person_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.Account_Person_LOAD
FROM [edcuat].[dbo].[06_EDA_PersonAccount] C



/******* Check Load table *********/
SELECT * FROM [edcuat].dbo.Account_Person_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Account_Person_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','Account_Person_LOAD_5'

--DROP TABLE Account_Person_LOAD_2
SELECT * 
--INTO Account_Person_LOAD_5
FROM Account_Person_LOAD_5_Result where Error <> 'Operation Successful.'

UPDATE Account_Person_LOAD_5
SET PersonEmail = NULL
where Error LIKE 'STRING%'

select DISTINCT  Error from Account_Person_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Account
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Account_Person_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Account_Person_DELETE'

INSERT INTO Account_Person_DELETE(Id) SELECT Id FROM Account_Person_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Account_Person_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Account
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[Account_Person_Lookup];
--GO

INSERT INTO [edcuat].[dbo].[Account_Person_Lookup]
SELECT
 ID
,Legacy_Id__pc
--INTO [edcuat].[dbo].[Account_Person_Lookup]
FROM Account_Person_LOAD_5_Result
WHERE Error = 'Operation Successful.'




--====================================================================
--UPDATE LOOKUPS 
--====================================================================

-- Primary Academic Program Lookup(Learning Program)

-- enrollment_concierge__pc Lookup(User))
--DROP TABLE IF EXISTS [dbo].[Account_EConc_Update];
SELECT P.ID,UL.ID AS enrollment_concierge__pc
INTO Account_EConc_Update
FROM [edcuat].dbo.[06_EDA_PersonAccount] A
LEFT JOIN
[Account_Person_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
LEFT JOIN
User_Lookup UL
ON UL.Legacy_ID__c = A.Source_enrollment_concierge__pc
WHERE UL.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_EConc_Update'

SELECT * FROM Account_EConc_Update_Result WHERE Error <> 'Operation Successful.'


-- enrollment_coordinator__pc Lookup(User)
--DROP TABLE IF EXISTS [dbo].[Account_ECoord_Update];
SELECT P.ID,UL.ID AS enrollment_coordinator__pc
INTO Account_ECoord_Update
FROM [edcuat].[dbo].[06_EDA_PersonAccount] A
LEFT JOIN
[Account_Person_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
LEFT JOIN
User_Lookup UL
ON UL.Legacy_ID__c = A.Source_enrollment_coordinator__pc
WHERE UL.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_ECoord_Update'

select * from Account_ECoord_Update
where Id = '001KT0000041wT9YAI'


-- ext_classic_contact_id__pc Text(255)
--DROP TABLE Account_extcontact_Update
SELECT P.ID,A.ext_classic_contact_id__pc
INTO Account_extcontact_Update
FROM [edcuat].[dbo].[06_EDA_PersonAccount] A
LEFT JOIN
[Account_Person_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc

select * from Account_extcontact_Update

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_extcontact_Update'

-- ext_classic_lead_id__pc Text(255)
drop table Account_extlead_Update
SELECT P.ID,A.ext_classic_lead_id__pc
INTO Account_extlead_Update
FROM [edcuat].[dbo].[06_EDA_PersonAccount] A
LEFT JOIN
[Account_Person_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
WHERE A.ext_classic_lead_id__pc IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_extlead_Update'

-- ce_enrollment_coach__pc 	Lookup(User)
--DROP TABLE Account_Ecoach_Update
SELECT P.ID,UL.ID AS ce_enrollment_coach__pc
INTO Account_Ecoach_Update
FROM [edcuat].[dbo].[06_EDA_PersonAccount] A
LEFT JOIN
[Account_Person_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
LEFT JOIN
User_Lookup UL
ON UL.Legacy_ID__c = A.Source_ce_enrollment_coach__pc
WHERE UL.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_Ecoach_Update'

-- ce_enrollment_coordinator__pc Lookup(User)
--DROP TABLE Account_ceenr_Update
SELECT P.ID,UL.ID AS ce_enrollment_coordinator__pc
INTO Account_ceenr_Update
FROM [edcuat].[dbo].[06_EDA_PersonAccount] A
LEFT JOIN
[Account_Person_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
LEFT JOIN
User_Lookup UL
ON UL.Legacy_ID__c = A.Source_ce_enrollment_coordinator__pc
WHERE UL.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_ceenr_Update'

-- ce_student_success_coach__pc Lookup(User)
--DROP TABLE Account_cecoach_Update
SELECT P.ID,UL.ID AS ce_student_success_coach__pc
INTO Account_cecoach_Update
FROM [edcuat].[dbo].[06_EDA_PersonAccount] A
LEFT JOIN
[Account_Person_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
LEFT JOIN
User_Lookup UL
ON UL.Legacy_ID__c = A.Source_ce_student_success_coach__pc
WHERE UL.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_cecoach_Update'


-- learner_concierge__pc Lookup(User)
DROP TABLE Account_learncoach_Update
SELECT P.ID,UL.ID AS learner_concierge__pc
INTO Account_learncoach_Update
FROM [edcuat].[dbo].[06_EDA_PersonAccount] A
LEFT JOIN
[Account_Person_Lookup] P
ON A.Legacy_Id__pc = P.Legacy_Id__pc
LEFT JOIN
User_Lookup UL
ON UL.Legacy_ID__c = A.Source_learner_concierge__pc
WHERE UL.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_learncoach_Update'

-- graduation_term__pc (Academic Term Lookup)
DROP TABLE Account_gradterm_Update
SELECT P.ID,A.ID AS graduation_term__pc
INTO Account_gradterm_Update
FROM [edcuat].[dbo].[06_EDA_PersonAccount] C
LEFT JOIN [edcuat].[dbo].[AcademicTerm_Lookup] A
ON A.Name = C.Source_graduation_term__pc
LEFT JOIN
[Account_Person_Lookup] P
ON C.Legacy_Id__pc = P.Legacy_Id__pc

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_gradterm_Update'

-- term_of_interest__pc (Academic Term Lookup)

SELECT P.ID,A.ID AS graduation_term__pc
INTO Account_TOI_Update
FROM [edcuat].[dbo].[06_EDA_PersonAccount] C
LEFT JOIN [edcuat].[dbo].[AcademicTerm_Lookup] A
ON A.Name = C.Source_term_of_interest__pc
LEFT JOIN
[Account_Person_Lookup] P
ON C.Legacy_Id__pc = P.Legacy_Id__pc

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Account_TOI_Update'
