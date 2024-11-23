
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_RFI_Enrollment_LOAD];

SELECT *
INTO [EDUCPROD].dbo.Case_RFI_Enrollment_LOAD
FROM [EDUCPROD].[dbo].[dbo].[30_Case_Enrollment_RFI] C
ORDER BY ContactId


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_RFI_Enrollment_LOAD
ALTER COLUMN ID NVARCHAR(18)

SELECT * FROM Case_RFI_Enrollment_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Case_RFI_Enrollment_LOAD'

select * 
--into Case_RFI_Enrollment_2
from Case_RFI_Enrollment_LOAD_Result
where Error <> 'Operation Successful.'

--====================================================================
--	CREATE LOOKUP TABLE - Case
--====================================================================


INSERT INTO Case_RFI_Enrollment_Lookup
SELECT Id,Legacy_Id__c
FROM Case_RFI_Enrollment_LOAD_Result
WHERE Error = 'Operation Successful.'

select * from Case_RFI_Enrollment_Lookup

--====================================================================
--	UPDATE LOOKUPS - Case
--====================================================================

-- Recruitment Case source_RFI Update
SELECT A.Related_Recruitment_Case__c as Id,B.Id as Source_RFI_Case__c
INTO Case_Rec_RFI_Link_Update
FROM Case_RFI_Enrollment A
INNER JOIN
Case_RFI_Enrollment_Lookup B
ON A.Legacy_Id__c = B.Legacy_Id__c

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Rec_RFI_Link_Update'

select * from Case_Rec_RFI_Link_Update

-- Related Retention Case Update
SELECT A.Id,C.Id as Related_Retention_Case__c
INTO Case_RFI_Ret_Link_Update
FROM Case_RFI_Enrollment_Lookup A
INNER JOIN
[edaprod].[dbo].[Interaction__c] I
ON A.Legacy_Id__c = 'I-'+I.Id
LEFT JOIN [edaprod].[dbo].[Opportunity] Op
ON Op.Id = I.Opportunity__c AND Op.StageName = 'Enrolled'
LEFT JOIN
[edaprod].[dbo].[hed__Affiliation__c] Aff
ON Op.Affiliation__c = Aff.Id
LEFT JOIN
[Case] C
ON Aff.Id = C.Legacy_ID__c

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_RFI_Ret_Link_Update'
