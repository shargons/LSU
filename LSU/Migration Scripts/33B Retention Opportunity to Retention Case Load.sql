
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Case_Ret_Opp_Ret_Case_LOAD];

SELECT *
INTO [EDUCPROD].dbo.Case_Ret_Opp_Ret_Case_LOAD
FROM [EDUCPROD].[dbo].[34B_EDA_Ret_Opportunity] C
ORDER BY ContactId


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_Ret_Opp_Ret_Case_LOAD
ALTER COLUMN ID NVARCHAR(18)

SELECT * FROM Case_Ret_Opp_Ret_Case_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Case_Ret_Opp_Ret_Case_LOAD_2'

select * 
--into Case_Ret_Opp_Ret_Case_LOAD_2
from Case_Ret_Opp_Ret_Case_LOAD_2_Result
where Error <> 'Operation Successful.'
AND Error LIKE '%DUPLICATE%'

UPDATE Case_Ret_Opp_Ret_Case_LOAD_2
SET OwnerID = '005Hu00000RfrK4IAJ'
WHERE Error like '%ownerid%'

--====================================================================
--	CREATE LOOKUP TABLE - Case
--====================================================================
INSERT INTO Case_Ret_Opp_Ret_Case_Lookup
SELECT Id,Legacy_Id__c
--INTO Case_Ret_Opp_Ret_Case_Lookup
FROM Case_Ret_Opp_Ret_Case_LOAD_2_Result
WHERE Error = 'Operation Successful.'

select * from Case_Ret_Opp_Ret_Case_Lookup

--====================================================================
--	UPDATE LOOKUPS - Case
--====================================================================

-- Recruitment Case source_RFI Update

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




EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Ret_Opp_Link_Update'

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


