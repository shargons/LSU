
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_RFI_Enrollment_LOAD];

SELECT *
INTO [edcuat].dbo.Case_RFI_Enrollment_LOAD
FROM [edcuat].[dbo].[10_EDA_Interactions] C
ORDER BY ContactId


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_RFI_Enrollment_LOAD
ALTER COLUMN ID NVARCHAR(18)

SELECT * FROM Case_RFI_Enrollment_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','Case_RFI_Enrollment_LOAD'

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

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Rec_RFI_Link_Update'

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

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_RFI_Ret_Link_Update'

-- Related Opportunity Update
SELECT A.Id,O.Id as Related_Opportunity__c
INTO Case_RFI_Opp_Link_Update
FROM Case_RFI_Enrollment_Lookup A
INNER JOIN
[edaprod].[dbo].[Interaction__c] I
ON A.Legacy_Id__c = 'I-'+I.Id
LEFT JOIN [edaprod].[dbo].[Opportunity] Op
ON Op.Id = I.Opportunity__c AND Op.StageName = 'Enrolled'
LEFT JOIN
[Opportunity] O
ON O.Legacy_ID__c = Op.Id

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_RFI_Ret_Link_Update'


-- Recruitment Case Opportunity Update
SELECT A.Id,O.Id as Related_Opportunity__c,I.Id
--INTO Case_Rec_Opp_Link_Update
FROM [Case] A
INNER JOIN
[edaprod].[dbo].[Opportunity] I
ON A.Legacy_Id__c = I.Id
--LEFT JOIN [edaprod].[dbo].[Opportunity] Op
--ON Op.Id = I.
LEFT JOIN
[Opportunity] O
ON O.Legacy_ID__c = I.Id
WHERE a.Related_Opportunity__c is null

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Rec_Opp_Link_Update'



-- Retention Case Related Opportunity Load

SELECT Ret.Id,Op.Id as Related_Opportunity__c
--INTO Case_Ret_Opp_Link_Update
FROM [Case] Ret
INNER JOIN
[dbo].[14_EDA_Affiliations] I
ON Ret.Legacy_Id__c = I.Legacy_Id__c
LEFT JOIN
[edaprod].[dbo].[Opportunity] O
ON O.Affiliation__c = I.legacy_ID__c
LEFT JOIN
[Opportunity] Op
ON Op.Legacy_ID__c = O.Id
WHERE Ret.Related_Opportunity__c IS NULL

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Ret_Opp_Link_Update'

-- Retention Case Related Recruitment Case Load

SELECT A.Id,Rec.Id as Related_Recruitment_Case__c
--INTO Case_Ret_RecCase_Link_Update
FROM [Case] A
INNER JOIN
[dbo].[14_EDA_Affiliations] I
ON A.Legacy_Id__c = I.Legacy_Id__c
LEFT JOIN [edaprod].[dbo].[Opportunity] O
ON O.Affiliation__c = I.legacy_ID__c
LEFT JOIN [Case] Rec
on O.Id = Rec.Legacy_ID__c
WHERE A.Related_Recruitment_Case__c IS NULL


